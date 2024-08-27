
import 'package:intl/intl.dart';
import 'package:irujul_erp/utils/ApiManager/ApiManager.dart';

import '../../app_manager.dart';

String baseUrl = "https://bizplugins.irujul.com";
String verifyServerPinApi = "/apis/v1/mpin";
String loginApi = "/apis/v1/login";
String getRecordsApi  = "/apis/v1/getRecords";
String getItemInfoApi = "/apis/v1/getItemInfo";

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
}