import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:uitest/extentions.dart';
import 'package:uitest/glass_widgets.dart';
import 'package:uitest/models/recharge/recharge.dart';
import '../../../theme.dart';

class RechargeSaleChartData {
  String? label;
  DateTime? date;
  List<RechargeSaleModel>? list;

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

  RechargeSaleChartData({
    required this.label,
    this.date,
    required this.list,
  });
  num get amount {
    return list?.fold(0, (num sum, e) => sum + e.amount) as num;
  }

  num get percent {
    return list?.fold(0, (num sum, e) => sum + e.percntg) as num;
  }

  num get total {
    return list?.fold(0, (num sum, e) => sum + e.totalAmount) as num;
  }

  num get quantitySold {
    return list?.fold(0, (num sum, e) => sum + e.qnttSld) as num;
  }

  num get netProfit {
    return list?.fold(0, (num sum, e) => sum + (e.netProfit) * e.qnttSld)
        as num;
  }
}

class RechargeSalePieChart extends StatelessWidget {
  final List<RechargeSaleChartData> data;
  final String title;
  const RechargeSalePieChart({
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
  List<DoughnutSeries<RechargeSaleChartData, String>>
      _getDefaultDoughnutSeries() {
    return <DoughnutSeries<RechargeSaleChartData, String>>[
      DoughnutSeries<RechargeSaleChartData, String>(
          radius: '80%',
          explode: true,
          explodeOffset: '20%',
          dataSource: data,
          pointColorMapper: (RechargeSaleChartData data, _) => data.color,
          xValueMapper: (RechargeSaleChartData data, _) => data.label as String,
          yValueMapper: (RechargeSaleChartData data, _) => data.quantitySold,
          dataLabelMapper: (RechargeSaleChartData data, _) => data.label,
          dataLabelSettings: const DataLabelSettings(
            isVisible: false,
            alignment: ChartAlignment.far,
            angle: -45,
          )),
    ];
  }
}

class RechargeSaleBarChart extends StatelessWidget {
  final List<RechargeSaleChartData> data;
  final String title;
  const RechargeSaleBarChart({
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
              // textStyle: Theme.of(context)
              //     .textTheme
              //     .subtitle2!
              //     .copyWith(fontSize: 12, color: MThemeData.secondaryColor),
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
              labelStyle: Theme.of(context).textTheme.subtitle2!.copyWith(),
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
              ColumnSeries<RechargeSaleChartData, String>(
                  name: 'INWI'.tr(),
                  color: RechargeModel.inwi,
                  dataSource: data,
                  xValueMapper: (RechargeSaleChartData data, _) => 'Sales',
                  yValueMapper: (RechargeSaleChartData data, z) =>
                      data.quantitySold),
              ColumnSeries<RechargeSaleChartData, String>(
                  name: 'ORANGE'.tr(),
                  color: RechargeModel.orange,
                  dataSource: data,
                  xValueMapper: (RechargeSaleChartData data, _) => "Sales",
                  yValueMapper: (RechargeSaleChartData data, z) => data.amount),
              ColumnSeries<RechargeSaleChartData, String>(
                  name: 'IAM'.tr(),
                  color: RechargeModel.iam,
                  dataSource: data,
                  xValueMapper: (RechargeSaleChartData data, _) => "Sales",
                  yValueMapper: (RechargeSaleChartData data, z) => data.total),
            ],
          ),
        ),
      ],
    );
  }
}

// _buildGroup(RechargeSalePieChartData data) {
//   return [
//     ColumnSeries<RechargeSalePieChartData, String>(
//         name: 'INWI'.tr(),
//         color: RechargeSaleModel.inwi,
//         dataSource: data,
//         xValueMapper: (RechargeSalePieChartData data, _) => data.label,
//         yValueMapper: (RechargeSalePieChartData data, z) => data.quantity),
//     ColumnSeries<RechargeSalePieChartData, String>(
//         name: 'ORANGE'.tr(),
//         color: RechargeSaleModel.orange,
//         dataSource: data,
//         xValueMapper: (RechargeSalePieChartData data, _) => data.label,
//         yValueMapper: (RechargeSalePieChartData data, z) => data.amount),
//     ColumnSeries<RechargeSalePieChartData, String>(
//         name: 'IAM'.tr(),
//         color: RechargeSaleModel.iam,
//         dataSource: data,
//         xValueMapper: (RechargeSalePieChartData data, _) => data.label,
//         yValueMapper: (RechargeSalePieChartData data, z) => data.profit),
//   ];
// }

///////////////////////////////////////////////////////////////////////

class RechargeSaleLineChart extends StatelessWidget {
  final String title;
  final List<RechargeSaleChartData> inwiData;
  final List<RechargeSaleChartData> orangeData;
  final List<RechargeSaleChartData> iamData;

  const RechargeSaleLineChart({
    Key? key,
    required this.title,
    required this.iamData,
    required this.inwiData,
    required this.orangeData,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          flex: 2,
          fit: FlexFit.tight,
          child: SfCartesianChart(
            backgroundColor: Colors.transparent,
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
            primaryXAxis: DateTimeAxis(
              majorGridLines: const MajorGridLines(width: 0),
              intervalType: DateTimeIntervalType.days,
              dateFormat: DateFormat.MMMd(),
              interval: 1,
              axisLine: const AxisLine(width: 0.5),
              //labelFormat: 'dd/MM',
              edgeLabelPlacement: EdgeLabelPlacement.shift,
              labelStyle: Theme.of(context).textTheme.subtitle2!,
            ),
            enableAxisAnimation: true,
            plotAreaBorderColor: Colors.transparent,
            plotAreaBorderWidth: 0,
            plotAreaBackgroundColor: Colors.transparent,
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
              // Renders spline chart
              SplineSeries<RechargeSaleChartData, DateTime>(
                  name: 'Orange'.tr(),
                  color: RechargeModel.orange,
                  dataSource: orangeData,
                  xValueMapper: (RechargeSaleChartData sales, _) => sales.date,
                  yValueMapper: (RechargeSaleChartData sales, _) =>
                      sales.netProfit),
              SplineSeries<RechargeSaleChartData, DateTime>(
                  name: 'IAM'.tr(),
                  color: RechargeModel.iam,
                  dataSource: iamData,
                  xValueMapper: (RechargeSaleChartData sales, _) => sales.date,
                  yValueMapper: (RechargeSaleChartData sales, _) =>
                      sales.netProfit),
              SplineSeries<RechargeSaleChartData, DateTime>(
                  name: 'Inwi'.tr(),
                  color: RechargeModel.inwi,
                  dataSource: inwiData,
                  xValueMapper: (RechargeSaleChartData sales, _) => sales.date,
                  yValueMapper: (RechargeSaleChartData sales, _) =>
                      sales.netProfit),
            ],
          ),
        ),
      ],
    );
  }
}
