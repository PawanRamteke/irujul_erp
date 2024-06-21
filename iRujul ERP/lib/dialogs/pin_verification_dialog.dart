import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:irujul_erp/utils/colors.dart';
import 'package:irujul_erp/utils/common_widgets/app_button.dart';

class PinVerificationDialog extends StatelessWidget {
  const PinVerificationDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.all(20),
      alignment: Alignment.center,
      child: _dialogContent(),
    );
  }

  _dialogContent() {
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
            cursorColor: appGreenColor,
            focusedBorderColor: appGreenColor,
            textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            onCodeChanged: (code){

            },
            onSubmit: (code){
            },
          ),
          SizedBox(height: 30,),
          AppButton(btnName: "Verify", width: 150, onPressed: (){
            Get.back(closeOverlays: true);

          })
        ],
      ),
    );
  }
}
