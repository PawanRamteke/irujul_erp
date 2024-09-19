import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irujul_erp/models/product_category_model.dart';
import 'package:irujul_erp/utils/app_manager.dart';
import 'package:irujul_erp/utils/colors.dart';
import 'package:irujul_erp/utils/common_widgets/app_button.dart';
import 'package:irujul_erp/utils/text_styles.dart';
class EnquiryProductList extends StatelessWidget {
  final List<ProductCategoryModel> productList;
  final Function(int) onSelect;
  final Function() onDone;
  const EnquiryProductList({super.key, required this.productList, required this.onSelect, required this.onDone});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 10),
          Text('Select Products',
            style: fontBoldStyle(fontSize: 18, color: appRedColor),
          ),
          const Divider(),
          // Product list with checkboxes
          ListView.builder(
              shrinkWrap: true,
              itemCount: productList.length,
              itemBuilder: (context, index) {
                final product = productList[index];
                return ListTile(
                  leading: Checkbox(
                    activeColor: primaryColor,
                    value: product.isSelected,
                    onChanged: (value) {
                      onSelect(index);
                     // productController.toggleSelection(index);
                    },
                  ),
                  title: Text(product.name ?? "", style:fontRegularStyle(fontSize: 13),),
                );
              },
          ),
          AppButton(btnName: "Done", width: 200, onPressed: () {
            List list = productList.where((p) => p.isSelected!).toList();
            if(list.isEmpty) {
              AppManager.showToast("Please select atleast one product");
              return;
            }
            onDone();
          }),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
