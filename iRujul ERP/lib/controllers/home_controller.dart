import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:irujul_erp/models/dashboard_model.dart';
import 'package:irujul_erp/utils/ApiManager/Repository/repository.dart';
import 'package:irujul_erp/utils/common_widgets/app_loader.dart';

class HomeController extends GetxController {
  AppRepository appRepository = AppRepository();
  Rx<int> selectedDashboardIndex = 0.obs;
  RxList<Rows> todaysData = RxList<Rows>();
  late Rx<Grid>? branchWiseData = Grid().obs;
  late Rx<Grid>? graphData = Grid().obs;
  getDashboardApi(String module, BuildContext context) async {
    AppLoader.show(context);
    dynamic response = await appRepository.getDashboardAPI(module);
    if(response["Data"] != null) {
      DashboardModel model = DashboardModel.fromJson(response["Data"]);
      todaysData.value = model.rows ?? [];
      branchWiseData?.value = model.grid!;
      graphData?.value = model.graph!;
    }
    AppLoader.hide();
  }
}