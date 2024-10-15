import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:irujul_erp/models/stock_report_model.dart';
import 'package:irujul_erp/screens/stocks/widget/stock_product_list_widget.dart';
import 'package:irujul_erp/utils/ApiManager/Repository/repository.dart';
import 'package:irujul_erp/utils/app_manager.dart';
import 'package:irujul_erp/utils/routes.dart';

import '../models/product_category_model.dart';
import '../screens/enquiry/add_enquiry_step_2_screen.dart';

class StockController extends GetxController {
  AppRepository appRepository = AppRepository();
  final RxList<Item> items = RxList<Item>();
  RxInt branch = 0.obs;

  ScrollController scrollController = ScrollController();
  TextEditingController productController = TextEditingController();

  ProductCategoryModel? _selectedBusinessUnit;
  set selectedBusinessUnit(ProductCategoryModel? value) {
    _selectedBusinessUnit = value;
    if(value != null) {
      getCategoryApi();
    }
  }

  ProductCategoryModel? _selectedCategory;
  set selectedCategory(ProductCategoryModel? value) {
    _selectedSubCategory = null;
    _selectedCategory = value;
    if(value != null) {
      getSubCategoryApi();
    }
  }

  ProductCategoryModel? _selectedSubCategory;
  set selectedSubCategory(ProductCategoryModel? value) {
    _selectedSubCategory = value;
  }

  List<StockReportModel> arrStockReport = [];

  getBusinessUnitApi() async {
    dynamic response = await appRepository.getBusinessUnitAPI();
    List<ProductCategoryModel> arrBusinessUnit = [];
    items.clear();
    if(response != null && response["Data"] != null) {
      List<dynamic> list = response["Data"];
      for (var json in list) {
        arrBusinessUnit.add(ProductCategoryModel.fromJson(json));
      }
      items.add(Item(headerValue: "Business Unit", expandedValue: arrBusinessUnit));
      items.refresh();
    }
    return response;
  }

  getCategoryApi() async {
    dynamic response = await appRepository.getCategoryAPI();
    List<ProductCategoryModel> arrCategories = [];
    items.removeWhere((item) => item.headerValue == "Category");
    items.removeWhere((item) => item.headerValue == "Sub Category");

    if(response != null && response["Data"] != null) {
      List<dynamic> list = response["Data"];
      for (var json in list) {
        arrCategories.add(ProductCategoryModel.fromJson(json));
      }
      items.add(Item(headerValue: "Category", expandedValue: arrCategories));
      items.refresh();
    }
    return response;
  }

  getSubCategoryApi() async {
    dynamic response = await appRepository.getSubCategoryAPI(_selectedCategory?.iD ?? "");
    List<ProductCategoryModel> arrSubCategory = [];
    items.removeWhere((item) => item.headerValue == "Sub Category");
    if(response["Data"] != null) {
      List<dynamic> list = response["Data"];
      for (var json in list) {
        arrSubCategory.add(ProductCategoryModel.fromJson(json));
      }
      items.add(Item(headerValue: "Sub Category", expandedValue: arrSubCategory));
      items.refresh();
    }
    return response;
  }

  getStockReportApi() async {
    if(_selectedBusinessUnit == null) {
      AppManager.showToast("Please select business unit");
      return false;
    }
    if(productController.text.trim().isEmpty) {
      AppManager.showToast("Please enter product tag");
      return false;
    }

    dynamic request = {
      "module":"item_stock_count",
      "isBranch": 1,
      "BranchRefCode": branch.value == 0 ? AppManager().loginModel?.branchAPIRefCode : "",
      "business_unit": _selectedBusinessUnit?.iD,
      "category": _selectedCategory?.iD ?? "",
      "sub_category": _selectedSubCategory?.iD ?? "",
      "produckMappingType":0,
      "items": productController.text
    };
    dynamic response = await appRepository.getStockReportAPI(request);
    arrStockReport.clear();
    if(response["Data"] != null) {
      List<dynamic> list = response["Data"];
      for (var json in list) {
        arrStockReport.add(StockReportModel.fromJson(json));
      }
    }
    if(arrStockReport.isNotEmpty) {
      showProductList();
    } else {
      AppManager.showToast("No products found!");
    }
    return true;
  }
  showProductList() {
    Get.bottomSheet(StockProductListWidget(arrList: arrStockReport,), isScrollControlled: true, isDismissible: false);
  }

  void scrollToBottom() {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 100),
      curve: Curves.easeOut,
    );
  }
}
