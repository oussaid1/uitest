import 'package:flutter/material.dart';

import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:uitest/extentions.dart';
import 'package:uitest/glass_widgets.dart';
import 'package:uitest/models/recharge/recharge.dart';
import 'package:uitest/screens/recharge/sell_recharge.dart';
import 'package:uitest/search_by_widget.dart';

import '../../popups.dart';

class RechargeSales extends StatelessWidget {
  const RechargeSales({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Wrap(
          runSpacing: 15,
          spacing: 15,
          children: const [
            RechargeSalesInventoryWidget(),
            RechargeSalesPieChart(),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        BluredContainer(
          // height: 270,
          width: 840,
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
                  itemCount: RechargeModel.fakeData.length,
                  itemBuilder: (context, index) {
                    return RechargeListItem(
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
                      recharge: RechargeModel.fakeData[index],
                    );
                  },
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}

class RechargeSalesPieChart extends StatelessWidget {
  const RechargeSalesPieChart({
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
                  'Recharge Share',
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
            color: RechargeModel.getOprtrColor(recharge.oprtr),
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
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(50),
                          ),
                          color: Color.fromARGB(123, 255, 255, 255),
                        ),
                        child: Center(
                          child: Text(
                            '23',
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
                              'on : ${recharge.date.ddmmyyyy()}',
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    // mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '20 DH',
                        style: Theme.of(context).textTheme.headline1,
                      ),
                      Text(
                        'from : laayoun',
                        style: Theme.of(context).textTheme.subtitle2,
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
