import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irujul_erp/screens/customer/customer_list_screen.dart';
import 'package:irujul_erp/screens/enquiry/enquiries_List_screen.dart';
import 'package:irujul_erp/screens/home_screen.dart';
import 'package:irujul_erp/screens/profile_screen.dart';
import 'package:irujul_erp/screens/stocks/stock_list_screen.dart';
import 'package:irujul_erp/utils/constants.dart';
import 'package:irujul_erp/utils/routes.dart';

class DashboardController extends  GetxController {
  RxInt selectedMenuIndex = 0.obs;
  RxInt selectedOptionIndex = 0.obs;
  RxInt selectedTabIndex = 0.obs;

  RxList menus = [].obs;
  List drawerMenus = ["Profile", "Home", "Enquiry", "Stock","Help", "Logout"];
  List drawerIcons = [Icons.person_2, Icons.home, Icons.add_circle, Icons.shopping_bag, Icons.help, Icons.logout];
  final pages = [
    HomeScreen(),
    EnquiriesListScreen(),
    StockListScreen()
  ];

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