import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irujul_erp/controllers/add_enquiry_controller.dart';
import 'package:irujul_erp/models/product_category_model.dart';
import 'package:irujul_erp/utils/common_widgets/app_loader.dart';
import 'package:irujul_erp/utils/routes.dart';

import '../utils/colors.dart';
import '../utils/common_widgets/app_button.dart';
import '../utils/common_widgets/app_card_widget.dart';
import '../utils/common_widgets/app_text_field.dart';
import '../utils/common_widgets/customer_registration_steps.dart';

class AddEnquiryStep2Screen extends StatefulWidget {
  const AddEnquiryStep2Screen({Key? key}) : super(key: key);

  @override
  State<AddEnquiryStep2Screen> createState() => _AddEnquiryStep2ScreenState();
}

class _AddEnquiryStep2ScreenState extends State<AddEnquiryStep2Screen> {

  AddEnquiryController addEnquiryController = Get.put(AddEnquiryController());

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 100),() {
      getCategoryApi();
    });
    super.initState();
  }
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
            children: [
              CustomerRegistrationSteps(currentSteps: const [0,1]),
              const Text("Product Details", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),),
              SizedBox(height: 20,),
              Expanded(
                child: Obx(() => ListView.builder(
                  itemCount: addEnquiryController.items.length,
                  itemBuilder: (BuildContext context, int index) {
                    return  ExpandableListItem(addEnquiryController.items[index], (model) {
                      if(index == 0)  {
                        addEnquiryController.selectedCategory = model;
                      } else if(index == 1) {
                        addEnquiryController.selectedBrand = model;
                      } else if(index == 2) {
                        addEnquiryController.selectedFamily = model;
                      } else if(index == 3) {
                        addEnquiryController.selectedCapacity = model;
                      }
                      addEnquiryController.items[index].selectedValue = model;
                      addEnquiryController.items.refresh();
                    });
                  },
                ))
              ),
              AppButton(btnName: "Next", onPressed: (){
                Get.toNamed(RouteName.addEnquiryStep3Screen);
              })
            ],
          ),
        )
      ),
    );
  }

  getCategoryApi() async {
    AppLoader.show(context);
    dynamic response = await addEnquiryController.getCategoryApi();
    AppLoader.hide();
  }
}
class Item {
  final String headerValue;
  final List<ProductCategoryModel> expandedValue;
  ProductCategoryModel? selectedValue;
  Item( {
    this.selectedValue,
    required this.headerValue,
    required this.expandedValue,
  });
}

class ExpandableListItem extends StatefulWidget {
  final Item item;
  final Function(ProductCategoryModel model) onSelect;
  const ExpandableListItem(this.item, this.onSelect, {super.key});

  @override
  _ExpandableListItemState createState() => _ExpandableListItemState();
}

class _ExpandableListItemState extends State<ExpandableListItem> {

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment:  MainAxisAlignment.center,
            children: [
              Text(widget.item.headerValue, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
              const SizedBox(height: 10,),
              Container(
                width: double.infinity,
                height: 0.5,
                color: Colors.grey[400]!,
              )
            ],
          ),
        ),
          const SizedBox(height: 10,),
          Padding( //outer spacing
            padding: const EdgeInsets.all(0.0),
            child: Wrap(
              alignment: WrapAlignment.start,
              spacing: 0, // space between items
              children: widget.item.expandedValue.map((e) =>
                  GestureDetector(
                    onTap: () {
                      widget.onSelect(e);
                    },
                    child: Container(
                      margin: const EdgeInsets.all(5),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: widget.item.selectedValue == e ? primaryColor : Colors.white,
                        borderRadius: BorderRadius.circular(40),
                        border: Border.all(color: Colors.grey[300]!)
                      ),
                      child: Text(e.name ?? ""),
                    ),
                  ))
                  .toList(),
            ),
          ),
        const SizedBox(height: 20,),
      ],
    );
  }
}