import 'dart:ui';

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
    _showPinVerificationDialog();
  }

  _showPinVerificationDialog() async {
    await Future.delayed(const Duration(milliseconds: 50));
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return const PinVerificationDialog();
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
                        SizedBox(height: 10,),
                        Container(
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
                                      AppTextField(placeholder: "Username".tr),
                                      SizedBox(height: 20,),
                                      AppTextField(placeholder: "Password".tr),
                                      SizedBox(height: 20,),
                                      AppTextField(
                                        placeholder: "Company".tr,
                                        isDropDown: true,
                                        onTap: (){
                                          loginController.showCompanyDropDownList();
                                        },
                                      ),
                                      SizedBox(height: 20,),
                                      AppTextField(
                                        placeholder: "Branch".tr,
                                        isDropDown: true,
                                        onTap: (){
                                          loginController.showBranchDropDownList();
                                        },
                                      ),
                                      SizedBox(height: 20,),
                                      AppCheckboxButton(title: "Remember_me".tr),
                                      SizedBox(height: 20,),
                                      Center(
                                        child: AppButton(btnName: "Login".tr, width: 100, onPressed: (){
                                          Get.offAllNamed(RouteName.dashboardScreen);
                                        }),
                                      )
                                    ],
                                  )
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 20),
                                width: 80,
                                height: 40,
                                color: appGreenColor,
                                child: const Center(
                                  child: Text("Login", style: TextStyle(fontWeight: FontWeight.w600),),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 60),
                                width: 10,
                                height: 10,
                                child: Image.asset("assets/images/login-tab-corner.png", fit: BoxFit.fill,),
                              ),
                            ],
                          ),
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
}
