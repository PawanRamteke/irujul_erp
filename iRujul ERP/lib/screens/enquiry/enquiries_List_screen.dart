import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:irujul_erp/controllers/add_enquiry_controller.dart';
import 'package:irujul_erp/controllers/enquiry_list_controller.dart';
import 'package:irujul_erp/models/enquiry_list_model.dart';
import 'package:irujul_erp/utils/app_manager.dart';
import 'package:irujul_erp/utils/colors.dart';
import 'package:irujul_erp/utils/common_widgets/app_card_widget.dart';
import 'package:irujul_erp/utils/common_widgets/app_text_field.dart';
import 'package:irujul_erp/utils/routes.dart';
import 'package:irujul_erp/utils/text_styles.dart';

class EnquiriesListScreen extends StatefulWidget {
  const EnquiriesListScreen({super.key});

  @override
  State<EnquiriesListScreen> createState() => _EnquiriesListScreenState();
}

class _EnquiriesListScreenState extends State<EnquiriesListScreen> {
  EnquiryListController  enquiryController = Get.put(EnquiryListController());

  @override
  void initState() {
    DateTime date = DateTime.now().subtract(const Duration(days: 1));
    enquiryController.startDate.text = DateFormat('dd/MM/yyyy').format(date);
    enquiryController.endDate.text = DateFormat('dd/MM/yyyy').format(DateTime.now());
    enquiryController.getEnquiryListApi();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(RouteName.addEnquiryStep1Screen);
        },
        shape: const CircleBorder(),
        backgroundColor: primaryColor,
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 20),
            child: Row(
              children: [
                Expanded(child: AppTextField(
                  controller: enquiryController.startDate,
                  placeholder: "Start Date",
                  isDatePicker: true,
                  lastDate: DateTime.now(),
                  onDateSelect: (){
                    enquiryController.getEnquiryListApi();
                  },
                )),
                const SizedBox(width: 20,),
                Expanded(child: AppTextField(
                  controller: enquiryController.endDate,
                  placeholder: "End Date",
                  isDatePicker: true,
                  lastDate: DateTime.now(),
                  onDateSelect: (){
                    enquiryController.getEnquiryListApi();
                  },
                )),
              ],
            ),
          ),
          Expanded(
              child: Obx(() => _enquiryList())
          )
        ],
      ),
    );
  }

  _enquiryList() {
   return enquiryController.arrEnquiryList.isEmpty ?
     const Center(child: Text("No data available"),) :
    ListView.builder(
        itemCount: enquiryController.arrEnquiryList.length,
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
            child: EnquiryListItem(model: enquiryController.arrEnquiryList.value[index])
          );
        }
    );
  }
}

class EnquiryListItem extends StatelessWidget {
  final EnquiryListModel model;
   const EnquiryListItem({super.key, required this.model,});
  @override
  Widget build(BuildContext context) {
   return InkWell(
     onTap: (){
       Get.toNamed(RouteName.updateEnquiryScreen, arguments: {"enquiryData": model});

     },
     child: AppCardWidget(
       padding: EdgeInsets.all(20),
       child:  Row(
         children: [
           Expanded(
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Row(
                   children: [
                     Text("Customer Name: ", style:  fontRegularStyle(fontSize: 14, fontWeight: FontWeight.w600),),
                     Expanded(child: Text(
                         model.header?.customerName ?? "-",
                       style: fontRegularStyle(fontSize: 14),
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
                       child: Text(model.header?.customerMobile ?? "-",
                         style: fontRegularStyle(fontSize: 14),
                       ),
                     ))
                   ],
                 ),
                 SizedBox(height: 5,),
                 Row(
                   children: [
                     Text("Transaction Date: ", style:  fontRegularStyle(fontSize: 14, fontWeight: FontWeight.w600),),
                     Expanded(child: Text(
                      AppManager().convertDateFormat( model.header?.tXNDate ?? "", "yyyy-MM-dd", "dd/MM/yyyy"),
                       style: fontRegularStyle(fontSize: 14),
                     ))
                   ],
                 ),
                 const SizedBox(height: 5,),
                 Row(
                   children: [
                     Text("Status: ", style:  fontRegularStyle(fontSize: 14, fontWeight: FontWeight.w600),),
                     Container(
                       decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(5),
                         color: model.header?.status == "Closed" ? Colors.green : primaryColor,
                       ),
                       padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 3),
                       child: Text(
                         model.header?.status ?? "-",
                         style: fontRegularStyle(fontSize: 12),
                       ),
                     )
                   ],
                 ),
               ],
             ),
           ),
           //Container(color: Colors.yellow,width: 20, height: 20,)
           const Icon(Icons.arrow_forward_ios_outlined,color: Colors.grey,)
         ],
       )
     ),
   );
  }
  
}
