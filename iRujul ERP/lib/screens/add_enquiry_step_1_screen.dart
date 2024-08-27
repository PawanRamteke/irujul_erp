import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irujul_erp/utils/colors.dart';
import 'package:irujul_erp/utils/common_widgets/app_button.dart';
import 'package:irujul_erp/utils/common_widgets/app_card_widget.dart';
import 'package:irujul_erp/utils/common_widgets/app_text_field.dart';
import 'package:irujul_erp/utils/common_widgets/customer_registration_steps.dart';
import 'package:irujul_erp/utils/routes.dart';

class AddEnquiryStep1Screen extends StatefulWidget {
  const AddEnquiryStep1Screen({super.key});

  @override
  State<AddEnquiryStep1Screen> createState() => _AddEnquiryStep1ScreenState();
}

class _AddEnquiryStep1ScreenState extends State<AddEnquiryStep1Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Enquiry"),
        backgroundColor: primaryColor,
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomerRegistrationSteps(currentSteps: [0]),
            Text("Customer Details",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),),
            SizedBox(height: 20,),
            SingleChildScrollView(
                child: Column(
                  children: [
                    _customerDetails(),
                    SizedBox(height: 20,),
                    AppButton(btnName: "Next", onPressed: () {
                      Get.toNamed(RouteName.addEnquiryStep2Screen);
                    })
                  ],
                )
            )
          ],
        ),
      ),
    );
  }

  _customerDetails() {
    return AppCardWidget(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          AppTextField(
            placeholder: "Mobile Number",
            maxLength: 10,
            keyboardType: TextInputType.number,
          ),
          SizedBox(height: 10,),
          AppTextField(placeholder: "Customer Name"),
          SizedBox(height: 10,),
          AppTextField(placeholder: "Gender"),
          SizedBox(height: 10,),
          AppTextField(placeholder: "City"),
          SizedBox(height: 10,),
          AppTextField(placeholder: "State"),
          SizedBox(height: 10,),
          AppTextField(placeholder: "Zip Code"),
        ],
      ),
    );
  }
}
