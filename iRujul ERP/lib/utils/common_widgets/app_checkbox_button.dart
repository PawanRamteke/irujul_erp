import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppCheckboxButton extends StatelessWidget {
  String title  = "";
  AppCheckboxButton({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {

      },
      child: Row(
        children: [
          SizedBox(
            width: 25,
            height: 25,
            child: Image.asset("assets/images/unchecked.png"),
          ),
          SizedBox(width: 5,),
          Text(title)
        ],
      ),
    );
  }
}
