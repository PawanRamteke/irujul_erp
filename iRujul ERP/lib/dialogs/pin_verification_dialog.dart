
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irujul_erp/controllers/login_controller.dart';
import 'package:irujul_erp/utils/colors.dart';
import 'package:irujul_erp/utils/common_widgets/app_button.dart';
import 'package:irujul_erp/utils/text_styles.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

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
          Text("Verify Pin", style: fontBoldStyle(color: Colors.black, fontSize: 22)),
          SizedBox(height: 20,),
          Text("Enter server verification pin", style: fontRegularStyle(fontSize: 13),),
          SizedBox(height: 20,),
          _otpField(),
          SizedBox(height: 30,),
          AppButton(btnName: "Verify", width: 150, onPressed: (){
            loginController.verifyServerPinAPI(context);
          })
        ],
      ),
    );
  }

  _otpField() {
    double fieldSize = 50;
    return PinCodeTextField(
      appContext: Get.context!,
      length: 6,
      animationType: AnimationType.fade,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(5),
        fieldHeight: 55,
       // fieldWidth: 40,
        activeFillColor: Colors.white,
        inactiveFillColor: Colors.transparent,
        activeColor: primaryColor,
        inactiveColor: Colors.grey.withOpacity(0.5),
        selectedColor: Colors.grey.withOpacity(0.5),
        selectedFillColor: Colors.transparent
      ),
      cursorColor: Colors.black,
      animationDuration: const Duration(milliseconds: 300),
      enableActiveFill: true,
      controller: loginController.otpController,
      keyboardType: TextInputType.number,
      boxShadows: const [
        BoxShadow(
          offset: Offset(0, 1),
          color: Colors.black12,
          blurRadius: 10,
        )
      ],
      onCompleted: (v) {
        debugPrint("Completed");
      },
      onChanged: (value) {
        debugPrint(value);

      },
    );
  }
}
