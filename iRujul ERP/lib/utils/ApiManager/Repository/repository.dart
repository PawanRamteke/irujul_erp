
import 'package:irujul_erp/utils/ApiManager/ApiManager.dart';

import '../../app_manager.dart';

String baseUrl = "https://65.2.173.10/irujul_test_3_1";
String verifyServerPinApi = "/apis/v1/mpin";
String loginApi = "/apis/v1/login";
String getRecordsApi  = "/apis/v1/getRecords";

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
}