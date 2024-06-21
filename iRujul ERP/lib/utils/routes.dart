
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:irujul_erp/screens/dashboard_screeen.dart';
import 'package:irujul_erp/screens/login_screen.dart';
import 'package:irujul_erp/screens/sales/sales_customer_list_screen.dart';
import 'package:irujul_erp/screens/sales/sales_customer_screen.dart';
import 'package:irujul_erp/screens/splash_screen.dart';

class RouteName {
  static const splashScreen = '/splash_screen';
  static const loginScreen = '/login_screen';
  static const dashboardScreen = '/dashboard_screen';

  //Sales
  static const salesCustomerScreen = '/sales_customer_screen';
  static const salesCustomerListScreen = '/sales_customer_list_screen';

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
];