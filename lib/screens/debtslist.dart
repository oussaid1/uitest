import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:uitest/extentions.dart';
import 'package:uitest/glass_widgets.dart';
import 'package:uitest/models/client/shop_client.dart';
import '../models/debt/debt.dart';
import '../models/payment/payment.dart';
import '../models/product/product.dart';
import '../models/product_data.dart';
import '../popups.dart';
import '../search_by_widget.dart';
import '../stats_widget.dart';
import '../theme.dart';
import '../widgets/charts.dart';

class DebtsView extends StatelessWidget {
  const DebtsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: const [
        TopWidgetDebtsView(),
        Expanded(child: _DebtList()),
      ],
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
  List<DebtModel> debts = [];
  String filter = '';
  @override
  Widget build(BuildContext context) {
    DebtsStatsViewModel debtsStatsViewModel = DebtsStatsViewModel(
        shopClients: ShopClientModel.fakeClients,
        debts: DebtModel.getFakeDebts(),
        payments: PaymentModel.fakePayments);
    debts = DebtModel.getFakeDebts()
        .where((debt) =>
            debt.clientName!.toLowerCase().contains(filter.toLowerCase()))
        .toList();
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 8),
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
        Expanded(
          flex: 1,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: debts.length,
            itemBuilder: (context, index) {
              final debt = debts[index];
              return Card(
                color: const Color.fromARGB(127, 255, 255, 255),
                elevation: 0,
                child: Slidable(
                  startActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    dismissible: DismissiblePane(onDismissed: () {}),
                    children: [
                      SlidableAction(
                        onPressed: (context) {
                          MDialogs.dialogSimple(
                            context,
                            title: Text(
                              "Pay",
                              style: Theme.of(context).textTheme.headline3!,
                            ),
                            contentWidget: const SizedBox(
                              height: 400,
                              width: 400,
                              // child: AddPayment(
                              //   payingStatus: PayingStatus.paying,
                              //   payment: PaymentModel(
                              //     amount: debt.amount,
                              //     date: debt.timeStamp,
                              //     clientId: debt.clientId!,
                              //     clientName: debt.clientId,
                              //     description: '',
                              //   ),
                              // ),
                            ),
                          );
                        },
                        label: ("Pay").tr(),
                      ),
                    ],
                  ),
                  endActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    dismissible: DismissiblePane(onDismissed: () {}),
                    children: [
                      SlidableAction(
                          icon: Icons.delete,
                          onPressed: (context) {
                            MDialogs.dialogSimple(
                              context,
                              title: Text(
                                "Add Client",
                                style: Theme.of(context).textTheme.headline3!,
                              ),
                              contentWidget: const SizedBox(
                                height: 500,
                                width: 400,
                                // child: AddDebt(
                                //   debt: debt,
                                // ),
                              ),
                            );
                          }),
                      IconButton(
                        icon: Icon(
                          Icons.delete_forever,
                          size: 30,
                          color: Theme.of(context).errorColor,
                        ),
                        color: Colors.transparent,
                        onPressed: () {
                          MDialogs.dialogSimple(context,
                              title: const Text('Are you sure !!?').tr(),
                              widgets: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: 120,
                                      child: TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        style: TextButton.styleFrom(
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .headline3,
                                          minimumSize: const Size(88, 36),
                                          elevation: 0,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8),
                                          shape: const RoundedRectangleBorder(
                                            side: BorderSide(
                                                color: MThemeData.accentColor),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(6)),
                                          ),
                                        ),
                                        child: const Text('Cancel'),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    SizedBox(
                                      width: 120,
                                      child: TextButton(
                                        onPressed: () {
                                          // ref
                                          //     .read(databaseProvider)!
                                          //     .deleteDebt(debt)
                                          //     .then((value) {
                                          //   if (value) {
                                          //     ScaffoldMessenger.of(context)
                                          //         .showSnackBar(MDialogs.snackBar(
                                          //             'Done !'));

                                          //     Navigator.of(context).pop();
                                          //   } else {
                                          //     ScaffoldMessenger.of(context)
                                          //         .showSnackBar(
                                          //             MDialogs.errorSnackBar(
                                          //                 'Error !'));
                                          //   }
                                          // });
                                        },
                                        style: TextButton.styleFrom(
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .headline3,
                                          minimumSize: const Size(88, 36),
                                          backgroundColor: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                          elevation: 0,
                                          // disabledForegroundColor:
                                          //     Theme.of(context)
                                          //         .colorScheme
                                          //         .primary,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8),
                                          shape: const RoundedRectangleBorder(
                                            side: BorderSide(
                                                color: MThemeData.accentColor),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(6)),
                                          ),
                                        ),
                                        child: Text(
                                          'Ok',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline3,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ]);
                        },
                      ),
                    ],
                  ),
                  child: DebtListCard(debt: debt),
                ),
              );
            },
          ),
        ),
      ],
    );
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
        debts: DebtModel.getFakeDebts(),
        payments: PaymentModel.fakePayments);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Wrap(
        runSpacing: 15,
        spacing: 15,
        children: [
          buildLineChartChart(debtsStatsViewModel),
          buildPieChart(debtsStatsViewModel),
          const BluredContainer(
            width: 420,
            height: 270,
            child: DueDebtsCard(),
          ),
        ],
      ),
    );
  }
}

class DebtListCard extends StatelessWidget {
  const DebtListCard({
    Key? key,
    required this.debt,
  }) : super(key: key);

  final DebtModel debt;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
        ),
        child: ExpansionTile(
          collapsedBackgroundColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          tilePadding: const EdgeInsets.symmetric(horizontal: 8),
          leading: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            width: 40,
            child: const CircleAvatar(
              backgroundColor: Color.fromARGB(136, 255, 255, 255),
              radius: 55,
              child: Icon(
                Icons.person_outline_sharp,
                color: MThemeData.hintTextColor,
              ),
            ),
          ),
          title: Text(
            '${debt.clientName}',
            style: Theme.of(context)
                .textTheme
                .bodyText2!
                .copyWith(color: Theme.of(context).colorScheme.primary),
          ),
          // subtitle: PriceNumberZone(
          //   withDollarSign: true,
          //   // right: const SizedBox.shrink(), //const Text('left'),
          //   price: debt.amount,
          //   // style: Theme.of(context).textTheme.headline2!.copyWith(
          //   //       color: MThemeData.serviceColor,
          //   //     ),
          // ),
          trailing: Text(
            debt.deadLine.ddmmyyyy(),
            style: context.textTheme.bodyText2!.copyWith(
              color: Theme.of(context).colorScheme.primaryContainer,
            ),
          ),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: 'Days :'.tr(),
                        style: Theme.of(context).textTheme.subtitle2!,
                        children: [
                          TextSpan(
                            text: ' ${debt.daysOverdue}',
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
                                      color: MThemeData.serviceColor,
                                    ),
                          ),
                        ],
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        text: 'Since :'.tr(),
                        style: Theme.of(context).textTheme.subtitle2!,
                        children: [
                          TextSpan(
                            text: ' ${debt.timeStamp.ddmmyyyy()}',
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
                                      color: MThemeData.expensesColor,
                                    ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: ' Amount :'.tr(),
                        style: Theme.of(context).textTheme.subtitle2!,
                        children: [
                          TextSpan(
                            text: ' ${debt.amount}',
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
                                      color: MThemeData.expensesColor,
                                    ),
                          ),
                        ],
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        text: 'Product :'.tr(),
                        style: Theme.of(context).textTheme.subtitle2!,
                        children: [
                          TextSpan(
                              text: '${debt.type}',
                              style: Theme.of(context).textTheme.subtitle2),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

DebtsStatsViewModel data = DebtsStatsViewModel(
    shopClients: ShopClientModel.fakeClients,
    debts: DebtModel.getFakeDebts(),
    payments: PaymentModel.fakePayments);
buildPieChart(DebtsStatsViewModel data) {
  var productData = ProductData(products: ProductModel.fakeData);
  return BluredContainer(
    width: 420,
    height: 270,
    child: PieChart(
      title: 'Products',
      data: productData.chartDataByCategory, // chartData(),
    ),
  );
}

buildLineChartChart(DebtsStatsViewModel data) {
  var productData = ProductData(products: ProductModel.fakeData);
  return BluredContainer(
    width: 420,
    height: 270,
    child: LineChart(
      title: 'Products',
      data: productData.chartDataByCategory, // chartData(),
    ),
  );
}

enum DebtFilter {
  all,
  overdue,
  today,
  thisWeek,
  thisMonth,
  thisYear,
}

class DebtsStatsViewModel {
  DebtsStatsViewModel({
    required this.debts,
    required this.payments,
    required this.shopClients,
    this.filter = DebtFilter.all,
  });

  final List<DebtModel> debts;
  final List<PaymentModel> payments;
  final List<ShopClientModel> shopClients;
  final DebtFilter? filter;

  /// join each client to its debts payments and debts as a list of ShopClientsDeb
  List<ClientDebt> get clientDebts {
    List<ClientDebt> list = [];
    for (var i = 0; i < shopClients.length; i++) {
      list.add(ClientDebt(
          shopClient: shopClients[i],
          debts: debts
              .where((element) => shopClients[i].id == element.id)
              .toList(),
          payments: payments
              .where((element) => shopClients[i].id == element.id)
              .toList()));
    }

    return list;
  }

  /// conver clientsDebts to
}

class DueDebtsCard extends StatelessWidget {
  const DueDebtsCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FilteredDebts filteredDebts =
        FilteredDebts(debts: DebtModel.getFakeDebts());
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
                        color: MThemeData.productColor,
                      ),
                      title: Text(
                        '${debt.clientName}',
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onSecondaryContainer),
                      ),
                      trailing: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: PriceNumberZone(
                          withDollarSign: true,
                          right: const SizedBox.shrink(), //const Text('left'),
                          price: debt.amount,
                          priceStyle:
                              Theme.of(context).textTheme.headline4!.copyWith(
                                    color: MThemeData.productColor,
                                  ),
                        ),
                      ),
                      // subtitle: Text(
                      //   '',
                      //   //debt.deadLine.ddmmyyyy(),
                      //   style: Theme.of(context)
                      //       .textTheme
                      //       .subtitle2!
                      //       .copyWith(color: MThemeData.productColor),
                      // ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
