import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:irujul_erp/utils/colors.dart';

class CustomerRegistrationSteps extends StatelessWidget {
  int currentStep = 0;
  CustomerRegistrationSteps({super.key, required this.currentStep});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20,right: 20,top: 20, bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          circle(0),
          const Expanded(child: Divider(thickness: 2,)),
          circle(1),
          const Expanded(child: Divider(thickness: 2,)),
          circle(2),
          const Expanded(child: Divider(thickness: 2,)),
          circle(3)
        ],
      ),
    );
  }

  Widget circle(int step) {
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey[400]!),
        color: currentStep == step ? appRedColor : Colors.grey[200]
      ),
    );
  }
}
