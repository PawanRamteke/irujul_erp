import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irujul_erp/utils/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 4), () {
      setState(() {
        Get.offAllNamed(RouteName.loginScreen);
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
          child: SizedBox(
            width: 300,
            height: 300,
            child: Image.asset("assets/images/iplug_icon.jpg"),
          ),
        ),
    );
  }
}
