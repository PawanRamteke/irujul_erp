
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:irujul_erp/utils/ApiManager/prefernces.dart';
abstract class BaseApiManager {
  Future<dynamic> postApi(String url, dynamic request);
  Future<dynamic> getApi(String url);
}

class ApiManager extends BaseApiManager {
  @override
  Future getApi(String url) async {
    dynamic responseJson;
    try {
      http.Response response = await http.get(Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json"
        },
      ).timeout(const Duration(seconds: 30));
      responseJson = jsonDecode(response.body);
    } catch (e){
      print(e.toString());
    }
    return responseJson;

  }

  @override
  Future postApi(String url, request) async {
    dynamic responseJson;
    String token = await Preferences.getAccessToken();
    try {
      http.Response response = await http.post(Uri.parse(url),
          headers: {
            "Content-Type": "application/json",
            "Authorization":  "Bearer $token"
          },
          body: jsonEncode(request)
      ).timeout(const Duration(seconds: 30));
      responseJson = jsonDecode(response.body);
    } catch (e) {
      print(e);
    }
    return responseJson;
  }
}