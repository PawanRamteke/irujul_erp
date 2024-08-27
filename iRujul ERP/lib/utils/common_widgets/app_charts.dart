import 'package:flutter/material.dart';
import 'package:irujul_erp/models/dashboard_model.dart';
import 'package:irujul_erp/utils/colors.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
class AppChart extends StatelessWidget {
  List<Details> graphData;
  AppChart({super.key, required this.graphData});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SfCartesianChart(
          primaryXAxis: CategoryAxis(maximumLabels: 2),
          primaryYAxis: NumericAxis(),
          tooltipBehavior: TooltipBehavior(enable: true),
          series: <CartesianSeries<Details, String>>[
            ColumnSeries<Details, String>(
                dataSource: graphData,
                xValueMapper: (Details data, _) => data.category,
                yValueMapper: (Details data, index) => double.parse(data.saleAmount ?? "0"),
                name: "",
                color: Color.fromRGBO(8, 142, 255, 1),
              dataLabelSettings: DataLabelSettings(
                  isVisible: true, // Make data labels visible
                  textStyle: TextStyle(color: Colors.black), // Customize text style
                  labelAlignment: ChartDataLabelAlignment.middle,
                  angle: 90,
                showZeroValue: false
              ),
            ),
          ])
    );
  }
}

class ChartData {
  ChartData(this.month, this.value);
  final String month;
  final double value;
}
