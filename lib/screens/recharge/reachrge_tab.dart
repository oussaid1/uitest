import 'package:flutter/material.dart';

import 'recharge_list.dart';
import 'sales_recharge.dart';

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
        body: const TabBarView(
          children: [
            RechargeStock(),
            RechargeSalesView(),
          ],
        ),
      ),
    );
  }
}
