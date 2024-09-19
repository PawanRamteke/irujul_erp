import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irujul_erp/controllers/add_enquiry_controller.dart';
import 'package:irujul_erp/utils/common_widgets/app_button.dart';
import 'package:irujul_erp/utils/common_widgets/app_card_widget.dart';
import 'package:irujul_erp/utils/common_widgets/app_checkbox_button.dart';
import 'package:irujul_erp/utils/common_widgets/app_loader.dart';
import 'package:irujul_erp/utils/common_widgets/app_text_field.dart';
import 'package:irujul_erp/utils/routes.dart';
import 'package:irujul_erp/utils/text_styles.dart';

import '../../utils/colors.dart';
import '../../utils/common_widgets/customer_registration_steps.dart';


class AddEnquiryStep3Screen extends StatefulWidget {
  const AddEnquiryStep3Screen({Key? key}) : super(key: key);

  @override
  State<AddEnquiryStep3Screen> createState() => _AddEnquiryStep3ScreenState();
}

class _AddEnquiryStep3ScreenState extends State<AddEnquiryStep3Screen> {
  AddEnquiryController addEnquiryController = Get.put(AddEnquiryController());

  @override
  void initState() {
    addEnquiryController.getLeadCategoryApi();
    addEnquiryController.getSourceApi();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Enquiry", style: fontSemiBoldStyle(fontSize: 18),),
        backgroundColor: primaryColor,
      ),
      body: SafeArea(
       child: Container(
         padding: EdgeInsets.all(20),
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.end,
           children: [
             CustomerRegistrationSteps(currentSteps: const [0,1,2]),
             Text("Enquiry Details", style: fontRegularStyle(fontWeight: FontWeight.w600, fontSize: 12),),
             SizedBox(height: 20,),
             Expanded(child: Container(
               child: SingleChildScrollView(
                 child: AppCardWidget(
                     padding: EdgeInsets.all(20),
                     child: Column(
                       children: [
                         Obx(() => AppCheckboxButton(title: "Yes, I am interested in Apple Care & Protection Plan.",
                             isSelected: addEnquiryController.isInterestedInAppleCare.value,
                             onTap: (){
                               addEnquiryController.isInterestedInAppleCare.value = !addEnquiryController.isInterestedInAppleCare.value;
                             }
                         )),
                         SizedBox(height: 20,),
                         Obx(()  => AppCheckboxButton(title: "Yes, I want to exchange my old Device.",
                             isSelected: addEnquiryController.isExchangeDevice.value,
                             onTap: (){
                               addEnquiryController.isExchangeDevice.value = !addEnquiryController.isExchangeDevice.value;
                             }
                         )),
                         SizedBox(height: 20,),
                         Obx(()  => AppCheckboxButton(title: "Yes, I like to buy with finance.",
                             isSelected: addEnquiryController.isLikeToBuyWithFinance.value,
                             onTap: (){
                               addEnquiryController.isLikeToBuyWithFinance.value = !addEnquiryController.isLikeToBuyWithFinance.value;
                             }
                         )),
                         SizedBox(height: 20,),
                         Obx(() => AppCheckboxButton(title: "OutStraight purchase.",
                             isSelected: addEnquiryController.isOutstraightPurchase.value,
                             onTap: (){
                               addEnquiryController.isOutstraightPurchase.value = !addEnquiryController.isOutstraightPurchase.value;
                             }
                         )),
                         SizedBox(height: 40,),
                         AppTextField(
                           controller: addEnquiryController.source,
                           placeholder: "Source",
                           isDropDown: true,
                           onTap: () {
                             addEnquiryController.showSourceDropDown();
                           },
                         ),

                         SizedBox(height: 20,),
                         AppTextField(
                           controller: addEnquiryController.category,
                           placeholder: "Category",
                           isDropDown: true,
                           onTap: () {
                             addEnquiryController.showLeadCategoryDropDown();
                           },
                         ),

                         SizedBox(height: 20,),
                         AppTextField(
                           controller: addEnquiryController.remark,
                           placeholder: "Remark",
                           maxLines: 4,
                           height: 100,
                         ),

                         SizedBox(height: 20,),
                         AppButton(btnName: "Submit", onPressed: (){
                           _createEnquiryApi();
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

  _createEnquiryApi() async {
    AppLoader.show(context);
    bool status = await addEnquiryController.createEnquiryApi();
    AppLoader.hide();
    if(status) {
      Get.offAllNamed(RouteName.dashboardScreen, arguments: {"from": "add_enquiry"});
    }
  }
}
