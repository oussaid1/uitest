import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:uitest/extentions.dart';
import 'package:uitest/glass_widgets.dart';
import 'package:uitest/models/models.dart';
import 'package:uitest/models/recharge/recharge.dart';
import 'package:uitest/models/recharge/recharge_viewmodel.dart';
import 'package:uitest/models/recharge/recharges_data.dart';
import 'package:uitest/screens/recharge/sell_recharge.dart';
import 'package:uitest/search_by_widget.dart';
import '../../../expandable_fab.dart';
import '../../../models/recharge/filtered_recharges.dart';
import '../../../popups.dart';
import '../add_recharge.dart';
import 'recharge_charts.dart';
import 'recharge_stock_iventory.dart';

class RechargeStockView extends StatelessWidget {
  const RechargeStockView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RecghargeViewModel viewModel = RecghargeViewModel(
        shopClients: ShopClientModel.fakeClients,
        rechargeList: RechargeModel.fakeData,
        rechargeSalesList: RechargeSaleModel.fakeData);
    RechargeData data = RechargeData(rechargesList: RechargeModel.fakeData);
    FilteredRecharges filteredRecharges = FilteredRecharges(
      rechargeList: RechargeModel.fakeData,
    );
    RechargeData data1 = RechargeData(
      rechargesList: RechargeModel.fakeData,
    );
    List<ShopClientRechargesData> shopClientRechargesData =
        viewModel.shopClientCombinedRechargeSales;
    var inwiOrangeIam = [
      data1.oprtrRechargeChartData('inwi', filteredRecharges.inwiList),
      data1.oprtrRechargeChartData('orange', filteredRecharges.orangeList),
      data1.oprtrRechargeChartData('iam', filteredRecharges.iamList)
    ];
    return SingleChildScrollView(
      child: Column(
        children: [
          Wrap(
            runSpacing: 15,
            spacing: 15,
            children: [
              RechargeOverAllWidget(data: inwiOrangeIam),
              BluredContainer(
                height: 300,
                width: 420,
                child: RechargePieChart(
                  data: data.oprtrRechargeAmntStckList,
                  title: 'Stock-Quantity',
                ),
              ),
              BluredContainer(
                height: 300,
                width: 420,
                child: RechargeBarChart(
                  data: data.oprtrRechargeAmntStckList,
                  title: 'Stock',
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          const RchargeStockList(),
        ],
      ),
    );
  }
}

class RchargeStockList extends StatefulWidget {
  const RchargeStockList({
    Key? key,
  }) : super(key: key);

  @override
  State<RchargeStockList> createState() => _RchargeStockListState();
}

class _RchargeStockListState extends State<RchargeStockList> {
  String filter = '';
  @override
  Widget build(BuildContext context) {
    return BluredContainer(
      height: 570,
      width: context.width - 20,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SearchByWidget(
              withCategory: true,
              listOfCategories: RechargeOperator.values
                  .map((e) => e.name.toUpperCase())
                  .toList(),
              onBothChanged: (category, filter) {
                setState(() {
                  this.filter = filter;
                });
              },
              onSearchTextChanged: (filterText) {
                setState(() {
                  filter = filterText;
                });
              },
            ),
          ),
          Expanded(
              child: Wrap(
                  runSpacing: 15,
                  spacing: 15,
                  children: RechargeModel.fakeData
                      .where((element) => element.oprtr.name
                          .toLowerCase()
                          .contains(filter.toLowerCase()))
                      .map((e) => SizedBox(
                            width: 200,
                            height: 100,
                            child: RechargeListItem(
                              onDelete: (rech) {},
                              onEdit: (rech) {
                                log('onEdit ${rech.toString()}');
                                MDialogs.dialogSimple(
                                  context,
                                  title: Text(
                                    'Edit Recharge',
                                    style:
                                        Theme.of(context).textTheme.headline3!,
                                  ),
                                  contentWidget: AddRechargeWidget(
                                    recharge: rech,
                                  ),
                                );
                              },
                              onTap: (RechargeModel recharge) {
                                MDialogs.dialogSimple(
                                  context,
                                  title: Text(
                                    'Sell Recharge',
                                    style:
                                        Theme.of(context).textTheme.headline3!,
                                  ),
                                  contentWidget: SellRechargeWidget(
                                    state: AddRechargeState.selling,
                                    recharge: recharge,
                                  ),
                                );
                              },
                              recharge: e,
                            ),
                          ))
                      .toList())),
        ],
      ),
    );
  }
}

class RechargeListItem extends StatelessWidget {
  final RechargeModel recharge;
  final void Function(RechargeModel) onTap;
  final void Function(RechargeModel) onDelete;
  final void Function(RechargeModel) onEdit;
  const RechargeListItem({
    Key? key,
    required this.recharge,
    required this.onTap,
    required this.onDelete,
    required this.onEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      startActionPane: ActionPane(motion: const ScrollMotion(), children: [
        SlidableAction(
          onPressed: (_) => onEdit(recharge),
          backgroundColor: Color.fromARGB(255, 73, 254, 163),
          foregroundColor: Color.fromARGB(255, 255, 255, 255),
          borderRadius: BorderRadius.circular(10),
          icon: Icons.edit,
          label: 'Edit',
        ),
      ]),
      endActionPane: ActionPane(motion: const ScrollMotion(), children: [
        SlidableAction(
          onPressed: (_) => onDelete(recharge),
          backgroundColor: Color.fromARGB(255, 255, 0, 0),
          foregroundColor: Color.fromARGB(255, 255, 255, 255),
          padding: EdgeInsets.symmetric(horizontal: 10),
          spacing: 8,
          autoClose: true,
          borderRadius: BorderRadius.circular(10),
          icon: Icons.delete,
          label: 'Delete',
        ),
      ]),
      child: InkWell(
        onTap: () => onTap(recharge),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: RechargeModel.getOprtrColor(recharge.oprtr),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      recharge.oprtr.name.toUpperCase(),
                      style: Theme.of(context).textTheme.headline3,
                    ),
                  ),
                  Container(
                    width: 43,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(0),
                        topLeft: Radius.circular(0),
                        bottomLeft: Radius.circular(10),
                      ),
                      color: Color.fromARGB(123, 255, 255, 255),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '${recharge.qntt}',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    '${recharge.amount} DH',
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  Text(
                    '${recharge.percntg}%',
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(
                          color: Color.fromARGB(123, 255, 255, 255),
                        ),
                  ),
                  Text(
                    'on : ${recharge.date.ddmmyyyy()}',
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
