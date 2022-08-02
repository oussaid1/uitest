import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:uitest/extentions.dart';
import '../glass_widgets.dart';
import '../models/models.dart';
import '../theme.dart';

class LineChart extends ConsumerWidget {
  final String title;
  final List<ChartData> data;

  const LineChart({
    Key? key,
    required this.title,
    required this.data,
  }) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
              SplineSeries<ChartData, DateTime>(
                  name: 'Sales'.tr(),
                  color: MThemeData.salesColor,
                  dataSource: const [],
                  xValueMapper: (ChartData sales, _) => sales.date,
                  yValueMapper: (ChartData sales, _) => sales.value),
              SplineSeries<ChartData, DateTime>(
                  name: 'Products'.tr(),
                  color: MThemeData.productColor,
                  dataSource: data,
                  xValueMapper: (ChartData sales, _) => sales.date,
                  yValueMapper: (ChartData sales, _) => sales.value),
              SplineSeries<ChartData, DateTime>(
                  name: 'Services'.tr(),
                  color: MThemeData.serviceColor,
                  dataSource: const [],
                  xValueMapper: (ChartData sales, _) => sales.date,
                  yValueMapper: (ChartData sales, _) => sales.value),
            ],
          ),
        ),
      ],
    );
  }
}

// class ChartData {
//   String? label;
//   double? value;
//   DateTime? date;
//   Color? color;
//   ChartData(this.label, this.value, this.date, [this.color]);
// }

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
                  color: MThemeData.productColor,
                  dataSource: data,
                  xValueMapper: (ChartData sales, _) => (sales.date),
                  yValueMapper: (ChartData sales, z) => sales.value),
              ColumnSeries<ChartData, DateTime>(
                  name: 'Products',
                  color: MThemeData.serviceColor,
                  dataSource: [],
                  xValueMapper: (ChartData sales, _) => sales.date,
                  yValueMapper: (ChartData sales, _) => sales.value),
              ColumnSeries<ChartData, DateTime>(
                  name: 'Sales',
                  color: MThemeData.expensesColor,
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

class RadialChart extends StatelessWidget {
  final String title;
  final Revenu? data;
  const RadialChart({
    Key? key,
    required this.title,
    this.data,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    List<ChartData> chartData = [
      ChartData(
        color: MThemeData.revenuColor,
        label: 'Revenu',
        value: 4530,
      ),
      ChartData(
        color: MThemeData.expensesColor,
        label: 'Expense',
        value: 535,
      ),
      ChartData(
        color: MThemeData.productColor,
        label: 'Debts',
        value: 6678,
      ),
      ChartData(
        color: MThemeData.incomeColor,
        label: 'Incomes',
        value: 700,
      ),
      ChartData(
        color: MThemeData.profitColor,
        label: 'Profit',
        value: 4560,
      ),
    ];

    return Material(
        color: Colors.transparent,
        child: BluredContainer(
          child: Column(
            children: [
              Stack(
                fit: StackFit.passthrough,
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: SizedBox(
                        // color: Color.fromARGB(137, 255, 245, 231),
                        height: 160,
                        child: SfCircularChart(
                          centerX: '90',
                          series: [
                            RadialBarSeries<ChartData, String>(
                              animationDuration: 0,
                              radius: '110%',
                              gap: '12%',
                              //  trackColor: Theme.of(context).colorScheme.background,
                              innerRadius: '20%',
                              animationDelay: 200,
                              dataLabelSettings: DataLabelSettings(
                                  textStyle: Theme.of(context)
                                      .textTheme
                                      .subtitle2!
                                      .copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary),
                                  isVisible: false,
                                  labelPosition: ChartDataLabelPosition.inside),
                              dataSource: chartData,
                              cornerStyle: CornerStyle.bothCurve,
                              xValueMapper: (ChartData data, _) => data.label,
                              // '${data.label} : ${data.value!.toPrecision()}',
                              yValueMapper: (ChartData data, _) => data.value,
                              pointColorMapper: (ChartData data, _) =>
                                  data.color,
                              dataLabelMapper: (ChartData data, _) =>
                                  data.value!.toString(),
                            )
                          ],
                          tooltipBehavior: TooltipBehavior(enable: true),
                        )),
                  ),
                  Positioned(
                    right: 15,
                    height: 200,
                    width: 180,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildLegendItem(context,
                            color: chartData[0].color!,
                            label: chartData[0].label!,
                            value: chartData[0].value!),
                        _buildLegendItem(context,
                            color: chartData[1].color!,
                            label: chartData[1].label!,
                            value: chartData[1].value!),
                        _buildLegendItem(context,
                            color: chartData[2].color!,
                            label: chartData[2].label!,
                            value: chartData[2].value!),
                        _buildLegendItem(context,
                            color: chartData[3].color!,
                            label: chartData[3].label!,
                            value: chartData[3].value!),
                        _buildLegendItem(context,
                            color: chartData[4].color!,
                            label: chartData[4].label!,
                            value: chartData[4].value!),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }

  _buildLegendItem(BuildContext context,
      {required String label, required Color color, required num value}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 4),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Text(label,
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2!
                        .copyWith(color: color)),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Text('$value',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.subtitle2!),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
