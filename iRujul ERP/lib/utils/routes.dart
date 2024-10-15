
import 'package:get/get.dart';
import 'package:irujul_erp/screens/enquiry/add_enquiry_step_1_screen.dart';
import 'package:irujul_erp/screens/enquiry/add_enquiry_step_2_screen.dart';
import 'package:irujul_erp/screens/enquiry/add_enquiry_step_3_screen.dart';
import 'package:irujul_erp/screens/dashboard_screeen.dart';
import 'package:irujul_erp/screens/login_screen.dart';
import 'package:irujul_erp/screens/profile_screen.dart';
import 'package:irujul_erp/screens/sales/sales_customer_list_screen.dart';
import 'package:irujul_erp/screens/sales/sales_customer_screen.dart';
import 'package:irujul_erp/screens/splash_screen.dart';
import 'package:irujul_erp/screens/stocks/stock_list_screen.dart';
import 'package:irujul_erp/screens/update_enquiry_screen.dart';

class RouteName {
  static const splashScreen = '/splash_screen';
  static const loginScreen = '/login_screen';
  static const dashboardScreen = '/dashboard_screen';
  static const profileScreen = "/profile_screen";

  //Sales
  static const salesCustomerScreen = '/sales_customer_screen';
  static const salesCustomerListScreen = '/sales_customer_list_screen';

  //Enquiry
  static const addEnquiryStep1Screen = '/add_enquiry_step1_screen';
  static const addEnquiryStep2Screen = '/add_enquiry_step2_screen';
  static const addEnquiryStep3Screen = "/add_enquiry_step3_screen";

  static const updateEnquiryScreen ="/update_enquiry_screen";

  static const stockListScreen = "/stock_list_screen";
}

final getPages = [
  GetPage(
      name: RouteName.splashScreen,
      page: () => const SplashScreen()
  ),
  GetPage(
      name: RouteName.loginScreen,
      page: () => const LoginScreen()
  ),
  GetPage(
      name: RouteName.dashboardScreen,
      page: () => const DashboardScreen()
  ),
  GetPage(
      name: RouteName.salesCustomerScreen,
      page: () => const SalesCustomerScreen()
  ),
  GetPage(
      name: RouteName.salesCustomerListScreen,
      page: () => const SalesCustomerListScreen()
  ),
  GetPage(
      name: RouteName.addEnquiryStep1Screen,
      page: () => const AddEnquiryStep1Screen()
  ),
  GetPage(
      name: RouteName.addEnquiryStep2Screen,
      page: () => const AddEnquiryStep2Screen(),
      transition: Transition.noTransition
  ),
  GetPage(
      name: RouteName.addEnquiryStep3Screen,
      page: () => const AddEnquiryStep3Screen(),
      transition: Transition.noTransition
  ),
  GetPage(
      name: RouteName.updateEnquiryScreen,
      page: () => const UpdateEnquiryScreen()
  ),
  GetPage(
      name: RouteName.profileScreen,
      page: () => const ProfileScreen()
  ),
  GetPage(
      name: RouteName.stockListScreen,
      page: () => const StockListScreen()
  ),
];