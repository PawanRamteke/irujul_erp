
import 'package:intl/intl.dart';
import 'package:irujul_erp/utils/ApiManager/ApiManager.dart';

import '../../app_manager.dart';

String baseUrl = "https://bizplugins.irujul.com";
String verifyServerPinApi = "/apis/v1/mpin";
String loginApi = "/apis/v1/login";
String getRecordsApi  = "/apis/v1/getRecords";
String getItemInfoApi = "/apis/v1/getItemInfo";
String createEnquiryApi = "/apis/v1/create";
String updateEnquiryApi = "/apis/v1/update";
class AppRepository {

  final BaseApiManager apiManager = ApiManager();

  Future<dynamic> verifyServerPinAPI(String pin) async {
    dynamic request = {
      "Mpin": pin,
    };
    var response = await apiManager.postApi("$baseUrl$verifyServerPinApi", request);
    return response;
  }

  Future<dynamic> loginAPI(String username, String password) async {
    dynamic request = {
      "client_id": username,
      "client_secret": password
    };
    var response = await apiManager.postApi("${AppManager.shared.appUrl}$loginApi", request);
    return response;
  }

  Future<dynamic> getRecordsAPI(String module) async {
    dynamic request = {
      "module": module
    };
    var response = await apiManager.postApi("${AppManager.shared.appUrl}$getRecordsApi", request);
    return response;
  }

  Future<dynamic> getDashboardAPI(String module) async {
    var now = DateTime.now();
    var formatter = DateFormat('yyyy-MM-dd');
    String todaysDate = formatter.format(now);

    dynamic request = {
      "module": module,
      "FromDate": todaysDate,
      "ToDate":todaysDate,
      "BrachID":AppManager.shared.branchModel?.branchID ?? "",
      "CompanyID":AppManager.shared.branchModel?.companyID ?? ""
    };
    var response = await apiManager.postApi("${AppManager.shared.appUrl}$getRecordsApi", request);
    return response;
  }

  Future<dynamic> getEnquiryListApi(String startDate, String endDate) async {
    dynamic request = {
      "module": "Enquiry",
      "FromDate": startDate,
      "ToDate": endDate,
      "ExecutiveID":AppManager.shared.loginModel?.defaultExecutive ?? "",
    };
    var response = await apiManager.postApi("${AppManager.shared.appUrl}$getRecordsApi", request);
    return response;
  }

  Future<dynamic> getCustomerDetailsByMobileNoApi(String mobileNo) async {
    dynamic request = {
      "module": "contacts",
      "mobileNo": mobileNo,
    };
    var response = await apiManager.postApi("${AppManager.shared.appUrl}$getRecordsApi", request);
    return response;
  }

  Future<dynamic> getBusinessUnitAPI() async {
    dynamic request = {
      "module": "business_unit"
    };
    var response = await apiManager.postApi("${AppManager.shared.appUrl}$getItemInfoApi", request);
    return response;
  }

  Future<dynamic> getCategoryAPI() async {
    dynamic request = {
      "module": "category"
    };
    var response = await apiManager.postApi("${AppManager.shared.appUrl}$getItemInfoApi", request);
    return response;
  }

  Future<dynamic> getBrandApi(String categoryID) async {
    dynamic request = {
      "module": "brand",
      "CategoryID": categoryID
    };
    var response = await apiManager.postApi("${AppManager.shared.appUrl}$getItemInfoApi", request);
    return response;
  }

  Future<dynamic> getProductFamilyApi(String categoryID, String brandID) async {
    dynamic request = {
      "module": "productfamily",
      "CategoryID": categoryID,
      "BrandID": brandID
    };
    var response = await apiManager.postApi("${AppManager.shared.appUrl}$getItemInfoApi", request);
    return response;
  }

  Future<dynamic> getProductCapacityApi(String categoryID, String brandID, String familyID) async {
    dynamic request = {
      "module": "capacity",
      "CategoryID": categoryID,
      "BrandID": brandID,
      "ProductfamilyID": familyID
    };
    var response = await apiManager.postApi("${AppManager.shared.appUrl}$getItemInfoApi", request);
    return response;
  }

  Future<dynamic> getProductColorApi(String categoryID, String brandID, String familyID, String capacityID) async {
    dynamic request = {
      "module": "color",
      "CategoryID": categoryID,
      "BrandID": brandID,
      "ProductfamilyID": familyID,
      "CapacityID": capacityID
    };
    var response = await apiManager.postApi("${AppManager.shared.appUrl}$getItemInfoApi", request);
    return response;
  }

  Future<dynamic> getSelectedItemInfoApi(String categoryID, String brandID, String familyID, String capacityID, String colorID) async {
    dynamic request = {
      "module": "item_list",
      "CategoryID": categoryID,
      "BrandID": brandID,
      "ProductfamilyID": familyID,
      "CapacityID": capacityID,
      "ColorID": colorID
    };
    var response = await apiManager.postApi("${AppManager.shared.appUrl}$getItemInfoApi", request);
    return response;
  }

  Future<dynamic> createEnquiryAPI(dynamic request) async{
    var response = await apiManager.postApi("${AppManager.shared.appUrl}$createEnquiryApi", request);
    return response;
  }

  Future<dynamic> getStateListApi(dynamic request) async {
    var response = await apiManager.postApi("${AppManager.shared.appUrl}$getRecordsApi", request);
    return response;
  }

  Future<dynamic> getLostReasonApi() async {
    dynamic request = {
      "module": "general_master",
      "gmid": "108"
    };
    dynamic response = await apiManager.postApi("${AppManager.shared.appUrl}$getRecordsApi", request);
    return response;
  }

  Future<dynamic> updateEnquiryAPI(dynamic request) async {
    var response = await apiManager.postApi("${AppManager.shared.appUrl}$updateEnquiryApi", request);
    return response;
  }

  Future<dynamic> getSubCategoryAPI(String categoryID) async {
    dynamic request = {
      "module": "sub_category",
      "CategoryID": categoryID
    };
    var response = await apiManager.postApi("${AppManager.shared.appUrl}$getItemInfoApi", request);
    return response;
  }

  Future<dynamic> getStockReportAPI(dynamic request) async {
    var response = await apiManager.postApi("${AppManager.shared.appUrl}$getRecordsApi", request);
    return response;
  }

}