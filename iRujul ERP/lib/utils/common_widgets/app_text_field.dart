import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:irujul_erp/utils/ApiManager/Repository/repository.dart';
import 'package:irujul_erp/utils/colors.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String placeholder;
  final double? height;
  final Icon? icon;
  final TextInputType? keyboardType;
  final bool? isDropDown;
  final Function? onTap;
  final bool? secureText;
  final int? maxLength;
  final int? maxLines;
  final bool? isDatePicker;
  final bool? makeDisable;
  final DateTime? initialDate;
  final Function? onDateSelect;
  final bool? isTimePicker;
  const AppTextField({
    super.key,
    this.controller,
    required this.placeholder,
    this.height,
    this.icon,
    this.keyboardType,
    this.isDropDown,
    this.onTap,
    this.secureText,
    this.maxLength,
    this.maxLines,
    this.isDatePicker,
    this.makeDisable,
    this.initialDate,
    this.onDateSelect,
    this.isTimePicker
  });
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: TextField(
        focusNode: (isDatePicker ?? false) || (makeDisable ?? false) || (isTimePicker ?? false) ? AlwaysDisabledFocusNode() : null,
        controller: controller,
        decoration: InputDecoration(
          border: InputBorder.none,
          labelText: placeholder,
          labelStyle: const TextStyle(fontSize: 15),
          counterText: "",
          focusedBorder:  OutlineInputBorder(
            borderRadius: BorderRadius.circular(0),
            borderSide: BorderSide(color: appRedColor, width: 0.5),
          ),
          enabledBorder:   OutlineInputBorder(
            borderRadius: BorderRadius.circular(0),
            borderSide: BorderSide(color: (makeDisable ?? false) ? Colors.grey : appRedColor, width: 0.5),
          ),
        // prefixIcon: (isDatePicker ?? false) ? const Icon(Icons.calendar_month, color: appRedColor,) : null,
          suffixIcon: (isDropDown ?? false) ? const Icon(Icons.arrow_drop_down) :
          ((isDatePicker ?? false) ? const Icon(Icons.calendar_month, color: Colors.grey,) :
          ((isTimePicker ?? false) ? const Icon(Icons.access_time, color: Colors.grey,) : null)),
        ),
        readOnly: isDropDown ?? false,
        obscureText: secureText ?? false,
        onTap: () {
          if(makeDisable ?? false) {
            return;
          }
          if(isDatePicker ?? false) {
            _showDatePicker();
            return;
          }
          if((isDropDown ?? false) && onTap != null) {
            onTap!();
            return;
          }
          if(isTimePicker ?? false) {
            _showTimePicker();
            return;
          }
        },
        maxLength: maxLength,
        keyboardType:  keyboardType,
        maxLines: maxLines ?? 1,
      ),
    );
  }
  _showDatePicker() {
    showDatePicker(
        context: Get.context!,
        initialDate: initialDate ?? DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2040, 1),
        builder: (context,picker){
          return Theme(
            //TODO: change colors
            data: ThemeData.light().copyWith(
              colorScheme: const ColorScheme.light(
                primary: primaryColor,
                onPrimary: Colors.white,
                onSurface: Colors.black,
              ),
            ),
            child: picker!,);
        }
    ).then((selectedDate) {
      if(selectedDate != null) {
        String formattedDate = DateFormat('dd/MM/yyyy').format(selectedDate!);
        controller?.text = formattedDate;
        if(onDateSelect != null) {
          onDateSelect!();
        }
      }
    });
  }

  _showTimePicker()  async {
    final TimeOfDay? picked = await showTimePicker(
      context: Get.context!,
      initialTime: TimeOfDay.now(),
        builder: (context,picker){
          return Theme(
            //TODO: change colors
            data: ThemeData.light().copyWith(
              colorScheme: const ColorScheme.light(
                primary: primaryColor,
                onPrimary: Colors.white,
                onSurface: Colors.black,
              ),
            ),
            child: picker!,);
        }
    );
    if (picked != null) {
        controller?.text = "${picked.hour}:${picked.minute}";
    }
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}