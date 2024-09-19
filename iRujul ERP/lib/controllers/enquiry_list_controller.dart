import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/enquiry_list_model.dart';
import '../utils/ApiManager/Repository/repository.dart';
import '../utils/app_manager.dart';

class EnquiryListController extends GetxController {
  AppRepository appRepository = AppRepository();

  TextEditingController startDate = TextEditingController();
  TextEditingController endDate = TextEditingController();

  RxList<EnquiryListModel> arrEnquiryList = RxList<EnquiryListModel>();

  getEnquiryListApi() async {

    if(startDate.text.isEmpty || endDate.text.isEmpty) {
      return;
    }
    arrEnquiryList.clear();
    arrEnquiryList.refresh();

    String sDate = AppManager().convertDateFormat(startDate.text!, "dd/MM/yyyy", "yyyy-MM-dd");
    String eDate = AppManager().convertDateFormat(endDate.text!, "dd/MM/yyyy", "yyyy-MM-dd");

    dynamic response = await appRepository.getEnquiryListApi(sDate, eDate);
    if(response["Data"] != null) {
      List<dynamic> list = response["Data"];
      for (var json in list) {
        arrEnquiryList.add(EnquiryListModel.fromJson(json));
      }
    }
    arrEnquiryList.refresh();
  }

}