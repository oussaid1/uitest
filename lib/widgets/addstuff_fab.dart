import 'package:flutter/material.dart';
import 'package:uitest/widgets/add_payment.dart';

import '../expandable_fab.dart';
import '../popups.dart';
import 'add_client.dart';
import 'add_debt.dart';
import 'add_expense.dart';
import 'add_income.dart';
import 'add_product.dart';
import 'add_service.dart';

class ExpandableFb extends StatelessWidget {
  const ExpandableFb({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpandableFab(
      distance: 0,
      children: [
        buildExpandedFab(context,
            title: "Client",
            child: AddClient(
              pContext: context,
            )),
        // const SizedBox(height: 10),

        /// commented this beacasue it's not yet implemented in the app , but it's here for future use
        /// don't forget to uncomment it when it's ready
        // buildExpandedFab(context,title: "Add Supplier",child: const AddSuplier()),
        // const SizedBox(height: 10),
        buildExpandedFab(context,
            title: "Product", child: const AddOrEditProduct()),
        // const SizedBox(height: 10),
        buildExpandedFab(context, title: "Service", child: const AddService()),
        //const SizedBox(height: 10),
        buildExpandedFab(context, title: "Add Debt", child: const AddDebt()),
        // const SizedBox(height: 10),
        buildExpandedFab(context,
            title: "Payment",
            child: const AddPayment(payingStatus: PayingStatus.adding)),
        // const SizedBox(height: 10),
        buildExpandedFab(context, title: "Expense", child: const AddExpense()),
        //  const SizedBox(height: 10),
        buildExpandedFab(context, title: "Income", child: const AddIncome()),
      ],
    );
    // ,
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
          contentWidget: SizedBox(
            // height: 400,
            width: 410,
            child: SingleChildScrollView(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                child ?? const SizedBox.shrink(),
              ],
            )),
          ),
        );
      },
      label: SizedBox(
        width: 100,
        child: Row(
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
      ),
    );
  }
}

class AddStuffWidget extends StatelessWidget {
  const AddStuffWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        buildExpandedFab(context,
            title: "Client",
            child: AddClient(
              pContext: context,
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
          contentWidget: SizedBox(
            // height: 400,
            width: 410,
            child: SingleChildScrollView(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                child ?? const SizedBox.shrink(),
              ],
            )),
          ),
        );
      },
      label: SizedBox(
        width: 100,
        child: Row(
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
      ),
    );
  }
}
