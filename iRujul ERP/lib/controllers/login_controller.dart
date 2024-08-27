import 'package:flip_card/flip_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:irujul_erp/models/branch_model.dart';
import 'package:irujul_erp/models/login_model.dart';
import 'package:irujul_erp/utils/ApiManager/Repository/repository.dart';
import 'package:irujul_erp/utils/ApiManager/prefernces.dart';
import 'package:irujul_erp/utils/app_manager.dart';
import 'package:irujul_erp/utils/common_widgets/app_button.dart';
import 'package:irujul_erp/utils/common_widgets/app_loader.dart';
import 'package:irujul_erp/utils/common_widgets/app_text_field.dart';
import 'package:irujul_erp/utils/routes.dart';

class LoginController extends GetxController {
  AppRepository appRepository = AppRepository();

  TextEditingController userName = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController company = TextEditingController();
  TextEditingController branch = TextEditingController();
  Rx<bool> rememberMe = false.obs;

  List<String> arrCompany = [];
  List<BranchModel> arrBranch = [];
  String serverPin = "";

  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();

  showBranchDropDownList() {
    List<String> branches = arrBranch.expand((element) => {element.branchName ?? ""}).toList();
    AppManager.shared.showActionSheet(branches,"Select Branch", (index) => {
        branch.text = branches[index]
    });
  }

  showSelectBranchView() {
    Get.bottomSheet(
      isDismissible: false,
      Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          padding: EdgeInsets.all(20),
          height: 300,
          child: Column(
            children: [
              const Text(
                  "Select Branch",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18
                ),
              ),
              SizedBox(height: 30,),
              AppTextField(controller: branch,placeholder: "Branch", isDropDown: true, onTap: (){
                showBranchDropDownList();
              },),
              SizedBox(height: 30,),
              AppButton(btnName: "Continue", width: 200, onPressed: (){
                if(branch.text.isEmpty) {
                  AppManager.showToast("Please select branch");
                  return;
                }
                BranchModel selBranch = arrBranch.firstWhere((element) => element.branchName == branch.text!);
                AppManager.shared.branchModel = selBranch;
                Get.back(closeOverlays: true);
                Get.offAllNamed(RouteName.dashboardScreen);
              })
            ],
          ),
        ),
      )
    );
  }


  verifyServerPinAPI(BuildContext context) async {
    FocusManager.instance.primaryFocus?.unfocus();
    if(validateServerPin()) {
      AppLoader.show(context);
      dynamic response = await appRepository.verifyServerPinAPI(serverPin);
      AppLoader.hide();
      if(response == null) {
        AppManager.showToast("Something went wrong. Please contact administrator");
        return;
      }
      if(response["error"] != null) {
        AppManager.showToast(response["error"]["message"]);
      } else {
        if(response["status"] == 200 && response["Data"] != null) {
          Preferences.saveClientServerData(response["Data"]);
          AppManager.shared.appUrl = response["Data"]["ClientURL"];
          AppManager.showToast(response["message"]);
          Get.back(closeOverlays: true);
        } else {
          AppManager.showToast("Something is wrong! Please try again.");
        }
      }
    }
  }

  loginAPI(BuildContext context) async {
    FocusManager.instance.primaryFocus?.unfocus();
    if(validateForLogin()) {
      AppLoader.show(context);
      dynamic response = await appRepository.loginAPI(userName.text, password.text);
      AppLoader.hide();
      if(response["error"] != null) {
        AppManager.showToast(response["error"]["message"]);
      } else {
        if (response["status"] == 200 && response["Data"] != null) {
          AppManager.showToast(response["message"]);
          AppManager.shared.loginModel = LoginModel.fromJson(response["Data"]);
          await Preferences.saveAcceessToken(AppManager.shared.loginModel!.accessToken!);
         // showSelectBranchView();
         // cardKey.currentState?.toggleCard();
          getUserRecordsApi("user_branch", context);
        }
      }
    }
  }

  getUserRecordsApi(String module, BuildContext context) async {
    AppLoader.show(context);
    dynamic response = await appRepository.getRecordsAPI(module);
    List<dynamic> arrData = response["Data"];
    if(arrData != null) {
      for (var element in arrData) {
        arrBranch.add(BranchModel.fromJson(element));
      }
    }
    if(arrBranch.length == 1) {
      AppManager.shared.branchModel = arrBranch[0];
      Get.offAllNamed(RouteName.dashboardScreen);
    } else {
      showSelectBranchView();
    }
    AppLoader.hide();
  }

  validateServerPin() {
    if(serverPin.length < 6) {
      AppManager.showToast("Please enter valid server pin");
      return false;
    }
    return true;
  }

  validateForLogin() {
    if(userName.text.isEmpty)  {
      AppManager.showToast("Please enter username");
      return false;
    }
    if(password.text.isEmpty)  {
      AppManager.showToast("Please enter password");
      return false;
    }
    return true;
  }
}