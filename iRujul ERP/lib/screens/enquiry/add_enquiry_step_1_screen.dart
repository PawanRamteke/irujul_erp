import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irujul_erp/controllers/add_enquiry_controller.dart';
import 'package:irujul_erp/utils/colors.dart';
import 'package:irujul_erp/utils/common_widgets/app_button.dart';
import 'package:irujul_erp/utils/common_widgets/app_card_widget.dart';
import 'package:irujul_erp/utils/common_widgets/app_text_field.dart';
import 'package:irujul_erp/utils/common_widgets/customer_registration_steps.dart';
import 'package:irujul_erp/utils/routes.dart';
import 'package:irujul_erp/utils/text_styles.dart';

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
        title: Text("Add Enquiry", style: fontSemiBoldStyle(fontSize: 18),),
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
              Text("Customer Details",
                style: fontRegularStyle(fontWeight: FontWeight.w600, fontSize: 12),),
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
            placeholder: "Mobile Number*",
            maxLength: 10,
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            onTextChange: (text){
              if(text.length == 10)  {
                addEnquiryController.getCustomerDetailsApi();
              } else {
                // addEnquiryController.dataReceivedFromApi.value = false;
                // addEnquiryController.name.text = "";
                // addEnquiryController.gender.text = "";
                // addEnquiryController.state.text = "";
                // addEnquiryController.city.text = "";
                // addEnquiryController.zipcode.text = "";
              }
            },
          ),
          const SizedBox(height: 10,),
          Obx(() => AppTextField(
            makeDisable: addEnquiryController.dataReceivedFromApi.value,
            controller: addEnquiryController.name,
            placeholder: "Customer Name*",
            textInputAction: TextInputAction.next,
          ),),
          const SizedBox(height: 10,),
          AppTextField(
            controller: addEnquiryController.gender,
            placeholder: "Gender*",
            isDropDown:  true,
            textInputAction: TextInputAction.next,
            onTap: () {
              addEnquiryController.showGenderDropDown();
            }
          ),
          const SizedBox(height: 10,),
          AppTextField(
            controller: addEnquiryController.state,
            placeholder: "State*",
            textInputAction: TextInputAction.next,
            isDropDown: true,
            onTap: () {
              addEnquiryController.showStateDropDown();
            },
          ),
          const SizedBox(height: 10,),
          AppTextField(
            controller: addEnquiryController.city,
            placeholder: "City*",
            isDropDown: true,
            textInputAction: TextInputAction.next,
            onTap: () {
              addEnquiryController.showCityDropDown();
            },
          ),
          const SizedBox(height: 10,),
          AppTextField(
            controller: addEnquiryController.zipcode,
            placeholder: "Zip Code*",
            keyboardType:  TextInputType.number,
            textInputAction: TextInputAction.done,
            maxLength: 6,
          ),
        ],
      ),
    );
  }
}
