import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irujul_erp/utils/languages.dart';
import 'package:irujul_erp/utils/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "iRujul ERP",
      initialRoute: RouteName.splashScreen,
      getPages: getPages,
      translations: Languages(),
      locale: Get.deviceLocale,
      fallbackLocale: const Locale('en','US'),

    );
  }
}
