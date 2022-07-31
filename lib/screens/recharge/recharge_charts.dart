import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:uitest/extentions.dart';
import 'package:uitest/models/recharge/recharge.dart';

import '../../models/chart_data.dart';
import '../../theme.dart';

class REchargeSalesChartsCard extends StatelessWidget {
  const REchargeSalesChartsCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 15,
      direction: Axis.horizontal,
      runSpacing: 15,
      children: const [
        PieChart(
          data: [],
          title: '',
        ),
        BarChart(
          data: [],
          title: '',
        ),
      ],
    );
  }
}

class PieChart extends StatelessWidget {
  final List<ChartData> data;
  final String title;
  const PieChart({
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
  List<DoughnutSeries<ChartData, String>> _getDefaultDoughnutSeries() {
    return <DoughnutSeries<ChartData, String>>[
      DoughnutSeries<ChartData, String>(
          radius: '80%',
          explode: true,
          explodeOffset: '20%',
          dataSource: data.take(8).toList(),
          xValueMapper: (ChartData data, _) => data.label as String,
          yValueMapper: (ChartData data, _) => data.value,
          dataLabelMapper: (ChartData data, _) => data.label,
          dataLabelSettings: const DataLabelSettings(
            isVisible: false,
            alignment: ChartAlignment.far,
            angle: -45,
          ))
    ];
  }
}

class BarChart extends StatelessWidget {
  final List<ChartData> data;
  final String title;
  const BarChart({
    Key? key,
    required this.data,
    required this.title,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    List<ChartData> fdata = RechargeModel.fakeData.map((element) {
      return ChartData(
        label: element.oprtr.name,
        value: element.amount,
      );
    }).toList();
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
              ColumnSeries<ChartData, DateTime>(
                  name: 'Services'.tr(),
                  color: RechargeModel.inwi,
                  dataSource: fdata,
                  xValueMapper: (ChartData sales, _) => (sales.date),
                  yValueMapper: (ChartData sales, z) => sales.value),
              ColumnSeries<ChartData, DateTime>(
                  name: 'Products',
                  color: RechargeModel.orange,
                  dataSource: [],
                  xValueMapper: (ChartData sales, _) => sales.date,
                  yValueMapper: (ChartData sales, _) => sales.value),
              ColumnSeries<ChartData, DateTime>(
                  name: 'Sales',
                  color: RechargeModel.iam,
                  dataSource: [],
                  xValueMapper: (ChartData sales, _) => sales.date,
                  yValueMapper: (ChartData sales, _) => sales.value),
            ],
          ),
        ),
      ],
    );
  }
}
