import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:irujul_erp/utils/colors.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String placeholder;
  final double? height;
  final Icon? icon;
  final TextInputType? keyboardType;
  final bool? isDropDown;
  final Function? onTap;
  AppTextField({
    super.key,
    this.controller,
    required this.placeholder,
    this.height,
    this.icon,
    this.keyboardType,
    this.isDropDown,
    this.onTap
  });
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 50,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          border: InputBorder.none,
          labelText: placeholder,
          labelStyle: const TextStyle(
              fontSize: 15
          ),
          focusedBorder:  OutlineInputBorder(
            borderRadius: BorderRadius.circular(0),
            borderSide: BorderSide(color: appRedColor, width: 0.5),
          ),
          enabledBorder:   OutlineInputBorder(
            borderRadius: BorderRadius.circular(0),
            borderSide: BorderSide(color: appRedColor, width: 0.5),
          ),
          suffixIcon: (isDropDown ?? false) ? Icon(Icons.arrow_drop_down) : null,
        ),
        readOnly: isDropDown ?? false,
        onTap: () {
            if((isDropDown ?? false) && onTap != null) {
              onTap!();
            }
        },
      ),
    );
  }
}
