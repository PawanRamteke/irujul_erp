import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:irujul_erp/controllers/dashboard_controller.dart';
import 'package:irujul_erp/utils/colors.dart';
import 'package:irujul_erp/utils/constants.dart';
import 'package:irujul_erp/utils/routes.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          height: 50,
          width: 200,
          child: Image.asset("assets/images/rujul-logo-login.png"),
        ),
      ),
      drawer: Drawer(
        child: _drawerMenu(),
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 20,),
            _tabBarMenus(),
            SizedBox(height: 10,),
            _menuOptions()
          ],
        ),
      ),
    );
  }

  _tabBarMenus() {
    return Container(
      width: double.infinity,
      height: 50,
      child: ScrollablePositionedList.builder(
        scrollDirection: Axis.horizontal,
        itemCount: appMenus.length,
        itemBuilder: (context, index) {
          return  InkWell(
            onTap: () {
              dashboardController.selectedMenuIndex.value = index;
              itemScrollController.scrollTo(
                  index: index,
                  duration: Duration(milliseconds: 500),
              );
              String selectedMenu = appMenus[index];
              menuOptions.forEach((element) {
                print(element);
                if(element.keys.first == selectedMenu) {
                  dashboardController.menus.value = element[selectedMenu] as  List<dynamic>;
                }
              });
            },
            child: Obx(() => Container(
              margin: EdgeInsets.all(5),
              padding: EdgeInsets.only(left: 15,right: 15),
              decoration: BoxDecoration(
                color: dashboardController.selectedMenuIndex.value == index ? appMenuSelectedColor : appRedColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 30,
                      height: 30,
                      child: Center(
                        child: Icon(Icons.home, color: Colors.white,),
                      ),
                    ),
                    SizedBox(width: 0,),
                    Text(appMenus[index],
                      style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ),
            )
          );
        },
        itemScrollController: itemScrollController,
        scrollOffsetController: scrollOffsetController,
        itemPositionsListener: itemPositionsListener,
        scrollOffsetListener: scrollOffsetListener,
      ),
    );
  }

  _menuOptions() {
    return Expanded(
        child: Obx(() => ListView.builder(
        itemCount: dashboardController.menus.length,
        itemBuilder: (context,index) {
          return _menuOptionItem(index);
        }
        )
      ),
    );
  }

  _menuOptionItem(int index) {
    Map<String, dynamic> menu = dashboardController.menus[index];
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
      width: double.infinity,
      child: ListTileTheme(
        tileColor: Color(0xffF3EEEE),
        minVerticalPadding: -10,
        minLeadingWidth: 0,
        horizontalTitleGap: 10,
        contentPadding: EdgeInsets.zero,
        //data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
            initiallyExpanded: index == dashboardController.selectedOptionIndex.value,
            visualDensity: VisualDensity(horizontal: 0, vertical: -4),
            shape: Border(),
            tilePadding: EdgeInsets.only(right: 10),
            leading: Container(
              width: 2,
              height: 40,
              color: appRedColor,
            ),
            title: Text(
              menu["menu"] as String,
              style: TextStyle(color: appRedColor, fontSize: 16),
            ),
            children: List<Widget>.generate(
                (menu["options"] ?? []).length,
                  (index) => InkWell(
                    onTap: (){
                      print(menu);

                      dashboardController.performNavigation(menu["menu"], (menu["options"] ?? [])[index]);
                    },
                    child: SizedBox(
                      height: 40,
                      child: Row(
                        children: [
                          Icon(Icons.arrow_right),
                          Text((menu["options"] ?? [])[index])
                        ],
                      ),
                    ),
                  )
            ),
          onExpansionChanged: (newState){
              dashboardController.selectedOptionIndex.value = index;
          },
        ),
      ),
    );
  }

  _drawerMenu() {
    return SafeArea(
      child:Column(
        children: [
          SizedBox(height: 20,),
          Container(
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
                SizedBox(height: 20,),
                Text(
                  "RnR_Admin",
                  style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
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

                      },
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.only(left: 20,right: 20, top: 15, bottom: 15),
                        child: Row(
                          children: [
                            Icon(index == 0 ? Icons.person_2 : (index == 1 ? Icons.help : Icons.logout)),
                            SizedBox(width: 10,),
                            Text(
                              dashboardController.drawerMenus[index],
                              style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),
                            ),
                          ],
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
}
