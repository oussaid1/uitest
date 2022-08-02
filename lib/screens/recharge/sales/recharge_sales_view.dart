import 'package:flutter/material.dart';

import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:uitest/extentions.dart';
import 'package:uitest/glass_widgets.dart';
import 'package:uitest/models/models.dart';
import 'package:uitest/models/recharge/recharge.dart';
import 'package:uitest/screens/recharge/sell_recharge.dart';
import 'package:uitest/search_by_widget.dart';

import '../../../models/recharge/filtered_recharges.dart';
import '../../../models/recharge/recharge_sales_data.dart';
import '../../../models/recharge/recharge_viewmodel.dart';
import '../../../popups.dart';
import 'recharge_sales_chats.dart';
import 'recharge_sales_inventory.dart';

class RechargeSalesView extends StatelessWidget {
  const RechargeSalesView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// [RechargeSalesData] is a [List<RechargeModel>]
    RecghargeViewModel recghargeViewModel = RecghargeViewModel(
      shopClients: ShopClientModel.fakeClients,
      rechargeList: RechargeModel.fakeData,
      rechargeSalesList: RechargeSaleModel.fakeData,
    );

    /// this is a list of [RechargeSalesModel] after being joined to [RechargeModel]
    List<RechargeSaleModel> fullRechargeSales =
        recghargeViewModel.combinedRechargeList;

    /// this is a list of [RechargeSalesModel] after being filtered by [DateFilter]
    FilteredRecharges filteredRecharges = FilteredRecharges(
      fullRechargeList: fullRechargeSales,
    );
    RechargeSalesData data = RechargeSalesData(
      rechargeSalesList: recghargeViewModel.combinedRechargeList,
    );
    List<RechargeSaleChartData> salesDataInwi = data.inwiChartDataDaily
      ..sort((a, b) => b.date!.compareTo(a.date!));
    List<RechargeSaleChartData> salesDataOrange = data.orangeChartDataDaily
      ..sort((a, b) => b.date!.compareTo(a.date!));
    List<RechargeSaleChartData> salesDataIam = data.iamChartDataDaily
      ..sort((a, b) => b.date!.compareTo(a.date!));
    var inwiOrangeIam = [
      data.oprtrRechargeSaleChartData('inwi', filteredRecharges.inwiList),
      data.oprtrRechargeSaleChartData('orange', filteredRecharges.orangeList),
      data.oprtrRechargeSaleChartData('iam', filteredRecharges.iamList)
    ];
    return SingleChildScrollView(
      child: Column(
        children: [
          Wrap(
            runSpacing: 15,
            spacing: 15,
            children: [
              //const RechargeSalesInventoryWidget(),
              RechargeSalesOverAllWidget(data: inwiOrangeIam),

              BluredContainer(
                height: 300,
                width: 420,
                child: RechargeSalePieChart(
                  data: inwiOrangeIam,
                  title: 'Stock',
                ),
              ),
              BluredContainer(
                height: 300,
                width: 420,
                child: RechargeSaleBarChart(
                  data: data.inwiChartDataDaily,
                  title: '',
                ),
              ),
              BluredContainer(
                height: 300,
                width: 420,
                child: RechargeSaleLineChart(
                  iamData: salesDataIam,
                  inwiData: salesDataInwi,
                  orangeData: salesDataOrange,
                  title: 'Stock',
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          const SizedBox(
            height: 20,
          ),
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: context.width * 0.5,
            ),
            child: BluredContainer(
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
                      onBothChanged: (p0, p1) {},
                      onSearchTextChanged: (p0) {},
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: recghargeViewModel.combinedRechargeList.length,
                      itemBuilder: (context, index) {
                        return RechargeSaleListItem(
                          onDelete: (rech) {},
                          onEdit: (rech) {
                            MDialogs.dialogSimple(
                              context,
                              title: Text(
                                'Edit Recharge',
                                style: Theme.of(context).textTheme.headline3!,
                              ),
                              contentWidget: SingleChildScrollView(
                                child: SellRechargeWidget(
                                  state: AddRechargeState.editing,
                                  recharge: rech,
                                ),
                              ),
                            );
                          },
                          onTap: (recharge) {
                            MDialogs.dialogSimple(
                              context,
                              title: Text(
                                '',
                                style: Theme.of(context).textTheme.headline3!,
                              ),
                              contentWidget: SingleChildScrollView(
                                child: SellRechargeWidget(
                                  state: AddRechargeState.selling,
                                  recharge: recharge,
                                ),
                              ),
                            );
                          },
                          recharge:
                              recghargeViewModel.combinedRechargeList[index],
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class RechargeSalesInventoryWidget extends StatelessWidget {
  const RechargeSalesInventoryWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BluredContainer(
      height: 270,
      width: 420,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const Icon(
                  Icons.phone_android,
                  color: Color.fromARGB(255, 254, 242, 255),
                  size: 30,
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  'Recharge Sales',
                  style: Theme.of(context).textTheme.headline3,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class RechargeSaleListItem extends StatelessWidget {
  final RechargeSaleModel recharge;
  final void Function(RechargeModel) onTap;
  final void Function(RechargeModel) onDelete;
  final void Function(RechargeModel) onEdit;
  const RechargeSaleListItem({
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
        // ActionButton(
        //   icon: const Icon(Icons.edit),
        //   onPressed: () => onEdit(recharge),
        // ),
        IconButton(
          icon: const Icon(
            Icons.edit,
          ),
          onPressed: () {
            onEdit(recharge);
          },
        ),
      ]),
      endActionPane: ActionPane(motion: const ScrollMotion(), children: [
        IconButton(
          icon: const Icon(Icons.delete_forever_outlined,
              color: Color.fromARGB(206, 244, 67, 54)),
          onPressed: () {
            onDelete(recharge);
          },
        ),
      ]),
      child: InkWell(
        onTap: () => onTap(recharge),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: RechargeModel.getOprtrColor(recharge.oprtr),
              width: 1,
            ),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        width: 37,
                        height: 37,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(50),
                          ),
                          color: Colors.white.withOpacity(0.5),
                        ),
                        child: Center(
                          child: Text(
                            '${recharge.qnttSld}',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.headline5,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              recharge.oprtr.name.toUpperCase(),
                              style: Theme.of(context).textTheme.headline3,
                            ),
                            Text(
                              'on : ${recharge.dateSld.ddmmyyyy()}',
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Column(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        // mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '${recharge.amount} DH',
                            style: Theme.of(context).textTheme.headline1,
                          ),
                          // Text(
                          //   'from : laayoun',
                          //   style: Theme.of(context).textTheme.subtitle2,
                          // ),
                        ],
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                          ),
                          color: RechargeModel.getOprtrColor(recharge.oprtr),
                          //color: Color.fromARGB(255, 254, 242, 255),
                        ),
                        width: 4,
                        height: 37,
                      ),
                    ],
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
