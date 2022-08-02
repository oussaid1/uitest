import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:uitest/extentions.dart';
import 'package:uitest/models/recharge/recharge.dart';
import '../../../theme.dart';

class RechargePieChartData {
  String? label;
  List<RechargeModel>? list;

  Color? get color {
    if (list == null) {
      return null;
    }
    switch (label) {
      case 'INWI':
        return RechargeModel.inwi;
      case 'IAM':
        return RechargeModel.iam;
      case 'ORANGE':
        return RechargeModel.orange;
      default:
        return null;
    }
  }

  RechargePieChartData({
    required this.label,
    required this.list,
  });
  num get amount {
    return list?.fold(0, (num sum, e) => sum + e.amount) as num;
  }

  num get percent {
    return list?.fold(0, (num sum, e) => sum + e.percntg) as num;
  }

  num get profit {
    return list?.fold(0, (num sum, e) => sum + e.netProfit) as num;
  }

  num get quantity {
    return list?.fold(0, (num sum, e) => sum + e.qntt) as num;
  }
}

class RechargePieChart extends StatelessWidget {
  final List<RechargePieChartData> data;
  final String title;
  const RechargePieChart({
    Key? key,
    required this.title,
    required this.data,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 40,
          width: 420,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .headline3!
                    .copyWith(color: context.theme.primary),
              ),
            ],
          ),
        ),
        Expanded(
            child: SfCircularChart(
          backgroundColor: Colors.transparent,
          legend: Legend(
              isVisible: true, overflowMode: LegendItemOverflowMode.wrap),
          tooltipBehavior: TooltipBehavior(enable: true),
          series: _getDefaultDoughnutSeries(),
        )),
      ],
    );
  }

  ///Get the default circular series
  List<DoughnutSeries<RechargePieChartData, String>>
      _getDefaultDoughnutSeries() {
    return <DoughnutSeries<RechargePieChartData, String>>[
      DoughnutSeries<RechargePieChartData, String>(
          radius: '80%',
          explode: true,
          explodeOffset: '20%',
          dataSource: data,
          legendIconType: LegendIconType.horizontalLine,
          pointColorMapper: (RechargePieChartData data, _) => data.color,
          xValueMapper: (RechargePieChartData data, _) => data.label as String,
          yValueMapper: (RechargePieChartData data, _) => data.quantity,
          dataLabelMapper: (RechargePieChartData data, _) => data.label,
          enableTooltip: true,
          dataLabelSettings: const DataLabelSettings(
            isVisible: false,
            alignment: ChartAlignment.far,
            angle: -45,
          )),
    ];
  }
}

class RechargeBarChart extends StatelessWidget {
  final List<RechargePieChartData> data;
  final String title;
  const RechargeBarChart({
    Key? key,
    required this.data,
    required this.title,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          fit: FlexFit.tight,
          flex: 1,
          child: SfCartesianChart(
            borderWidth: 0,
            legend: Legend(
              isVisible: true,
              overflowMode: LegendItemOverflowMode.wrap,
              position: LegendPosition.top,
              height: '50%',
              legendItemBuilder: (legendText, series, point, seriesIndex) {
                return SizedBox(
                    height: 16,
                    width: 80,
                    child: Row(children: <Widget>[
                      Icon(Icons.bar_chart_rounded,
                          size: 16, color: series.color),
                      Text(
                        legendText,
                        style: Theme.of(context).textTheme.subtitle2!,
                      ),
                    ]));
              },
              alignment: ChartAlignment.center,
              textStyle: Theme.of(context)
                  .textTheme
                  .subtitle2!
                  .copyWith(fontSize: 12, color: MThemeData.secondaryColor),
            ),
            annotations: const <CartesianChartAnnotation>[
              CartesianChartAnnotation(
                  widget: SizedBox(child: Text('Empty data')),
                  coordinateUnit: CoordinateUnit.point,
                  region: AnnotationRegion.plotArea,
                  x: 3.5,
                  y: 60),
            ],
            enableAxisAnimation: true,
            plotAreaBorderColor: Colors.transparent,
            plotAreaBorderWidth: 0,
            plotAreaBackgroundColor: Colors.transparent,
            primaryXAxis: CategoryAxis(
              majorGridLines: const MajorGridLines(width: 0),
            ),
            primaryYAxis: NumericAxis(
              minimum: 0,
              labelRotation: 0,
              labelStyle: Theme.of(context).textTheme.subtitle2!,
              majorGridLines: const MajorGridLines(width: 0),
              majorTickLines: const MajorTickLines(width: 0),
              minorGridLines: const MinorGridLines(width: 0),
              minorTickLines: const MinorTickLines(width: 0),
            ),
            series: <ChartSeries>[
              ColumnSeries<RechargePieChartData, String>(
                  name: 'Quantity'.tr(),
                  color: Color.fromARGB(255, 39, 87, 176),
                  dataSource: data,
                  xValueMapper: (RechargePieChartData data, _) => data.label,
                  yValueMapper: (RechargePieChartData data, z) =>
                      data.quantity),
              ColumnSeries<RechargePieChartData, String>(
                  name: 'Amount'.tr(),
                  color: Color.fromARGB(253, 0, 177, 103),
                  dataSource: data,
                  xValueMapper: (RechargePieChartData data, _) => data.label,
                  yValueMapper: (RechargePieChartData data, z) => data.amount),
              ColumnSeries<RechargePieChartData, String>(
                  name: 'Profit'.tr(),
                  color: Color.fromARGB(255, 243, 33, 79),
                  dataSource: data,
                  xValueMapper: (RechargePieChartData data, _) => data.label,
                  yValueMapper: (RechargePieChartData data, z) => data.profit),
            ],
          ),
        ),
      ],
    );
  }
}

// _buildGroup(RechargePieChartData data) {
//   return [
//     ColumnSeries<RechargePieChartData, String>(
//         name: 'INWI'.tr(),
//         color: RechargeModel.inwi,
//         dataSource: data,
//         xValueMapper: (RechargePieChartData data, _) => data.label,
//         yValueMapper: (RechargePieChartData data, z) => data.quantity),
//     ColumnSeries<RechargePieChartData, String>(
//         name: 'ORANGE'.tr(),
//         color: RechargeModel.orange,
//         dataSource: data,
//         xValueMapper: (RechargePieChartData data, _) => data.label,
//         yValueMapper: (RechargePieChartData data, z) => data.amount),
//     ColumnSeries<RechargePieChartData, String>(
//         name: 'IAM'.tr(),
//         color: RechargeModel.iam,
//         dataSource: data,
//         xValueMapper: (RechargePieChartData data, _) => data.label,
//         yValueMapper: (RechargePieChartData data, z) => data.profit),
//   ];
// }
