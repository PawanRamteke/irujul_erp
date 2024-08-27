import 'package:flutter/material.dart';
import 'package:irujul_erp/utils/common_widgets/app_button.dart';
import 'package:irujul_erp/utils/common_widgets/app_card_widget.dart';
import 'package:irujul_erp/utils/common_widgets/app_checkbox_button.dart';
import 'package:irujul_erp/utils/common_widgets/app_text_field.dart';

import '../utils/colors.dart';
import '../utils/common_widgets/customer_registration_steps.dart';

class AddEnquiryStep3Screen extends StatefulWidget {
  const AddEnquiryStep3Screen({Key? key}) : super(key: key);

  @override
  State<AddEnquiryStep3Screen> createState() => _AddEnquiryStep3ScreenState();
}

class _AddEnquiryStep3ScreenState extends State<AddEnquiryStep3Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Enquiry"),
        backgroundColor: primaryColor,
      ),
      body: SafeArea(
       child: Container(
         padding: EdgeInsets.all(20),
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.end,
           children: [
             CustomerRegistrationSteps(currentSteps: const [0,1,2]),
             const Text("Enquiry Details", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),),
             SizedBox(height: 20,),
             Expanded(child: Container(
               child: SingleChildScrollView(
                 child: AppCardWidget(
                     padding: EdgeInsets.all(20),
                     child: Column(
                       children: [
                         AppCheckboxButton(title: "Yes, I am interested in Apple Care & Protection Plan.",
                             isSelected: false,
                             onTap: (){

                             }),
                         SizedBox(height: 20,),
                         AppCheckboxButton(title: "Yes, I like to buy with finance.",
                             isSelected: false,
                             onTap: (){

                             }),
                         SizedBox(height: 20,),
                         AppCheckboxButton(title: "OutStraight purchase.",
                             isSelected: false,
                             onTap: (){

                             }),
                         SizedBox(height: 40,),
                         AppTextField(placeholder: "Next Follow Up Date"),

                         SizedBox(height: 20,),
                         AppTextField(placeholder: "Next Follow Up Time"),

                         SizedBox(height: 20,),
                         AppTextField(placeholder: "Expected Closure Date"),

                         SizedBox(height: 20,),
                         AppTextField(placeholder: "Source"),

                         SizedBox(height: 20,),
                         AppTextField(placeholder: "Sub Source"),

                         SizedBox(height: 20,),
                         AppTextField(placeholder: "Industry Type"),

                         SizedBox(height: 20,),
                         AppTextField(placeholder: "Remark", ),

                         SizedBox(height: 20,),
                         AppButton(btnName: "Submit", onPressed: (){

                         })
                       ],
                     )
                 ),
               ),
             )
             )
           ],
         ),
       )
      ),
    );
  }
}
