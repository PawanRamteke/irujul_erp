
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irujul_erp/controllers/home_controller.dart';
import 'package:irujul_erp/models/dashboard_model.dart';
import 'package:irujul_erp/utils/colors.dart';
import 'package:irujul_erp/utils/common_widgets/app_card_widget.dart';
import 'package:irujul_erp/utils/common_widgets/app_charts.dart';
import 'package:irujul_erp/utils/text_styles.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  HomeController homeController = Get.put(HomeController());

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 500),(){
      homeController.getDashboardApi(homeController.selectedDashboardIndex.value == 0  ?
          "app_dashboard_first" : "app_dashboard_second", context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 120,
          color: primaryColor,
        ),
        Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Obx(() => Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                      child: InkWell(
                        onTap: () {
                          homeController.selectedDashboardIndex.value = 0;
                          homeController.getDashboardApi("app_dashboard_first", context);
                        },
                        child: SizedBox(
                          height: 40,
                          child: Column(
                            children: [
                              Expanded(
                                child: Text("Dashboard 1",
                                  style: fontRegularStyle(
                                      fontSize: 15,
                                      color: homeController.selectedDashboardIndex.value == 0 ?
                                      appRedColor : Colors.black,
                                      fontWeight: homeController.selectedDashboardIndex.value == 0 ?
                                      FontWeight.w600 :
                                      FontWeight.normal
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Container(height: 2,color: homeController.selectedDashboardIndex.value == 0 ? appRedColor : Colors.transparent,)
                            ],
                          ),
                        ),
                      )
                  ),
                  Expanded(
                      child: InkWell(
                        onTap: () {
                          homeController.selectedDashboardIndex.value = 1;
                          homeController.getDashboardApi("app_dashboard_second", context);
                        },
                        child: SizedBox(
                          height: 40,
                          child: Column(
                            children: [
                              Expanded(
                                child: Text("Dashboard 2",
                                  style: fontRegularStyle(
                                      fontSize: 15,
                                      color: homeController.selectedDashboardIndex.value == 1 ?
                                      appRedColor : Colors.black,
                                      fontWeight: homeController.selectedDashboardIndex.value == 1 ?
                                      FontWeight.w600 :
                                      FontWeight.normal
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Container(height: 2,color: homeController.selectedDashboardIndex.value == 1 ? appRedColor : Colors.transparent,)
                            ],
                          ),
                        ),
                      )
                  ),
                ],
              )),
              SizedBox(height: 10,),
              Expanded(
                  child: Obx(() => ListView(
                    shrinkWrap: true,
                    children: <Widget>[
                      SizedBox(height: 20,),
                      _createGridView(),
                      SizedBox(height: 20,),
                      _createSalesAmountList(),
                      SizedBox(height: 20,),
                      _columnChart()
                    ],
                  ))
              ),
            ],
          ),
        )
      ],
    );
  }

  _createGridView() {
    return SizedBox(
      height: homeController.todaysData.isNotEmpty ? (100).toDouble() : 0,
      child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: homeController.todaysData.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 2
          ),
          itemBuilder: (context, index){
            return AppCardWidget(
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children:  [
                  Text(homeController.todaysData.value[index].title ??  "", style: fontRegularStyle(fontSize: 14),),
                  SizedBox(height: 10,),
                  Text("Rs.${homeController.todaysData.value[index].saleAmount ?? "0.00"}", style: fontRegularStyle(fontWeight: FontWeight.w600, fontSize: 16),)
                ],
              ),
            );
          }
      ),
    );
  }

  _createSalesAmountList() {
    return AppCardWidget(
      padding: EdgeInsets.only(top: 20,bottom: 20),
      child: Column(
        children: [
          Obx(() => Text(homeController.branchWiseData?.value.heading ?? "",
              style: fontRegularStyle(fontSize: 16, fontWeight: FontWeight.bold)
          ),),
          SizedBox(height: 20,),
          Container(
            height: 40,
            color: Colors.grey[300],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: Text("Branch", textAlign: TextAlign.center, style: fontRegularStyle(fontSize: 14),)),
                Expanded(child: Text("Amount", textAlign: TextAlign.center,style: fontRegularStyle(fontSize: 14))),
                Expanded(child: Text("Quantity", textAlign: TextAlign.center,style: fontRegularStyle(fontSize: 14))),
              ],
            ),
          ),
          Obx(() => (homeController.branchWiseData?.value.details ?? []).length > 0 ? ListView.builder(
              itemCount: homeController.branchWiseData?.value.details?.length ?? 0,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                Details? detailsModel = homeController.branchWiseData?.value.details?[index];
                String? name = detailsModel?.branch ?? detailsModel?.executive ?? "";
                String? salesAmount = homeController.branchWiseData?.value.details?[index].saleAmount ?? "0.00";
                String? saleQty = homeController.branchWiseData?.value.details?[index].saleQty ?? "0";
                return Container(
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: Text(name, textAlign: TextAlign.center,style: fontRegularStyle(fontSize: 14))),
                      Expanded(child: Text("Rs.$salesAmount", textAlign: TextAlign.center,style: fontRegularStyle(fontSize: 14))),
                      Expanded(child: Text(saleQty, textAlign: TextAlign.center,style: fontRegularStyle(fontSize: 14))),
                    ],
                  ),
                );
              }
          ) : Container(
            padding: EdgeInsets.only(top: 10),
            child: Center(
              child: Text("Data not available"),
            ),
          )
          )
        ],
      ),
    );
  }

  _columnChart() {
    return AppCardWidget(
        width: double.infinity,
        height: 350,
        padding: EdgeInsets.only(top: 20,bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(homeController.graphData?.value.heading ?? "",
                style:  fontRegularStyle(fontSize: 16, fontWeight: FontWeight.bold)
            ),
            SizedBox(height: 20,),
            Expanded(
                child: Container(
                  child: homeController.graphData == null || homeController.graphData?.value.details == null ?
                  Container() :
                  AppChart(graphData: homeController.graphData!.value.details!),
                )
            )
          ],
        ),
    );
  }
}
