import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppCardWidget extends StatelessWidget {
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final double? width;
  final double? height;
  final Widget child;
  final Color? color;
  final double? borderRadius;
  //final double? borderRadius;
  AppCardWidget({
    super.key,
    this.margin,
    this.padding,
    this.width,
    this.height,
    required this.child,
    this.color,
    this.borderRadius
   // this.borderRadius
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: padding,
      width: width,
      height: height,
      decoration: BoxDecoration(
          color: color ?? Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 10)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset(1, 1), // changes position of shadow
            ),
          ]
      ),
      child: child,
    );
  }
}
