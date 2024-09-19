import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:irujul_erp/controllers/sales_customer_controller.dart';
import 'package:irujul_erp/utils/colors.dart';
import 'package:irujul_erp/utils/common_widgets/app_button.dart';
import 'package:irujul_erp/utils/common_widgets/app_checkbox_button.dart';
import 'package:irujul_erp/utils/common_widgets/app_text_field.dart';
import 'package:irujul_erp/utils/common_widgets/customer_registration_steps.dart';
import 'package:irujul_erp/utils/text_styles.dart';

class SalesCustomerScreen extends StatefulWidget {
  const SalesCustomerScreen({Key? key}) : super(key: key);

  @override
  State<SalesCustomerScreen> createState() => _SalesCustomerScreenState();
}

class _SalesCustomerScreenState extends State<SalesCustomerScreen> {
  final PageController _controller = PageController(initialPage: 0, keepPage: false);
  SalesCustomerController salesCustomerController = Get.put(SalesCustomerController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Customer", style: fontSemiBoldStyle(fontSize: 18),),
      ),
      body: Column(
        children: [
          SizedBox(height: 10,),
         Obx(() => CustomerRegistrationSteps(currentSteps: [salesCustomerController.currentPage.value])),
          Expanded(
           child: PageView(
             physics: NeverScrollableScrollPhysics(),
             controller: _controller,
             children: [
               _generalDetails(),
               _additionalDetails(),
               _addressDetails(),
               _contactDetails()
             ],
           )
          )
        ],
      ),
    );
  }

  _generalDetails() {
    return Container(
      child: Column(
        children: [
          _header("General Details"),
          Expanded(
              child: Container(
                padding: EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      AppTextField(placeholder: "Code"),
                      SizedBox(height: 10,),
                      Row(
                        children: [
                          SizedBox(width: 120, child: AppTextField(placeholder: "Select", isDropDown: true,)),
                          SizedBox(width: 10,),
                          Expanded(child: AppTextField(placeholder: "First Name",))
                        ],
                      ),
                      SizedBox(height: 10,),
                      AppTextField(placeholder: "Alternate Number"),
                      SizedBox(height: 10,),
                      AppTextField(placeholder: "Billing Cycle", isDropDown: true,),
                      SizedBox(height: 10,),
                      AppTextField(placeholder: "Industry Type", isDropDown: true,),
                      SizedBox(height: 10,),
                      AppTextField(placeholder: "Contact Type", isDropDown: true,),
                      SizedBox(height: 10,),
                      AppTextField(placeholder: "Account"),
                      SizedBox(height: 10,),
                      AppTextField(placeholder: "COD Account", isDropDown: true,),
                      SizedBox(height: 10,),
                      AppTextField(placeholder: "Pay To"),
                      SizedBox(height: 10,),
                      AppTextField(placeholder: "Branch", isDropDown: true,),
                      SizedBox(height: 20,),
                      AppCheckboxButton(title: "Is InActive", isSelected: false, onTap: (){

                      },),
                      SizedBox(height: 20,),
                      AppButton(btnName: "NEXT", width: 120, onPressed: (){
                        _animateToPage(1);
                      }),
                      SizedBox(height: 30,)
                    ],
                  ),
                ),
              )
          )
        ],
      ),
    );
  }

  _additionalDetails() {
    return Container(
      child: Column(
        children: [
          _header("Additional Details"),
          Expanded(
              child: Container(
                padding: EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      AppTextField(placeholder: "Date of Birth"),
                      SizedBox(height: 10,),
                      AppTextField(placeholder: "Marital Status", isDropDown: true,),
                      SizedBox(height: 10,),
                      AppTextField(placeholder: "Anniversary Date"),
                      SizedBox(height: 10,),
                      AppTextField(placeholder: "Default Executive", isDropDown: true,),
                      SizedBox(height: 10,),
                      AppTextField(placeholder: "Gender", isDropDown: true,),
                      SizedBox(height: 10,),
                      AppTextField(placeholder: "Age Group", isDropDown: true,),
                      SizedBox(height: 10,),
                      AppTextField(placeholder: "Customer Group", isDropDown: true,),
                      SizedBox(height: 10,),
                      AppTextField(placeholder: "Income Group", isDropDown: true,),
                      SizedBox(height: 10,),
                      AppTextField(placeholder: "Referred By"),
                      SizedBox(height: 10,),
                      AppCheckboxButton(title: "As Ledger", isSelected: false,onTap: () {},),
                      SizedBox(height: 10,),
                      AppCheckboxButton(title: "Allow Credit Sale", isSelected: false,onTap: () {},),
                      SizedBox(height: 10,),
                      AppCheckboxButton(title: "Tax Exempted", isSelected: false,onTap: () {},),
                      SizedBox(height: 10,),
                      AppCheckboxButton(title: "Hide Transferable Amount", isSelected: false,onTap: () {},),
                      SizedBox(height: 30,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AppButton(btnName: "PREVIOUS", width: 120, onPressed: (){
                            _animateToPage(0);
                          }),
                          SizedBox(width: 20,),
                          AppButton(btnName: "NEXT", width: 120, onPressed: (){
                            _animateToPage(2);
                          }),
                        ],
                      ),
                      SizedBox(height: 30,)
                    ],
                  ),
                ),
              )
          )
        ],
      ),
    );
  }

  _addressDetails() {
    return Container(
      child: Column(
        children: [
          _header("Address Details"),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    AppTextField(placeholder: "Address Type", isDropDown: true,),
                    SizedBox(height: 10,),
                    AppTextField(placeholder: "Address"),
                    SizedBox(height: 10,),
                    AppTextField(placeholder: "City"),
                    SizedBox(height: 10,),
                    AppTextField(placeholder: "State"),
                    SizedBox(height: 10,),
                    AppTextField(placeholder: "Country"),
                    SizedBox(height: 10,),
                    AppTextField(placeholder: "Zip Code"),
                    SizedBox(height: 10,),
                    AppTextField(placeholder: "Email"),
                    SizedBox(height: 10,),
                    AppTextField(placeholder: "Alternate Email"),
                    SizedBox(height: 10,),
                    AppTextField(placeholder: "Website"),
                    SizedBox(height: 10,),
                    AppTextField(placeholder: "Remark/Note"),
                    SizedBox(height: 10,),
                    AppCheckboxButton(title: "Allow Email", isSelected: false,onTap: () {},),
                    SizedBox(height: 30,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AppButton(btnName: "PREVIOUS", width: 120, onPressed: (){
                          _animateToPage(1);
                        }),
                        SizedBox(width: 20,),
                        AppButton(btnName: "NEXT", width: 120, onPressed: (){
                          _animateToPage(3);
                        }),
                      ],
                    ),
                    SizedBox(height: 30,)
                  ],
                )
              )
            )
          )
        ]
     ),
    );
  }

  _contactDetails() {
    return Container(
      child: Column(
        children: [
          _header("Contact Details"),
          Expanded(child: Container(
            padding: EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  AppTextField(placeholder: "Mobile Number 1"),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      AppButton(btnName: "Verify", width: 100, height: 40, onPressed: (){}),
                      SizedBox(width: 10,),
                      AppCheckboxButton(title: "Is OTP Verify", isSelected: false,onTap: () {},)
                    ],
                  ),
                  SizedBox(height: 10,),
                  AppTextField(placeholder: "Mobile Number 2"),
                  SizedBox(height: 10,),
                  AppTextField(placeholder: "Phone Number 1"),
                  SizedBox(height: 10,),
                  AppTextField(placeholder: "Phone Number 2"),
                  SizedBox(height: 10,),
                  AppCheckboxButton(title: "Allow SMS", isSelected: false,onTap: () {},),
                  SizedBox(height: 10,),
                  Container(
                    height: 100,
                    color: Colors.yellow,
                  )
                ],
              ),
            ),
          ))
        ],
      ),
    );
  }
  
  _header(String title) {
    return Container(
     // margin: EdgeInsets.only(left: 20, right: 20),
      padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
      width: double.infinity,
      color: primaryColor,
      child: Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
    );
  }

  _animateToPage(int pageNo) {
    salesCustomerController.currentPage.value = pageNo;
    _controller.animateToPage(pageNo, duration: const Duration(milliseconds: 500), curve: Curves.linear);
  }
}
