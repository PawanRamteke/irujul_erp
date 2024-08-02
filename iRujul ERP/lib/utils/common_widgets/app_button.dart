import 'package:flutter/material.dart';
import 'package:irujul_erp/utils/colors.dart';

class AppButton extends StatelessWidget {
  final String btnName;
  final Function() onPressed;
  double? radius;
  double? height;
  double? width;
  double? textSize;

  AppButton({
    super.key,
    required this.btnName,
    required this.onPressed,
    this.radius,
    this.height,
    this.width,
    this.textSize,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onPressed(),
      child: Container(
        height: height != null ? height! : 50,
        width: width != null ? width! : double.infinity,
        decoration: BoxDecoration(
          color: appRedColor,
          borderRadius: BorderRadius.circular( radius ?? 10.0),
        ),
        child: Center(
          child: Text(
            btnName,
            style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold, fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
