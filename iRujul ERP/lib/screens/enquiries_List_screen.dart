import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irujul_erp/utils/colors.dart';
import 'package:irujul_erp/utils/common_widgets/app_card_widget.dart';
import 'package:irujul_erp/utils/routes.dart';

class EnquiriesListScreen extends StatefulWidget {
  const EnquiriesListScreen({super.key});

  @override
  State<EnquiriesListScreen> createState() => _EnquiriesListScreenState();
}

class _EnquiriesListScreenState extends State<EnquiriesListScreen> {
  List list = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(RouteName.addEnquiryStep1Screen);
        },
        shape: const CircleBorder(),
        backgroundColor: primaryColor,
        child: const Icon(Icons.add),
      ),
      body: Container(
        child: list.length == 0 ?
        Center(child: Text("No data available"),) :
        ListView.builder(
          itemCount: list.length,
            itemBuilder: (context, index) {
              return Container(
                padding: EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
                child: AppCardWidget(
                  padding: EdgeInsets.all(20),
                  child: Container(),
                ),
              );
            }
        ),
      ),
    );
  }
}
