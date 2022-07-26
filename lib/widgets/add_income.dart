import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/income/income.dart';
import '../theme.dart';
import 'date_picker.dart';

class AddIncome extends ConsumerStatefulWidget {
  const AddIncome({Key? key, this.income}) : super(key: key);
  final IncomeModel? income;
  @override
  ConsumerState<AddIncome> createState() => AddIncomeState();
}

class AddIncomeState extends ConsumerState<AddIncome> {
  final GlobalKey<FormState> expenseformKey = GlobalKey<FormState>();
  final TextEditingController expenseNameController = TextEditingController();
  final TextEditingController sourceController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  DateTime date = DateTime.now();

  void clear() {
    expenseNameController.clear();
    sourceController.clear();
    amountController.clear();
  }

  @override
  void initState() {
    super.initState();
    if (widget.income != null) {
      expenseNameController.text = widget.income!.name;
      sourceController.text = widget.income!.source;
      amountController.text = widget.income!.amount.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: expenseformKey,
        child: Column(
          children: [
            const SizedBox(height: 20),
            buildProductName(),
            const SizedBox(height: 20),
            buildAmount(),
            const SizedBox(height: 20),
            buildDate(),
            const SizedBox(height: 20),
            buildSourceName(),
            const SizedBox(height: 20),
            buildSaveButton(ref, context),
          ],
        ),
      ),
    );
  }

  Row buildSaveButton(WidgetRef ref, BuildContext context) {
    return widget.income != null
        ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                  style: MThemeData.raisedButtonStyleSave,
                  child: Text(
                    'Update'.tr(),
                  ),
                  onPressed: () {
                    // var selectedShopClient = ref.watch(selectedShopClient);
                    // final IncomeModel income = IncomeModel(
                    //   id: widget.income!.id,
                    //   source: widget.income!.source,
                    //   date: date,
                    //   name: expenseNameController.text.trim(),
                    //   amount: double.parse(amountController.text.trim()),
                    // );
                    // if (expenseformKey.currentState!.validate()) {
                    //   GetIt.I<IncomeBloc>().add(UpdateIncomeEvent(income));
                    //   Navigator.pop(context);
                    // }
                  }),
              ElevatedButton(
                style: MThemeData.raisedButtonStyleCancel,
                child: Text(
                  'Cancel'.tr(),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                  style: MThemeData.raisedButtonStyleSave,
                  child: Text(
                    'Save'.tr(),
                  ),
                  onPressed: () {
                    if (expenseformKey.currentState!.validate()) {
                      final income = IncomeModel(
                        name: expenseNameController.text.trim(),
                        amount: double.parse(amountController.text.trim()),
                        date: date,
                        source: sourceController.text.trim(),
                      );
                      // GetIt.I<IncomeBloc>().add(UpdateIncomeEvent(income));
                    }
                  }),
              ElevatedButton(
                style: MThemeData.raisedButtonStyleCancel,
                child: Text(
                  'Cancel'.tr(),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
  }

  TextFormField buildSourceName() {
    return TextFormField(
      controller: sourceController,
      validator: (text) {
        if (text!.trim().isEmpty) {
          return "error".tr();
        }
        return null;
      },
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        labelText: 'from'.tr(),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.0),
          borderSide: const BorderSide(),
        ),
        hintText: 'source of income'.tr(),
        hintStyle: Theme.of(context).textTheme.subtitle2!,
        contentPadding: const EdgeInsets.only(top: 4),
        prefixIcon: const Icon(Icons.monetization_on_outlined),
        filled: true,
      ),
    );
  }

  Widget buildDate() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 8.0,
            top: 8,
          ),
          child: Text(
            'Date'.tr(),
            style: Theme.of(context).textTheme.subtitle2!,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 4, right: 4),
          decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).bottomAppBarColor),
              borderRadius: BorderRadius.circular(6)),
          height: 50,
          width: 240,
          child: SelectDate(
            onDateSelected: (DateTime date) {
              setState(() {
                this.date = date;
              });
            },
          ),
        ),
      ],
    );
  }

  TextFormField buildAmount() {
    return TextFormField(
      controller: amountController,
      validator: (text) {
        if (text!.trim().isEmpty) {
          return "error".tr();
        }
        return null;
      },
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp('[0-9.]+')),
      ],
      textAlign: TextAlign.center,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: 'Amount'.tr(),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.0),
          borderSide: const BorderSide(),
        ),
        hintText: '1434 dh',
        hintStyle: Theme.of(context).textTheme.subtitle2!,
        contentPadding: const EdgeInsets.only(top: 4),
        prefixIcon: const Icon(Icons.monetization_on),
        filled: true,
      ),
    );
  }

  TextFormField buildProductName() {
    return TextFormField(
      controller: expenseNameController,
      validator: (text) {
        if (text!.trim().isEmpty) {
          return "error".tr();
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: 'Income-Name'.tr(),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.0),
          borderSide: const BorderSide(),
        ),
        hintText: 'income name'.tr(),
        hintStyle: Theme.of(context).textTheme.subtitle2!,
        contentPadding: const EdgeInsets.only(top: 4),
        prefixIcon: const Icon(Icons.shopping_bag_outlined),
        filled: true,
      ),
    );
  }
}
