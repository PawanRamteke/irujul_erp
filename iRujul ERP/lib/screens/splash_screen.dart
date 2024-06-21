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
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
                child: Center(
                    child: Image.asset("assets/images/rujul-logo-login.png"),
                )
            ),
            Text('copyright_text'.tr)
          ],
        ),
      ),
    );
  }
}
