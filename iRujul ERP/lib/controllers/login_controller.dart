import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irujul_erp/utils/app_manager.dart';

class LoginController extends GetxController {
  TextEditingController userName = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController company = TextEditingController();
  TextEditingController branch = TextEditingController();

  List<String> arrCompany = [];
  List<String> arrBranch = [];

  showCompanyDropDownList() {
    AppManager.shared.showActionSheet(arrCompany, (index) => {

    });
  }

  showBranchDropDownList() {
    AppManager.shared.showActionSheet(arrBranch, (index) => {

    });
  }
}