import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:uitest/expandable_fab.dart';
import 'package:uitest/extentions.dart';
import 'package:uitest/glass_widgets.dart';
import 'package:uitest/models/recharge/recharge.dart';
import 'package:uitest/screens/recharge/sell_recharge.dart';
import 'package:uitest/search_by_widget.dart';

import '../../popups.dart';

class RechargeTab extends StatelessWidget {
  const RechargeTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text('Recharge List'),
          bottom: const TabBar(
            physics: NeverScrollableScrollPhysics(),
            splashFactory: NoSplash.splashFactory,
            labelStyle: TextStyle(fontSize: 18),
            indicatorColor: Colors.transparent,
            labelColor: Color.fromARGB(255, 254, 242, 255),
            //unselectedLabelColor: Colors.black,
            indicatorSize: TabBarIndicatorSize.label,
            labelPadding: EdgeInsets.symmetric(horizontal: 80),
            padding: EdgeInsets.symmetric(horizontal: 8),
            //indicatorPadding: const EdgeInsets.symmetric(horizontal: 8),
            //splashBorderRadius: const BorderRadius.all(Radius.circular(6)),

            indicator: BoxDecoration(
              color: Color.fromARGB(50, 255, 255, 255),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            isScrollable: false,
            tabs: [
              Tab(
                text: 'Recharge',
              ),
              Tab(
                text: 'Recharge Sale',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Column(
              children: [
                BluredContainer(
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
                        child: GridView.builder(
                          itemCount: RechargeModel.fakeData.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 4,
                                  crossAxisSpacing: 15,
                                  mainAxisSpacing: 8,
                                  //mainAxisExtent: 100,
                                  childAspectRatio: 1.8),
                          itemBuilder: (context, index) {
                            return RechargeListItem(
                              onDelete: (rech) {},
                              onEdit: (rech) {
                                MDialogs.dialogSimple(
                                  context,
                                  title: Text(
                                    'Edit Recharge',
                                    style:
                                        Theme.of(context).textTheme.headline3!,
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
                                    style:
                                        Theme.of(context).textTheme.headline3!,
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
            ),
            const Center(
              child: Text('Recharge Sale'),
            ),
          ],
        ),
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
                        '233',
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
                    '20 DH',
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  Text(
                    'from : laayoun',
                    style: Theme.of(context).textTheme.subtitle2,
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
