
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:irujul_erp/dialogs/enquiry_product_list.dart';
import 'package:irujul_erp/models/product_category_model.dart';
import 'package:irujul_erp/screens/enquiry/add_enquiry_step_2_screen.dart';
import 'package:irujul_erp/utils/ApiManager/Repository/repository.dart';
import 'package:irujul_erp/utils/app_manager.dart';

class AddEnquiryController extends GetxController {
  // List of items
  final RxList<Item> items = RxList<Item>();

  AppRepository appRepository = AppRepository();

  ScrollController scrollController = ScrollController();

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

  ProductCategoryModel? _selectedColor;
  set selectedColor(ProductCategoryModel value) {
    _selectedColor = value;
    getItemInfoApi();
  }

  RxList<ProductCategoryModel> productList = RxList<ProductCategoryModel>();
  RxList<ProductCategoryModel> selectedItems = RxList<ProductCategoryModel>();

  TextEditingController mobileNo = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController gender = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController zipcode = TextEditingController();

  RxBool isInterestedInAppleCare = false.obs;
  RxBool isLikeToBuyWithFinance = false.obs;
  RxBool isOutstraightPurchase = false.obs;
  RxBool isExchangeDevice = false.obs;

  TextEditingController nextFollowupDate = TextEditingController();
  TextEditingController nextFollowupTime = TextEditingController();
  TextEditingController expectedClosureDate = TextEditingController();
  TextEditingController source = TextEditingController();
  TextEditingController subSource = TextEditingController();
  TextEditingController category = TextEditingController();
  TextEditingController remark = TextEditingController();

  List<String> leadCategory = [];
  List<ProductCategoryModel> stateList = [];
  List<String> cityList = [];
  List<String> sourceList = [];
  RxBool dataReceivedFromApi = false.obs;
  getCustomerDetailsApi() async {
    dataReceivedFromApi.value = false;
    dynamic response = await appRepository.getCustomerDetailsByMobileNoApi(mobileNo.text!);
    if(response != null && response["Data"] != null) {
        List data = response["Data"] ?? [];
        if(data.isNotEmpty) {
          dynamic? contact = data[0]["Contact"];
          String n = contact["Name"] ?? "";
          if(n.isNotEmpty) {
            dataReceivedFromApi.value = true;
          }
          name.text = n;
          gender.text = contact["Gender"] ?? "";

          List addressList =  data[0]["Address"] ?? [];
          if(addressList.isNotEmpty)  {
            dynamic? address  = addressList[0];
            String st = address["State"] ?? [];
            state.text = st;
            city.text  = address["City"];
            zipcode.text = address["ZipCode"] ?? "";

            if(st.isNotEmpty) {
              String stateId = stateList.firstWhereOrNull((v) => v.name == st)?.iD ?? "";
              getCityListApi(stateId);
            }
          }
        }
    }
  }
  getCategoryApi() async {
    dynamic response = await appRepository.getCategoryAPI();
    List<ProductCategoryModel> arrCategories = [];
    items.clear();
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

  getItemInfoApi() async {
    dynamic response = await appRepository.getSelectedItemInfoApi(_selectedCategory?.iD ?? "", _selectedBrand?.iD ?? "", _selectedFamily?.iD ?? "", _selectedCapacity?.iD ?? "", _selectedColor?.iD ?? "");
    productList.value.clear();
    if(response["Data"] != null) {
      List<dynamic> list = response["Data"];
      for (var json in list) {
        ProductCategoryModel model = ProductCategoryModel.fromJson(json);
        productList.value.add(model);
       // selectedItems.refresh();
      }
      if(productList.value.length > 1) {
        showEnquiryProductList();
      } else {
        selectedItems.value.addAll(productList.value);
        selectedItems.refresh();
      }
    }
    _selectedCategory = null;
    _selectedBrand = null;
    _selectedFamily = null;
    _selectedCapacity = null;
    _selectedColor = null;
    getCategoryApi();
    return response;
  }
  
  getLeadCategoryApi() async {
     dynamic response = await appRepository.getRecordsAPI("lead_category");
     if(response["Data"] != null) {
       List<dynamic> list = response["Data"];
       leadCategory = list.map((element) => element["Name"].toString()).toList();
       print(leadCategory);
     }
  }

  getStateListApi() async {
    dynamic request = {
      "module": "state",
      "group_id" : 1
    };
    dynamic response = await appRepository.getStateListApi(request);
    if(response["Data"] != null) {
      List<dynamic> list = response["Data"];
      for (var json in list) {
        ProductCategoryModel model = ProductCategoryModel.fromJson(json);
        stateList.add(model);
      }
    }
  }

  getCityListApi(String groupId) async {
    dynamic request = {
      "module": "city",
      "group_id" : groupId
    };
    dynamic response = await appRepository.getStateListApi(request);
    if(response["Data"] != null) {
      List<dynamic> list = response["Data"];
      cityList = list.map((element) => element["Name"].toString()).toList();
    }
  }
  
  getSourceApi() async {
    dynamic response = await appRepository.getRecordsAPI("lead_source");
    if(response["Data"] != null) {
      List<dynamic> list = response["Data"];
      sourceList = list.map((element) => element["Name"].toString()).toList();
    }
    return response;
  }

  createEnquiryApi() async {
    List<dynamic> items = [];
    for (var item in selectedItems) {
      dynamic itemJson =  {
        "ItemCode": item.code,
        "ItemName": item.name,
        "ModelID": item.iD,
        "CategoryID": "",
        "Capacity":"",
        "Color":"",
        "Quantity": 1,
        "BudgetAmount": 0,
        "ProductImage": [
          {
            "ProductImagePath": "http//fgfg"
          }
        ]
      };
      items.add(itemJson);
    }

    dynamic request = {
      "module": "enquiry",
      "Header": {
        "CompanyID" : AppManager.shared.loginModel?.companyID ?? "",
        "TXNName":"",
        "BranchRefCode": AppManager.shared.loginModel?.branchAPIRefCode ?? "",
        "ExecutiveCode": AppManager.shared.loginModel?.defaultExecutiveCode ?? "",
        "VoucherType": "1907",
        "VendorID": "",
        "CustomerName": name.text,
        "CustomerMobile": mobileNo.text,
        "CustomerEmail": "",
        "CustomerCity": city.text,
        "StateName": state.text,
        "Source": source.text,
        "Category": category.text,
        "IsInterestedInShieldItem": isInterestedInAppleCare.value ? "1" : "0",
        "IsDeviceEnquiry": isExchangeDevice.value ? "1" : "0",
        "IsFinanceEnquiry": isLikeToBuyWithFinance.value ? "1" : "0",
        "OutStraightPurchase": isOutstraightPurchase.value ? "1" : "0",

      },
      "Line": items
    };

    dynamic response = await appRepository.createEnquiryAPI(request);
    if (response["status"] != null && response["status"] == 200 || response["status"] == 201) {
      AppManager.showToast(response["message"]);
      return true;
    } else {
      AppManager.showToast("Something went wrong!. Please try again later");
      return false;
    }
  }

  showGenderDropDown() {
      List<String> genderArr = ["Male", "Female", "Not specified"];
      AppManager.shared.showActionSheet(genderArr,"Select Gender", (index) => {
        gender.text = genderArr[index]
      });
  }

  showLeadCategoryDropDown() {
    AppManager.shared.showActionSheet(leadCategory,"Select Category", (index) => {
      category.text = leadCategory[index]
    });
  }

  showStateDropDown() {
    List<String> list = stateList.map((element) => element.name ?? "").toList();
    AppManager.shared.showActionSheet(list,"Select State", (index) {
      state.text = list[index];
      ProductCategoryModel model = stateList[index];
      city.text = "";
      getCityListApi(model.iD ?? "");
    }, true);
  }

  showCityDropDown() {
    if(state.text.isEmpty) {
      AppManager.showToast("Please select state");
      return;
    }
    if(cityList.isEmpty) {
      AppManager.showToast("city not available");
      return;
    }
    AppManager.shared.showActionSheet(cityList,"Select City", (index) => {
      city.text = cityList[index]
    }, true);
  }

  showSourceDropDown() {
    AppManager.shared.showActionSheet(sourceList,"Select Source", (index) => {
      source.text = sourceList[index]
    });
  }

  validateForStep1() {
    if(mobileNo.text.length < 10) {
      AppManager.showToast("Please enter valid mobile number");
      return false;
    }
    if(name.text.trim().isEmpty)  {
      AppManager.showToast("Please enter customer name");
      return false;
    }
    if(gender.text.isEmpty) {
      AppManager.showToast("Please select gender");
      return false;
    }
    if(city.text.trim().isEmpty) {
      AppManager.showToast("Please enter city");
      return false;
    }
    if(state.text.trim().isEmpty) {
      AppManager.showToast("Please enter state");
      return false;
    }
    if(zipcode.text.length < 6) {
      AppManager.showToast("Please enter valid zip code");
      return false;
    }
    return true;
  }

  showEnquiryProductList() {
    Get.bottomSheet(Obx(() => EnquiryProductList(productList: productList.value, onSelect: (int index) {
      productList.value[index].isSelected = !productList.value[index].isSelected!;
      productList.refresh();
    }, onDone: () {
        selectedItems.value.addAll(productList.where((p) => p.isSelected!).toList());
        selectedItems.refresh();
        Get.back();
    },)), isScrollControlled: true);
  }

  void scrollToBottom() {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 100),
      curve: Curves.easeOut,
    );
  }
}