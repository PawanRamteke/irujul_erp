import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irujul_erp/controllers/add_enquiry_controller.dart';
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

  AddEnquiryController addEnquiryController = Get.put(AddEnquiryController());

  @override
  void initState() {
    addEnquiryController.getStateListApi();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text("Add Enquiry"),
        backgroundColor: primaryColor,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomerRegistrationSteps(currentSteps: [0]),
              const Text("Customer Details",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),),
              SizedBox(height: 20,),
              Expanded(
                child: SingleChildScrollView(
                    child: Column(
                      children: [
                        _customerDetails(),
                        SizedBox(height: 20,),
                        AppButton(btnName: "Next", onPressed: () {
                          FocusScope.of(context).requestFocus(FocusNode());
                          if(addEnquiryController.validateForStep1()) {
                            Get.toNamed(RouteName.addEnquiryStep2Screen);
                          }
                        })
                      ],
                    )
                ),
              )
            ],
          ),
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
            controller: addEnquiryController.mobileNo,
            placeholder: "Mobile Number",
            maxLength: 10,
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 10,),
          AppTextField(
            controller: addEnquiryController.name,
            placeholder: "Customer Name"
          ),
          const SizedBox(height: 10,),
          AppTextField(
            controller: addEnquiryController.gender,
            placeholder: "Gender",
            isDropDown:  true,
            onTap: () {
              addEnquiryController.showGenderDropDown();
            }
          ),
          const SizedBox(height: 10,),
          AppTextField(
            controller: addEnquiryController.state,
            placeholder: "State",
            isDropDown: true,
            onTap: () {
              addEnquiryController.showStateDropDown();
            },
          ),
          const SizedBox(height: 10,),
          AppTextField(
            controller: addEnquiryController.city,
            placeholder: "City",
            isDropDown: true,
            onTap: () {
              addEnquiryController.showCityDropDown();
            },
          ),
          const SizedBox(height: 10,),
          AppTextField(
            controller: addEnquiryController.zipcode,
            placeholder: "Zip Code",
            keyboardType:  TextInputType.number,
            maxLength: 6,
          ),
        ],
      ),
    );
  }
}
