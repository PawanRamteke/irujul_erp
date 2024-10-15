import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irujul_erp/models/stock_report_model.dart';
import 'package:irujul_erp/utils/colors.dart';
import 'package:irujul_erp/utils/common_widgets/app_card_widget.dart';
import 'package:irujul_erp/utils/text_styles.dart';
class StockProductListWidget extends StatelessWidget {
  final List<StockReportModel> arrList;
  const StockProductListWidget({super.key, required this.arrList});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[100],
      height: MediaQuery.sizeOf(context).height - 105,
      child: Column(
        children: [
          _navigationBar(),
          const SizedBox(height: 10,),
          Expanded(child: _productList())
        ],
      ),
    );
  }

  _navigationBar() {
    return Container(
      height: 50,
      color: primaryColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(width: 50,),
          Text("Products", style: fontRegularStyle(fontWeight: FontWeight.w600, fontSize: 16),),
          IconButton(onPressed: (){
            Get.back();
          }, icon: const Icon(Icons.close)
          )
        ],
      ),
    );
  }

  _productList() {
    return ListView.builder(
      itemCount: arrList.length,
      itemBuilder: (context, index) {
        return StockProductItem(model: arrList[index],);
      }
    );
  }
}

class StockProductItem extends StatelessWidget {
  final StockReportModel model;
  const StockProductItem({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return AppCardWidget(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            color: primaryColor.withAlpha(50),
            padding: const EdgeInsets.all(10.0),
            child: Text(model.item ?? "-",
              style: fontRegularStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(height: 5,),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: Text("Quantity", style: fontBoldStyle(fontSize: 14), )),
                Expanded(child: Text("MRP", style: fontBoldStyle(fontSize: 14),textAlign: TextAlign.center,)),
                Expanded(child: Text("Branch", style: fontBoldStyle(fontSize: 14), textAlign: TextAlign.end,)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: Text("${getFormattedQuantity(model.quantity ?? "0")}", style: fontBoldStyle(fontSize: 14), )),
                Expanded(child: Text("Rs.${getFormattedMrp(model.mRP ?? "0")}", style: fontBoldStyle(fontSize: 14),textAlign: TextAlign.center,)),
                Expanded(child: Text(model.branchName ?? "-", style: fontBoldStyle(fontSize: 14),textAlign: TextAlign.end, maxLines: 1,)),
              ],
            ),
          ),
          SizedBox(height: 10,)
        ],
      )
    );
  }

  getFormattedQuantity(String qty) {
    double number = double.parse(qty);
    String result = number.toStringAsFixed(0);
    return result;
  }
  
  getFormattedMrp(String mrp) {
    double number = double.parse(mrp);
    String result = number.toStringAsFixed(1); 
    return result;
  }
}