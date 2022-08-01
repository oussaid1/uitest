import 'package:flutter/material.dart';
import 'package:uitest/models/recharge/recharge.dart';
import 'package:uitest/widgets/add_payment.dart';

import '../popups.dart';
import '../screens/recharge/add_recharge.dart';
import '../screens/recharge/recharge.dart';
import '../screens/recharge/sell_recharge.dart';
import 'add_client.dart';
import 'add_debt.dart';
import 'add_expense.dart';
import 'add_income.dart';
import 'add_product.dart';
import 'add_service.dart';

class AddStuffWidget extends StatelessWidget {
  const AddStuffWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        buildExpandedFab(context, title: "Client", child: const AddClient()),
        const SizedBox(height: 10),
        buildExpandedFab(context,
            title: "Recharge",
            child: const AddRechargeWidget(
                // recharge: RechargeModel.fakeData[1],
                )),
        const SizedBox(height: 10),
        buildExpandedFab(context,
            title: "Sell Recharge",
            child: SellRechargeWidget(
              recharge: RechargeModel.fakeData[1],
              state: AddRechargeState.selling,
            )),
        const SizedBox(height: 10),

        /// commented this beacasue it's not yet implemented in the app , but it's here for future use
        /// don't forget to uncomment it when it's ready
        // buildExpandedFab(context,title: "Add Supplier",child: const AddSuplier()),
        // const SizedBox(height: 10),
        buildExpandedFab(context,
            title: "Product", child: const AddOrEditProduct()),
        const SizedBox(height: 10),
        buildExpandedFab(context, title: "Service", child: const AddService()),
        const SizedBox(height: 10),
        buildExpandedFab(context, title: "Add Debt", child: const AddDebt()),
        const SizedBox(height: 10),
        buildExpandedFab(context,
            title: "Payment",
            child: const AddPayment(payingStatus: PayingStatus.adding)),
        const SizedBox(height: 10),
        buildExpandedFab(context, title: "Expense", child: const AddExpense()),
        const SizedBox(height: 10),
        buildExpandedFab(context, title: "Income", child: const AddIncome()),
      ],
    );
  }

  FloatingActionButton buildExpandedFab(BuildContext context,
      {String? title, Widget? child}) {
    return FloatingActionButton.extended(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
      extendedIconLabelSpacing: 0,
      onPressed: () {
        MDialogs.dialogSimple(
          context,
          title: Text(
            title ?? '',
            style: Theme.of(context).textTheme.headline3!,
          ),
          contentWidget: SingleChildScrollView(
              child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              child ?? const SizedBox.shrink(),
            ],
          )),
        );
      },
      label: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.add, size: 18),
          const SizedBox(width: 5),
          Text(title ?? '',
              style: Theme.of(context).textTheme.headline3!.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  )),
        ],
      ),
    );
  }
}
