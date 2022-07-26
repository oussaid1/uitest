import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:uitest/extentions.dart';
import 'package:uitest/glass_widgets.dart';
import 'package:uitest/models/client/shop_client.dart';
import '../models/chart_data.dart';
import '../models/debt/debt.dart';
import '../models/debt/debtsviewmodel.dart';
import '../models/payment/payment.dart';
import '../models/product/product.dart';
import '../search_by_widget.dart';
import '../stats_widget.dart';
import '../theme.dart';

class DebtsView extends StatelessWidget {
  const DebtsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: const [
          TopWidgetDebtsView(),
          _DebtList(),
        ],
      ),
    );
  }
}

class _DebtList extends StatefulWidget {
  const _DebtList({
    Key? key,
  }) : super(key: key);

  @override
  State<_DebtList> createState() => _DebtListState();
}

class _DebtListState extends State<_DebtList> {
  List<ClientDebt> clientDebts = [];
  String filter = '';
  ClientDebt? selectedClientDebt;
  @override
  Widget build(BuildContext context) {
    DebtsStatsViewModel debtsStatsViewModel = DebtsStatsViewModel(
        shopClients: ShopClientModel.fakeClients,
        debts: DebtModel.fakeDebts,
        payments: PaymentModel.fakePayments);
    clientDebts = debtsStatsViewModel.clientDebts
        .where((debt) => debt.shopClient.clientName!
            .toLowerCase()
            .contains(filter.toLowerCase()))
        .toList();
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          child: SearchByWidget(
            listOfCategories: ProductModel.fieldStrings,
            withCategory: false,
            onSearchTextChanged: (String text) {
              log('search text: $text');
              setState(() {
                filter = text;
              });
            },
            onBothChanged: (String category, String text) {
              log('both: $category, $text');
              //_data!.filterByCategory(category, text);
            },
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  minWidth: 420,
                  minHeight: 400,
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: clientDebts.length,
                  itemBuilder: (context, index) {
                    final clientDebt = clientDebts[index];
                    return Card(
                      color: const Color.fromARGB(127, 255, 255, 255),
                      elevation: 0,
                      child: DebtListCard(
                        clientDebt: clientDebt,
                        onTap: (value) {
                          setState(() {
                            selectedClientDebt = value;
                          });
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
            BluredContainer(
              width: 420,
              height: 400,
              child: DebtDetailsWidget(
                clientDebt: selectedClientDebt,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class DebtDetailsWidget extends ConsumerWidget {
  const DebtDetailsWidget({
    Key? key,
    required this.clientDebt,
  }) : super(key: key);
  final ClientDebt? clientDebt;

  @override
  Widget build(BuildContext context, ref) {
    return clientDebt != null
        ? Column(
            children: [
              /// title
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.person),
                        const SizedBox(width: 5),
                        Text(clientDebt!.shopClient.clientName!,
                            style: Theme.of(context).textTheme.headline3),
                      ],
                    ),
                    PriceNumberZone(
                      withDollarSign: true,
                      right: const SizedBox.shrink(), //const Text('left'),
                      price: clientDebt!.debtData.totalDebtAmount,
                      signSize: 14,
                      priceStyle:
                          Theme.of(context).textTheme.headline1!.copyWith(
                                color: const Color.fromARGB(255, 255, 255, 255),
                              ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromARGB(108, 255, 255, 255),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 9.0),
                child: Theme(
                  data: Theme.of(context).copyWith(
                    dividerColor: Colors.transparent,
                  ),
                  child: ExpansionTile(
                    title: Text('Actions',
                        style: Theme.of(context).textTheme.headline3),
                    trailing: const Icon(Icons.account_tree_outlined),
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Pay'),
                          const SizedBox(width: 10),
                          IconButton(
                            icon: Icon(Icons.payment),
                            onPressed: () {},
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Add Debt'),
                          const SizedBox(width: 10),
                          IconButton(
                            icon: Icon(Icons.add),
                            onPressed: () {},
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Remove Debt'),
                          IconButton(
                            icon: Icon(Icons.remove),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromARGB(108, 255, 255, 255),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 9.0),
                child: Theme(
                  data: Theme.of(context).copyWith(
                    dividerColor: Colors.transparent,
                  ),
                  child: ExpansionTile(
                    title: Text('Debts',
                        style: Theme.of(context).textTheme.headline3),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(clientDebt!.debtData.totalDebtAmount.toString(),
                            style: Theme.of(context).textTheme.bodySmall),
                        const Icon(Icons.keyboard_arrow_down),
                      ],
                    ),
                    children: [
                      SizedBox(
                        height: 140,
                        width: 400,
                        child: ListView.builder(
                            itemBuilder: (context, index) {
                              final debt = clientDebt!.allDebts[index];
                              return SimpleDebtCard(
                                debt: debt,
                              );
                            },
                            itemCount: clientDebt!.allDebts.length),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromARGB(108, 255, 255, 255),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 9.0),
                child: Theme(
                  data: Theme.of(context).copyWith(
                    dividerColor: Colors.transparent,
                  ),
                  child: ExpansionTile(
                    title: Text('Payments',
                        style: Theme.of(context).textTheme.headline3),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(clientDebt!.debtData.totalPayments.toString(),
                            style: Theme.of(context).textTheme.bodySmall),
                        const Icon(Icons.keyboard_arrow_down),
                      ],
                    ),
                    children: [
                      SizedBox(
                        height: 140,
                        width: 400,
                        child: ListView.builder(
                            itemBuilder: (context, index) {
                              final payment = clientDebt!.allPayments[index];
                              return SimplePaymentListCard(
                                payment: payment,
                              );
                            },
                            itemCount: clientDebt!.allPayments.length),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
        : const SizedBox.shrink();
  }
}

class TopWidgetDebtsView extends StatelessWidget {
  const TopWidgetDebtsView({
    Key? key,
    //required this.debtsStatsViewModel,
  }) : super(key: key);
  //final DebtsStatsViewModel debtsStatsViewModel;

  @override
  Widget build(BuildContext context) {
    DebtsStatsViewModel debtsStatsViewModel = DebtsStatsViewModel(
        shopClients: ShopClientModel.fakeClients,
        debts: DebtModel.fakeDebts,
        payments: PaymentModel.fakePayments);
    DebtData debtData = DebtData(
        allDebts: DebtModel.fakeDebts, allpayments: PaymentModel.fakePayments);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Wrap(
        runSpacing: 15,
        spacing: 15,
        children: [
          buildLineChartChart(context, debtData),
          buildPieChart(context, debtsStatsViewModel),
          const BluredContainer(
            width: 420,
            height: 270,
            child: DueDebtsCard(),
          ),
          Group116Widget(
            debtdata: debtData,
          ),
        ],
      ),
    );
  }
}

class DebtListCard extends StatelessWidget {
  const DebtListCard({
    Key? key,
    required this.clientDebt,
    required this.onTap,
  }) : super(key: key);

  final ClientDebt clientDebt;
  final Function(ClientDebt) onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(clientDebt),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: CircularPercentIndicator(
                    progressColor: Theme.of(context).colorScheme.secondary,
                    radius: 20,
                    lineWidth: 3,
                    percent: clientDebt.debtData.unitInterval,
                    center: Text(
                      '${clientDebt.debtData.totalDifferencePercentage}%',
                      style: Theme.of(context).textTheme.caption!,
                    ),
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '${clientDebt.shopClient.clientName}',
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          color:
                              Theme.of(context).colorScheme.primaryContainer),
                    ),
                    Text(
                      clientDebt.debtData.nearestDeadlineDate.ddmmyyyy(),
                      style: context.textTheme.subtitle2!.copyWith(
                        color: Theme.of(context).colorScheme.primaryContainer,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  PriceNumberZone(
                    withDollarSign: true,
                    // right: const SizedBox.shrink(), //const Text('left'),
                    price: clientDebt.debtData.totalLeft,
                    priceStyle: Theme.of(context).textTheme.headline2!.copyWith(
                          color: MThemeData.serviceColor,
                        ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'from /',
                        style: Theme.of(context).textTheme.subtitle2!.copyWith(
                            color:
                                Theme.of(context).colorScheme.primaryContainer),
                      ),
                      PriceNumberZone(
                        withDollarSign: true,
                        price: clientDebt.debtData.totalDebtAmount,
                        priceStyle:
                            Theme.of(context).textTheme.subtitle2!.copyWith(
                                  color: MThemeData.serviceColor,
                                ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

buildPieChart(BuildContext context, DebtsStatsViewModel data) {
  //DebtsStatsViewModel productData = data;
  return BluredContainer(
      width: 420,
      height: 270,
      child: Column(
        children: [
          SizedBox(
            height: 40,
            width: 420,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Debts',
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
            series: <DoughnutSeries<ChartData, String>>[
              DoughnutSeries<ChartData, String>(
                  radius: '80%',
                  explode: true,
                  explodeOffset: '20%',
                  dataSource: data.clientDebtTotal.take(8).toList(),
                  xValueMapper: (ChartData data, _) => data.label as String,
                  yValueMapper: (ChartData data, _) => data.value,
                  dataLabelMapper: (ChartData data, _) => data.label,
                  dataLabelSettings: const DataLabelSettings(
                    isVisible: false,
                    alignment: ChartAlignment.far,
                    angle: -45,
                  ))
            ],
          )),
        ],
      ));
}

buildLineChartChart(BuildContext context, DebtData data) {
  //DebtsStatsViewModel productData = data;
  return BluredContainer(
      width: 420,
      height: 270,
      child: Column(
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
                    dataSource: data.debtsChartDataMMYY,
                    xValueMapper: (ChartData sales, _) => sales.date,
                    yValueMapper: (ChartData sales, _) => sales.value),
                SplineSeries<ChartData, DateTime>(
                    name: 'Products'.tr(),
                    color: MThemeData.productColor,
                    dataSource: data.debtsChartDataMMYY,
                    xValueMapper: (ChartData sales, _) => sales.date,
                    yValueMapper: (ChartData sales, _) => sales.value),
                // SplineSeries<ChartData, DateTime>(
                //     name: 'Services'.tr(),
                //     color: MThemeData.serviceColor,
                //     dataSource: const [],
                //     xValueMapper: (ChartData sales, _) => sales.date,
                //     yValueMapper: (ChartData sales, _) => sales.value),
              ],
            ),
          ),
        ],
      ));
}

class DueDebtsCard extends StatelessWidget {
  const DueDebtsCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FilteredDebts filteredDebts = FilteredDebts(debts: DebtModel.fakeDebts);
    return SizedBox(
      height: 400,
      width: 420,
      child: Column(
        children: [
          SizedBox(
            width: 420,
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(FontAwesomeIcons.userClock),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 18.0, right: 18),
                      child: Text(
                        'Due Debts'.tr(),
                        style: Theme.of(context).textTheme.headline3!.copyWith(
                            color: Theme.of(context).colorScheme.primary),
                      ),
                    ),
                  ],
                ),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.more_vert_outlined,
                    ))
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: filteredDebts.overdueDebts().length,
              itemBuilder: (context, index) {
                filteredDebts
                    .overdueDebts()
                    .sort((a, b) => a.deadLine.compareTo(b.deadLine));
                final debt = filteredDebts.overdueDebts()[index];
                return SimpleDebtCard(
                  debt: debt,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class SimpleDebtCard extends StatelessWidget {
  const SimpleDebtCard({
    Key? key,
    required this.debt,
  }) : super(key: key);

  final DebtModel debt;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppConstants.radius),
          color: const Color.fromARGB(54, 255, 255, 255),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 17,
                  height: 40,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(AppConstants.radius),
                      bottomLeft: Radius.circular(AppConstants.radius),
                    ),
                    color: MThemeData.productColor,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  '${debt.clientId}',
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      color:
                          Theme.of(context).colorScheme.onSecondaryContainer),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: PriceNumberZone(
                withDollarSign: true,
                right: const SizedBox.shrink(), //const Text('left'),
                price: debt.amount,
                priceStyle: Theme.of(context).textTheme.headline4!.copyWith(
                      color: MThemeData.productColor,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SimplePaymentListCard extends StatelessWidget {
  const SimplePaymentListCard({
    Key? key,
    required this.payment,
  }) : super(key: key);

  final PaymentModel payment;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppConstants.radius),
          //   color: Theme.of(context).colorScheme.secondary,
          color: const Color.fromARGB(54, 255, 255, 255),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.all(0),
          dense: true,
          leading: const VerticalDivider(
            width: 0,
            thickness: 8,
            indent: 0,
            color: MThemeData.serviceColor,
          ),
          title: Text(
            '${payment.clientId}',
            style: Theme.of(context).textTheme.bodyText2!.copyWith(
                color: Theme.of(context).colorScheme.onSecondaryContainer),
          ),
          trailing: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: PriceNumberZone(
              withDollarSign: true,
              right: const SizedBox.shrink(), //const Text('left'),
              price: payment.amount,
              priceStyle: Theme.of(context).textTheme.headline4!.copyWith(
                    color: MThemeData.serviceColor,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}

class Group116Widget extends StatelessWidget {
  final DebtData debtdata;
  const Group116Widget({
    Key? key,
    required this.debtdata,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // Figma Flutter Generator Group116Widget - GROUP
    return BluredContainer(
      width: 420,
      height: 156,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(FontAwesomeIcons.moneyBillTransfer),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 18.0, right: 18),
                    child: Text(
                      'Debts'.tr(),
                      style: Theme.of(context).textTheme.headline3!.copyWith(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                  ),
                ],
              ),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.more_vert_outlined,
                  ))
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: LinearPercentIndicator(
                  percent: debtdata.unitInterval,
                  progressColor: MThemeData.expensesColor,
                ),
              ),
              Text(
                '${debtdata.totalDifferencePercentage}%',
                style: Theme.of(context).textTheme.headline4!.copyWith(
                      color: MThemeData.productColor,
                    ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 18.0, right: 18),
                child: Column(
                  children: [
                    Text(
                      'Highest'.tr(),
                      style: Theme.of(context).textTheme.headline3!.copyWith(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                    PriceNumberZone(
                      price: debtdata.highestDebtAmount,
                      withDollarSign: true,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Padding(
                padding: const EdgeInsets.only(left: 18.0, right: 18),
                child: Column(
                  children: [
                    Text(
                      'Lowest'.tr(),
                      style: Theme.of(context).textTheme.headline3!.copyWith(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                    PriceNumberZone(
                      price: debtdata.lowestDebtAmount,
                      withDollarSign: true,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Divider(
            height: 0,
            thickness: 1,
            color: Color.fromARGB(202, 255, 255, 255),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 8, right: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: context.theme.onSecondaryContainer),
                ),
                PriceNumberZone(
                  right: const SizedBox.shrink(),
                  withDollarSign: true,
                  price: debtdata.totalDebtAmount,
                  priceStyle: context.textTheme.bodyLarge!.copyWith(
                      //fontWeight: FontWeight.w100,
                      // wordSpacing: 0.5,
                      fontSize: 18,
                      color: Colors.white.withOpacity(0.8)),
                  // style: Theme.of(context)
                  //     .textTheme
                  //     .headline2!
                  //     .copyWith(color: context.theme.primary),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
