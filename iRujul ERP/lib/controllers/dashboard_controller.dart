import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:irujul_erp/utils/constants.dart';
import 'package:irujul_erp/utils/routes.dart';

class DashboardController extends  GetxController {
  RxInt selectedMenuIndex = 0.obs;
  RxInt selectedOptionIndex = 0.obs;

  RxList menus = [].obs;
  List drawerMenus = ["Profile", "Help", "Logout"];

  performNavigation(String menu, String option) {
      String selectedTopMenu = appMenus[selectedMenuIndex.value];
      if(selectedTopMenu.toLowerCase() == "sales") {
        if(menu.toLowerCase() == "master") {
          if(option.toLowerCase() == "customer") {
            Get.toNamed(RouteName.salesCustomerListScreen);
          }
        }
      }
  }
}