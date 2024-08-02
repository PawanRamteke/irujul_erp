import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irujul_erp/utils/languages.dart';
import 'package:irujul_erp/utils/routes.dart';
import 'dart:io';

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}
void main() {
  HttpOverrides.global = MyHttpOverrides();
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
