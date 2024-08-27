import 'dart:ui';

import 'package:flip_card/flip_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:irujul_erp/controllers/login_controller.dart';
import 'package:irujul_erp/dialogs/pin_verification_dialog.dart';
import 'package:irujul_erp/utils/colors.dart';
import 'package:irujul_erp/utils/common_widgets/app_button.dart';
import 'package:irujul_erp/utils/common_widgets/app_card_widget.dart';
import 'package:irujul_erp/utils/common_widgets/app_checkbox_button.dart';
import 'package:irujul_erp/utils/common_widgets/app_text_field.dart';
import 'package:irujul_erp/utils/routes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginController loginController = Get.put(LoginController());

  @override
  void initState() {
    super.initState();
    //loginController.userName.text = "rnr_api_test";
    //loginController.password.text = "Rnr_api_test_13rt";
    _showPinVerificationDialog();
  }

  _showPinVerificationDialog() async {
    await Future.delayed(const Duration(milliseconds: 50));
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return PinVerificationDialog();
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: appBGColor,
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 50,),
                        SizedBox(
                          width: double.infinity,
                          height: 90,
                          child: Image.asset("assets/images/rujul-logo-login.png"),
                        ),
                        SizedBox(height: 30,),
                        FlipCard(
                            key: loginController.cardKey,
                            flipOnTouch: false,
                            fill: Fill.fillBack,
                            direction: FlipDirection.HORIZONTAL,
                            front: _loginWidget(),
                            back: _selectCompanyAndBranchWidget()
                        )
                      ],
                    ),
                  )
              ),
              Text("copyright_text".tr)
            ],
          ),
        ),
      ),
    );
  }

  _loginWidget() {
    return Container(
      margin: EdgeInsets.all(20),
      child: Stack(
        children: [
          AppCardWidget(
              margin: EdgeInsets.only(left: 10),
              padding: EdgeInsets.all(20),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 60,),
                  AppTextField(
                    controller: loginController.userName,
                    placeholder: "Username".tr,
                  ),
                  SizedBox(height: 20,),
                  AppTextField(
                      controller: loginController.password,
                      placeholder: "Password".tr,
                    secureText: true,
                  ),
                  SizedBox(height: 20,),
                  Obx(() =>
                      AppCheckboxButton(title: "Remember_me".tr, isSelected: loginController.rememberMe.value, onTap: (){
                        loginController.rememberMe.value = !loginController.rememberMe.value;
                      },
                  ),),
                  SizedBox(height: 20,),
                  Center(
                    child: AppButton(btnName: "Login".tr, width: 200, onPressed: (){
                      //Get.offAllNamed(RouteName.dashboardScreen);
                      loginController.loginAPI(context);
                    }),
                  )
                ],
              )
          ),
          Container(
            margin: const EdgeInsets.only(top: 20),
            width: 80,
            height: 40,
            color: primaryColor,
            child: const Center(
              child: Text("Login", style: TextStyle(fontWeight: FontWeight.w600),),
            ),
          ),
          // Container(
          //   margin: const EdgeInsets.only(top: 60),
          //   width: 10,
          //   height: 10,
          //   child: Image.asset("assets/images/login-tab-corner.png", fit: BoxFit.fill,),
          // ),
        ],
      ),
    );
  }

  _selectCompanyAndBranchWidget() {
    return AppCardWidget(
      margin: EdgeInsets.only(left: 20, right: 20),
      width: double.infinity,
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Select Company and Branch",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18
              ),
            ),
            SizedBox(height: 30,),
            AppTextField(placeholder: "Company", isDropDown: true, onTap: (){
             // showCompanyDropDownList();
            },),
            SizedBox(height: 20,),
            AppTextField(controller: loginController.branch, placeholder: "Branch", isDropDown: true, onTap: (){
             loginController.showBranchDropDownList();
            },),
            SizedBox(height: 20,),
            AppButton(btnName: "Continue", width: 200, onPressed: (){
            //  cardKey.currentState?.toggleCard();
            })
          ],
        ),
      ),
    );
  }
}
