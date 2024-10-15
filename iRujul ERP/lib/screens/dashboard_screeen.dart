import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:irujul_erp/controllers/dashboard_controller.dart';
import 'package:irujul_erp/utils/colors.dart';
import 'package:irujul_erp/utils/routes.dart';
import 'package:irujul_erp/utils/text_styles.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../utils/app_manager.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final DashboardController dashboardController = Get.put(DashboardController());

  final ItemScrollController itemScrollController = ItemScrollController();
  final ScrollOffsetController scrollOffsetController = ScrollOffsetController();
  final ItemPositionsListener itemPositionsListener = ItemPositionsListener.create();
  final ScrollOffsetListener scrollOffsetListener = ScrollOffsetListener.create();

  @override
  void initState() {
    dynamic args = Get.arguments;
    if(args != null && args["from"] == "add_enquiry") {
      dashboardController.selectedTabIndex.value = 1;
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Obx(() => Text(dashboardController.selectedTabIndex.value == 0 ? "Home" : (dashboardController.selectedTabIndex.value == 1 ? "Enquiries" : "Stock"),
          style: fontRegularStyle(fontSize: 18),))
      ),
      drawer: Drawer(
        child: _drawerMenu(),
      ),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: primaryColor,
        selectedItemColor: Colors.white,
        selectedLabelStyle: fontBoldStyle(fontSize: 10),
        unselectedLabelStyle: fontRegularStyle(fontSize: 10),
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home"
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_circle),
              label: "Enquiries"
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag),
              label: "Stock"
          )
        ],
        currentIndex: dashboardController.selectedTabIndex.value,
        onTap: (index) {
          dashboardController.selectedTabIndex.value = index;
          },
      )),
      body: Obx(()  => PopScope(
          canPop: false,
          onPopInvokedWithResult: (status,value) async{
            bool? value = await _showExitConfirmationDialog(context);
            if (value ?? false) {
              SystemNavigator.pop();
            }
          },
          child: dashboardController.pages[dashboardController.selectedTabIndex.value]
      ))
    );
  }

  _drawerMenu() {
    return SafeArea(
      child:Column(
        children: [
          const SizedBox(height: 20,),
          SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40)
                  ),
                  child: Image.asset("assets/images/img_user.png"),
                ),
                const SizedBox(height: 20,),
                Text(
                  AppManager.shared.loginModel?.defaultExecutiveName ?? "-",
                  style: fontSemiBoldStyle(fontSize: 16),
                )
              ],
            ),
          ),
          SizedBox(height: 40,),
          Expanded(
              child: ListView.builder(
                  itemCount: dashboardController.drawerMenus.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Get.back();
                        String text = dashboardController.drawerMenus[index];
                        if(text == "Profile") {
                            Get.toNamed(RouteName.profileScreen);
                        } else if(text == "Home") {
                          dashboardController.selectedTabIndex.value = 0;
                        } else if(text == "Enquiry") {
                          dashboardController.selectedTabIndex.value = 1;
                        } else if(text == "Stock") {
                          dashboardController.selectedTabIndex.value = 2;
                        } else if(text == "Help") {

                        } else if(text == "Logout") {
                          _showLogoutAlert(context);
                        }
                      },
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.only(left: 20,right: 20, top: 15, bottom: 15),
                        child: Row(
                          children: [
                            Icon(dashboardController.drawerIcons[index]),
                            const SizedBox(width: 10,),
                            Text(
                              dashboardController.drawerMenus[index],
                              style: fontSemiBoldStyle(fontSize: 14)),
                          ]
                        ),
                      ),
                    );
                  }
              ),
          )
        ],
      )
    );
  }

  Future<bool?> _showExitConfirmationDialog(BuildContext context) async {
    bool? shouldPop = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmation'),
        content: const Text('Do you really want to exit from app?'),
        actions: <Widget>[
          TextButton(
            child: const Text('No', style: TextStyle(color: appRedColor),),
            onPressed: () {
              Get.back();
            },
          ),
          TextButton(
            child: const Text('Yes', style: TextStyle(color: appRedColor),),
            onPressed: () {
              Navigator.of(context).pop(true);
            },
          ),
        ],
      ),
    );

    return shouldPop ?? false;
  }

  _showLogoutAlert(BuildContext context) async {
    showDialog(context: context, builder: (context) => AlertDialog(
      title: const Text("Logout?"),
      content: const Text("Are you sure want to logout?"),
      actions: <Widget>[
        TextButton(
          child: const Text('No', style: TextStyle(color: appRedColor),),
          onPressed: () {
            Get.back();
          },
        ),
        TextButton(
          child: const Text('Yes', style: TextStyle(color: appRedColor),),
          onPressed: () {
            Get.offAllNamed(RouteName.loginScreen);
          },
        ),
      ],
    ));
  }
}
