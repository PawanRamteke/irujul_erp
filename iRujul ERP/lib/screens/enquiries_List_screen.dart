import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:irujul_erp/controllers/add_enquiry_controller.dart';
import 'package:irujul_erp/models/enquiry_list_model.dart';
import 'package:irujul_erp/utils/app_manager.dart';
import 'package:irujul_erp/utils/colors.dart';
import 'package:irujul_erp/utils/common_widgets/app_card_widget.dart';
import 'package:irujul_erp/utils/common_widgets/app_text_field.dart';
import 'package:irujul_erp/utils/routes.dart';

class EnquiriesListScreen extends StatefulWidget {
  const EnquiriesListScreen({super.key});

  @override
  State<EnquiriesListScreen> createState() => _EnquiriesListScreenState();
}

class _EnquiriesListScreenState extends State<EnquiriesListScreen> {
  AddEnquiryController  addEnquiryController = Get.put(AddEnquiryController());

  @override
  void initState() {
    DateTime date = DateTime.now().subtract(const Duration(days: 30));
    addEnquiryController.startDate.text = DateFormat('dd/MM/yyyy').format(date);
    addEnquiryController.endDate.text = DateFormat('dd/MM/yyyy').format(DateTime.now());
    addEnquiryController.getEnquiryListApi();
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
                  controller: addEnquiryController.startDate,
                  placeholder: "Start Date",
                  isDatePicker: true,
                  onDateSelect: (){
                    addEnquiryController.getEnquiryListApi();
                  },
                )),
                const SizedBox(width: 20,),
                Expanded(child: AppTextField(
                  controller: addEnquiryController.endDate,
                  placeholder: "End Date",
                  isDatePicker: true,
                  onDateSelect: (){
                    addEnquiryController.getEnquiryListApi();
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
   return addEnquiryController.arrEnquiryList.isEmpty ?
     const Center(child: Text("No data available"),) :
    ListView.builder(
        itemCount: addEnquiryController.arrEnquiryList.length,
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
            child: EnquiryListItem(model: addEnquiryController.arrEnquiryList.value[index])
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
                     const Text("Customer Name: ", style:  TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                     Expanded(child: Text(
                         model.header?.customerName ?? "-",
                       style: TextStyle(fontSize: 16),
                     ))
                   ],
                 ),
                 SizedBox(height: 5,),
                 Row(
                   children: [
                     const Text("Mobile No: ", style:  TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                     Expanded(child: InkWell(
                       onTap: () {

                       },
                       child: Text(
                         model.header?.customerMobile ?? "-",
                         style: TextStyle(fontSize: 16),
                       ),
                     ))
                   ],
                 ),
                 SizedBox(height: 5,),
                 Row(
                   children: [
                     const Text("Transaction Date: ", style:  TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                     Expanded(child: Text(
                      AppManager().convertDateFormat( model.header?.tXNDate ?? "", "yyyy-MM-dd", "dd/MM/yyyy"),
                       style: TextStyle(fontSize: 16),
                     ))
                   ],
                 ),
                 SizedBox(height: 5,),
                 Row(
                   children: [
                     const Text("Status: ", style:  TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                     Container(
                       decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(5),
                         color:  Colors.green,
                       ),
                       padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 3),
                       child: Text(
                         model.header?.status ?? "-",
                         style: const TextStyle(fontSize: 12),
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
