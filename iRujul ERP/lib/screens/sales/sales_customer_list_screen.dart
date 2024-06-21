import 'package:flutter/material.dart';
import 'package:irujul_erp/utils/common_widgets/app_card_widget.dart';

class SalesCustomerListScreen extends StatefulWidget {
  const SalesCustomerListScreen({Key? key}) : super(key: key);

  @override
  State<SalesCustomerListScreen> createState() => _SalesCustomerListScreenState();
}

class _SalesCustomerListScreenState extends State<SalesCustomerListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Customer List"),
      ),
      body: ListView.builder(
        itemCount: 10,
          itemBuilder: (context, index) {
            return AppCardWidget(
                margin: const EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
                padding: EdgeInsets.all(20),
                child: Text("Code")
            );
          }
      ),
    );
  }
}
