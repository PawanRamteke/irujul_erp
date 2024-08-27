
import 'package:get/get.dart';
import 'package:irujul_erp/models/product_category_model.dart';
import 'package:irujul_erp/screens/add_enquiry_step_2_screen.dart';
import 'package:irujul_erp/utils/ApiManager/Repository/repository.dart';

class AddEnquiryController extends GetxController {
  // List of items
  final RxList<Item> items = RxList<Item>();

  AppRepository appRepository = AppRepository();

  ProductCategoryModel? _selectedCategory;
  set selectedCategory(ProductCategoryModel value) {
    _selectedCategory = value;
    getBrandApi();
  }

  ProductCategoryModel? _selectedBrand;
  set selectedBrand(ProductCategoryModel value) {
    _selectedBrand = value;
    getProductFamilyApi();
  }

  ProductCategoryModel? _selectedFamily;
  set selectedFamily(ProductCategoryModel value) {
    _selectedFamily = value;
    getProductCapacityApi();
  }

  ProductCategoryModel? _selectedCapacity;
  set selectedCapacity(ProductCategoryModel value) {
    _selectedCapacity = value;
    getProductColorApi();
  }

  getCategoryApi() async {
    dynamic response = await appRepository.getCategoryAPI();
    List<ProductCategoryModel> arrCategories = [];
    items.clear();
    if(response["Data"] != null) {
      List<dynamic> list = response["Data"];
      for (var json in list) {
        arrCategories.add(ProductCategoryModel.fromJson(json));
      }
      items.add(Item(headerValue: "Business Unit", expandedValue: arrCategories));
      items.refresh();
    }
    return response;
  }

  getBrandApi() async {
    dynamic response = await appRepository.getBrandApi(_selectedCategory?.iD ?? "");
    List<ProductCategoryModel> arrBrands = [];
    items.removeWhere((item) => item.headerValue == "Brands");
    items.removeWhere((item) => item.headerValue == "Family");
    items.removeWhere((item) => item.headerValue == "Capacity");
    items.removeWhere((item) => item.headerValue == "Color");
    if(response["Data"] != null) {
      List<dynamic> list = response["Data"];
      for (var json in list) {
        arrBrands.add(ProductCategoryModel.fromJson(json));
      }
      items.add(Item(headerValue: "Brands", expandedValue: arrBrands));
      items.refresh();
    }
    return response;
  }

  getProductFamilyApi() async {
    dynamic response = await appRepository.getProductFamilyApi(_selectedCategory?.iD ?? "", _selectedBrand?.iD ?? "");
    List<ProductCategoryModel> arrFamily = [];
    items.removeWhere((item) => item.headerValue == "Family");
    items.removeWhere((item) => item.headerValue == "Capacity");
    items.removeWhere((item) => item.headerValue == "Color");
    if(response["Data"] != null) {
      List<dynamic> list = response["Data"];
      for (var json in list) {
        ProductCategoryModel model = ProductCategoryModel.fromJson(json);
        model.name = model.productfamily;
        arrFamily.add(model);
      }
      items.add(Item(headerValue: "Family", expandedValue: arrFamily));
      items.refresh();
    }
    return response;
  }

  getProductCapacityApi() async {
    dynamic response = await appRepository.getProductCapacityApi(_selectedCategory?.iD ?? "", _selectedBrand?.iD ?? "", _selectedFamily?.iD ?? "");
    List<ProductCategoryModel> arrCapacity = [];
    items.removeWhere((item) => item.headerValue == "Capacity");
    items.removeWhere((item) => item.headerValue == "Color");
    if(response["Data"] != null) {
      List<dynamic> list = response["Data"];
      for (var json in list) {
        ProductCategoryModel model = ProductCategoryModel.fromJson(json);
        model.name = model.capacity;
        arrCapacity.add(model);
      }
      items.add(Item(headerValue: "Capacity", expandedValue: arrCapacity));
      items.refresh();
    }
    return response;
  }

  getProductColorApi() async {
    dynamic response = await appRepository.getProductColorApi(_selectedCategory?.iD ?? "", _selectedBrand?.iD ?? "", _selectedFamily?.iD ?? "", _selectedCapacity?.iD ?? "");
    List<ProductCategoryModel> arrCapacity = [];
    items.removeWhere((item) => item.headerValue == "Color");
    if(response["Data"] != null) {
      List<dynamic> list = response["Data"];
      for (var json in list) {
        ProductCategoryModel model = ProductCategoryModel.fromJson(json);
        model.name = model.color;
        arrCapacity.add(model);
      }
      items.add(Item(headerValue: "Color", expandedValue: arrCapacity));
      items.refresh();
    }
    return response;
  }

}