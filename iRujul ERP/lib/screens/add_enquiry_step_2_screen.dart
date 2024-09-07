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
  void dispose() {
    addEnquiryController.selectedItems.clear();
    super.dispose();
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
                      } else if(index == 4) {
                        addEnquiryController.selectedColor = model;
                      }
                      addEnquiryController.items[index].selectedValue = model;
                      addEnquiryController.items.refresh();
                    });
                  },
                ))
              ),
              Obx(() => addEnquiryController.selectedItems.isNotEmpty ?
              AppCardWidget(
                //color: Colors.grey[400],
                height: 210,
                padding: EdgeInsets.only(bottom: 10),
                child: Column(
                  children: [
                    SizedBox(
                      height: 40,
                      child: Row(
                        children: [
                          const SizedBox(width: 110, child: Text("Code",textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold),)),
                          Container( width: 1, height: 40, color: Colors.grey,),
                          const Expanded(child: Text("Name",textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold),),),
                          Container( width: 1, height: 40, color: Colors.grey,),
                          Container(width: 70 , child: const Text("Action",textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold),))
                        ],
                      ),
                    ),
                    Container(
                      height: 1,
                      color: Colors.grey,
                    ),
                    Expanded(child: ListView.builder(
                        itemCount: addEnquiryController.selectedItems.length,
                        itemBuilder: (context, index)  {
                          ProductCategoryModel model = addEnquiryController.selectedItems.value[index];
                          return Container(
                            height: 40,
                            child: Column(
                              children: [
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      SizedBox(width: 110, child: Text(model.code ?? "-",textAlign: TextAlign.center, style: TextStyle(fontSize: 12),)),
                                      Container( width: 1, height: 40, color: Colors.grey,),
                                      Expanded(child: Text(model.name ?? "-",textAlign: TextAlign.center,style: TextStyle(fontSize: 12),)),
                                      Container(width: 1, height: 40, color: Colors.grey,),
                                      SizedBox(
                                        width: 70,
                                        child: Center(
                                          child: InkWell(
                                            onTap: (){
                                              addEnquiryController.selectedItems.value.removeAt(index);
                                              addEnquiryController.selectedItems.refresh();
                                            },
                                            child: SizedBox(
                                              width: 30,
                                              height: 30,
                                              child: Image.asset("assets/images/ic_remove.png"),
                                            ),
                                          ),
                                                                                )
                                      )
                                    ],
                                  ),
                                ),
                                Container(height: 1,color: Colors.grey,),
                              ],
                            ),
                          );
                        }
                    )),
                    SizedBox(height: 20,),
                    AppButton(
                      width: 200,
                      btnName: "Next",
                      onPressed: (){
                        Get.toNamed(RouteName.addEnquiryStep3Screen);
                      }
                    )
                  ],
                ),
              ) : Container())
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