import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:irujul_erp/controllers/update_enquiry_controller.dart';
import 'package:irujul_erp/models/enquiry_list_model.dart';
import 'package:irujul_erp/utils/colors.dart';
import 'package:irujul_erp/utils/common_widgets/app_button.dart';
import 'package:irujul_erp/utils/common_widgets/app_card_widget.dart';
import 'package:irujul_erp/utils/common_widgets/app_loader.dart';
import 'package:irujul_erp/utils/common_widgets/app_text_field.dart';

import '../utils/app_manager.dart';
import '../utils/text_styles.dart';

class UpdateEnquiryScreen extends StatefulWidget {
  const UpdateEnquiryScreen({Key? key}) : super(key: key);

  @override
  State<UpdateEnquiryScreen> createState() => _UpdateEnquiryScreenState();
}

class _UpdateEnquiryScreenState extends State<UpdateEnquiryScreen> {
  UpdateEnquiryController updateEnquiryController = Get.put(UpdateEnquiryController());

  @override
  void initState() {
    final args = Get.arguments;
    updateEnquiryController.model = args["enquiryData"];
    updateEnquiryController.getFollowUpStageApi();
    updateEnquiryController.getLeadCategoryApi();
    updateEnquiryController.getLostReasonApi();

    updateEnquiryController.followUpDate.text = DateFormat('dd/MM/yyyy').format(DateTime.now());
    updateEnquiryController.followUpTime.text = DateFormat('hh:mm').format(DateTime.now());

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Enquiry", style: fontSemiBoldStyle(fontSize: 18)),
        backgroundColor: primaryColor,
      ),
      body: SafeArea(
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _customerDetails(),
                  SizedBox(height: 20,),
                  _productDetails(),
                  SizedBox(height: 20,),
                  _nextFollowupDetails()
                ],
              ),
            ),
          )
      ),
    );
  }

  _customerDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Customer Details", style: fontRegularStyle(fontWeight: FontWeight.w600, fontSize: 15),),
        SizedBox(height: 10,),
        AppCardWidget(
            padding: EdgeInsets.all(10),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text("Name: ", style:  fontRegularStyle(fontSize: 14, fontWeight: FontWeight.w600),),
                    Expanded(child: Text(
                      updateEnquiryController.model?.header?.customerName ?? "-",
                      style: fontRegularStyle(fontSize: 16),
                    ))
                  ],
                ),
                SizedBox(height: 5,),
                Row(
                  children: [
                    Text("Mobile No: ", style:  fontRegularStyle(fontSize: 14, fontWeight: FontWeight.w600),),
                    Expanded(child: InkWell(
                      onTap: () {

                      },
                      child: Text(
                        updateEnquiryController.model?.header?.customerMobile ?? "-",
                        style: fontRegularStyle(fontSize: 16),
                      ),
                    ))
                  ],
                ),
                SizedBox(height: 5,),
                Row(
                  children: [
                    Text("Transaction Date: ", style:  fontRegularStyle(fontSize: 14, fontWeight: FontWeight.w600),),
                    Expanded(child: Text(
                      AppManager().convertDateFormat( updateEnquiryController.model?.header?.tXNDate ?? "", "yyyy-MM-dd", "dd/MM/yyyy"),
                      style: fontRegularStyle(fontSize: 16),
                    ))
                  ],
                ),
                SizedBox(height: 5,),
                Row(
                  children: [
                    Text("Status: ", style:  fontRegularStyle(fontSize: 14, fontWeight: FontWeight.w600),),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: updateEnquiryController.model?.header?.status == "Closed" ? Colors.green : primaryColor,
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 3),
                      child: Text(
                        updateEnquiryController.model?.header?.status ?? "-",
                        style: fontRegularStyle(fontSize: 12),
                      ),
                    )
                  ],
                ),
              ],
            ),
        )
      ],
    );
  }

  _productDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Product Details", style: fontRegularStyle(fontWeight: FontWeight.w600, fontSize: 15),),
        SizedBox(height: 10,),
        AppCardWidget(
          borderRadius: 0,
          height: 40,
         // color: Colors.grey[300]!,
          child:Column(
            children: [
              Expanded(
                child: Row(
                  children: [
                    SizedBox(width: 110, child: Text("Item Code",textAlign: TextAlign.center, style: fontRegularStyle(fontWeight: FontWeight.w600),)),
                    Container( width: 1, height: 40, color: Colors.grey,),
                    Expanded(child: Text("Item Name",textAlign: TextAlign.center, style: fontRegularStyle(fontWeight: FontWeight.w600),),),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                height: 1,
                color: Colors.grey,
              )
            ],
          ),
        ),
        ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
          itemCount: updateEnquiryController.model?.line?.length ?? 0,
            itemBuilder: (context,index) {
              return ProductDetailsItem(item: updateEnquiryController.model!.line![index],);
            }
        )
      ],
    );
  }

  _nextFollowupDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Next Follow up Details", style: fontRegularStyle(fontWeight: FontWeight.w600, fontSize: 15),),
        SizedBox(height: 10,),
        AppCardWidget(
          padding: EdgeInsets.all(20),
            child: Column(
              children: [
                AppTextField(
                  controller: updateEnquiryController.followUpStage,
                  placeholder: "Follow Up Stage",
                  isDropDown: true,
                  onTap: () {
                    updateEnquiryController.showFollowupStagesDropDown();
                  },
                ),
                const SizedBox(height: 10,),
                Obx(() => Visibility(
                  visible: updateEnquiryController.isLostStage.value,
                  child: Column(
                    children: [
                      AppTextField(
                        controller: updateEnquiryController.lostReason,
                        placeholder: "Lost Reason",
                        isDropDown: true,
                        onTap: () {
                          updateEnquiryController.showLostReasonDropDown();
                        },
                      ),
                      const SizedBox(height: 10,),
                    ],
                  ),
                )),
                // AppTextField(
                //   controller: updateEnquiryController.followUpDate,
                //   placeholder: "Follow Up Date",
                //   isDatePicker: true,
                // ),
                // const SizedBox(height: 10,),
                // AppTextField(
                //     controller: updateEnquiryController.followUpTime,
                //     placeholder: "Follow Up Time",
                //   isTimePicker: true,
                // ),
               // const SizedBox(height: 10,),
                Obx(() => Visibility(
                    visible: !(updateEnquiryController.isLostStage.value || updateEnquiryController.isWonStage.value),
                    child: Column(
                      children: [
                        AppTextField(
                          controller: updateEnquiryController.nextFollowUpDate,
                          placeholder: "Next Follow Up Date",
                          isDatePicker: true,
                        ),
                        const SizedBox(height: 10,),
                        AppTextField(
                          controller: updateEnquiryController.nextFollowUpTime,
                          placeholder: "Next Follow Up Time",
                          isTimePicker: true,
                        ),
                        const SizedBox(height: 10,),
                        AppTextField(
                          controller: updateEnquiryController.expectedClosureDate,
                          placeholder: "Expected Closure Date",
                          isDatePicker: true,
                        ),
                        const SizedBox(height: 10,),
                      ],
                    )
                ),),
                AppTextField(
                  controller: updateEnquiryController.category,
                  placeholder: "Category",
                  isDropDown: true,
                  onTap: () {
                    updateEnquiryController.showLeadCategoryDropDown();
                  },
                ),
                const SizedBox(height: 10,),
                AppTextField(
                  controller: updateEnquiryController.progress,
                  placeholder: "Progress %",
                  keyboardType: TextInputType.number,
                  maxLength: 3,
                  makeDisable: true,
                ),
                const SizedBox(height: 10,),
                AppTextField(
                  controller: updateEnquiryController.remark,
                  placeholder: "Remark",
                  maxLines: 4,
                  height: 100,
                ),
                const SizedBox(height: 30,),
                AppButton(btnName: "Update", onPressed: () {
                  _updateEnquiryApi();
                })
              ],
            )
        )
      ],
    );
  }

  _updateEnquiryApi()  async{
    FocusScope.of(context).unfocus();
    AppLoader.show(context);
    bool status = await updateEnquiryController.updateEnquiryApi();
    AppLoader.hide();
    if(status) {
      Get.back();
    }
  }
}

class ProductDetailsItem extends StatelessWidget {
  final Line? item;
  const ProductDetailsItem({super.key, this.item});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          color: Colors.grey[300],
          child: Row(
            children: [
              SizedBox(width: 110, child: Text(item?.itemCode ?? "",textAlign: TextAlign.center, style: fontRegularStyle(fontSize: 12),)),
              Container( width: 1,height: 40, color: Colors.grey,),
              Expanded(child: Text(item?.itemName ?? "",textAlign: TextAlign.center, style: fontRegularStyle(fontSize: 12))),
            ],
          ),
        ),
        Container(height: 1, width: double.infinity,color: Colors.grey,)
      ],
    );
  }
  
}
