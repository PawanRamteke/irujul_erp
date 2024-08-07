import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class AppManager {
  static final AppManager shared = AppManager._internal();
  String appUrl = "";
  factory AppManager() {
    return shared;
  }
  AppManager._internal();

  showActionSheet(List<String> arrList, Function(int) onSelect) {
    Get.bottomSheet(
        Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListView.builder (
                itemCount: arrList.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      onSelect(index);
                    },
                    child: ListTile(
                      title: Text("Pawan $index"),
                    ),
                  );
                }
            )
        )
    );
  }

  static showToast(String message) {
    Fluttertoast.showToast(msg: message, timeInSecForIosWeb: 3);
  }
}