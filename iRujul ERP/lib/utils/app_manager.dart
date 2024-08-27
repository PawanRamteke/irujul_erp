import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:irujul_erp/models/login_model.dart';
import 'package:irujul_erp/utils/colors.dart';

import '../models/branch_model.dart';

class AppManager {
  static final AppManager shared = AppManager._internal();
  String appUrl = "";
  LoginModel? loginModel;
  BranchModel?  branchModel;
  factory AppManager() {
    return shared;
  }
  AppManager._internal();
  showActionSheet(List<String> arrList, String title, Function(int) onSelect) {
    Get.bottomSheet(
        Container(
            padding: const EdgeInsets.all(20),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              
              children: [
                Text(title,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: appRedColor),
                ),
                Expanded(child: ListView.builder (
                    itemCount: arrList.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          onSelect(index);
                          Get.back();
                        },
                        child: ListTile(
                          title: Text(arrList[index]),
                        ),
                      );
                    }
                ))
              ],
            )
        )
    );
  }

  static showToast(String message) {
    Fluttertoast.showToast(msg: message, timeInSecForIosWeb: 3);
  }
}