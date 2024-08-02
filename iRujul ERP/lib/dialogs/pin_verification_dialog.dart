
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:irujul_erp/controllers/login_controller.dart';
import 'package:irujul_erp/utils/colors.dart';
import 'package:irujul_erp/utils/common_widgets/app_button.dart';

class PinVerificationDialog extends StatelessWidget {
  PinVerificationDialog({super.key});
  LoginController loginController = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.all(20),
      alignment: Alignment.center,
      child: _dialogContent(context),
    );
  }

  _dialogContent(BuildContext context) {
    return Container(
      height: 300,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Verify Pin", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
          SizedBox(height: 20,),
          Text("Enter server verification pin"),
          SizedBox(height: 20,),
          OtpTextField(
            margin: EdgeInsets.only(left: 5,right: 5),
            numberOfFields: 6,
            showFieldAsBox: true,
            cursorColor: appRedColor,
            focusedBorderColor: appRedColor,
            textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            onCodeChanged: (code){
              if(code.isNotEmpty) {
                loginController.serverPin = loginController.serverPin + code;
              } else {
                loginController.serverPin = loginController.serverPin.substring(0, loginController.serverPin.length - 1);
              }
            },
          ),
          SizedBox(height: 30,),
          AppButton(btnName: "Verify", width: 150, onPressed: (){
            loginController.verifyServerPinAPI(context);
          })
        ],
      ),
    );
  }
}
