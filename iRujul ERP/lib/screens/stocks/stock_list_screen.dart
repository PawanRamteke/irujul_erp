import 'package:flutter/material.dart';
import 'package:irujul_erp/controllers/stock_controller.dart';
import 'package:get/get.dart';
import 'package:irujul_erp/screens/enquiry/add_enquiry_step_2_screen.dart';
import 'package:irujul_erp/utils/common_widgets/app_button.dart';
import 'package:irujul_erp/utils/common_widgets/app_card_widget.dart';
import 'package:irujul_erp/utils/common_widgets/app_loader.dart';
import 'package:irujul_erp/utils/common_widgets/app_text_field.dart';
import 'package:irujul_erp/utils/text_styles.dart';

class StockListScreen extends StatefulWidget {
  const StockListScreen({super.key});

  @override
  State<StockListScreen> createState() => _StockListScreenState();
}

class _StockListScreenState extends State<StockListScreen> {

  StockController stockController = Get.put(StockController());

  @override
  void initState() {
    stockController.selectedBusinessUnit = null;
    stockController.selectedCategory = null;
    stockController.selectedSubCategory = null;
    stockController.productController.text = "";
    stockController.getBusinessUnitApi();
    super.initState();
  }
  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          controller: stockController.scrollController,
          child: _bottomWidget(),
        ),
      )
    );
  }

  _bottomWidget() {
    return AppCardWidget(
      padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Select Branch", style: fontRegularStyle(fontWeight: FontWeight.w600, fontSize: 14)),
        const SizedBox(height: 10,),
        Container(
          width: double.infinity,
          height: 0.5,
          color: Colors.grey[400]!,
        ),
        const SizedBox(height: 10,),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            InkWell(
              onTap: (){
                FocusScope.of(context).unfocus();
                stockController.branch.value = 0;
              },
              child: Row(children: [
                Obx(() => Icon(stockController.branch.value == 0 ? Icons.radio_button_checked : Icons.radio_button_unchecked),),
                const SizedBox(width: 5,),
                const Text("Self Branch")
              ]),
            ),
            const SizedBox(width: 40,),
            InkWell(
              onTap: (){
                FocusScope.of(context).unfocus();
                stockController.branch.value = 1;
              },
              child: Row(children: [
                Obx(() => Icon(stockController.branch.value == 1 ? Icons.radio_button_checked : Icons.radio_button_unchecked),),
                const SizedBox(width: 5,),
                const Text("All Branch")
              ]),
            )
          ],
        ),
        const SizedBox(height: 20,),
        Obx(() => ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          padding: EdgeInsets.zero,
            itemCount: stockController.items.length,
            itemBuilder: (context, index)  {
              return ExpandableListItem(stockController.items[index], (model) {
                FocusScope.of(context).unfocus();
                if(index == 0) {
                  stockController.selectedBusinessUnit = model;
                  stockController.selectedCategory = null;
                }
                if(index == 1) {
                  stockController.selectedCategory = model;
                  stockController.selectedSubCategory = null;
                }if(index == 2) {
                  stockController.selectedSubCategory = model;
                }
                stockController.items[index].selectedValue = model;
                stockController.items.refresh();

                Future.delayed(const Duration(seconds: 1), (){
                  stockController.scrollToBottom();
                });
              });
            }
        )),
        const SizedBox(height: 20,),
        Text("Product Tag", style: fontRegularStyle(fontWeight: FontWeight.w600, fontSize: 14)),
        const SizedBox(height: 20,),
        AppTextField(
          controller: stockController.productController,
          placeholder: "Enter here",
          height: 50,
        ),
        const SizedBox(height: 20,),
        AppButton(btnName: "Get Data", onPressed: (){
          FocusScope.of(context).unfocus();
            getStockReport();
        })
      ],
    ));
  }

  getStockReport() async {
    AppLoader.show(context);
    bool status = await stockController.getStockReportApi();
    AppLoader.hide();
  }
}
