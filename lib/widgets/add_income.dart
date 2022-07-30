import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import '../models/income/income.dart';
import '../theme.dart';
import 'date_picker.dart';

class AddIncome extends StatefulWidget {
  const AddIncome({Key? key, this.income}) : super(key: key);
  final IncomeModel? income;
  @override
  State<AddIncome> createState() => AddIncomeState();
}

class AddIncomeState extends State<AddIncome> {
  final GlobalKey<FormState> incomeformKey = GlobalKey<FormState>();
  final TextEditingController expenseNameController = TextEditingController();
  final TextEditingController sourceNameController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  DateTime date = DateTime.now();
  bool canSave = false, isUpdate = false;
  void clear() {
    expenseNameController.clear();
    sourceNameController.clear();
    amountController.clear();
  }

  @override
  void initState() {
    super.initState();
    if (widget.income != null) {
      isUpdate = true;
      expenseNameController.text = widget.income!.name;
      sourceNameController.text = widget.income!.source;
      amountController.text = widget.income!.amount.toString();
      date = widget.income!.date;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: incomeformKey,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
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
            const SizedBox(height: 40),
            buildSaveButton(context),
          ],
        ),
      ),
    );
  }

  Row buildSaveButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ElevatedButton(
            style: MThemeData.raisedButtonStyleSave,
            onPressed: !canSave
                ? null
                : () {
                    if (incomeformKey.currentState!.validate()) {
                      setState(() {
                        canSave = false;
                      });
                      canSave = false;
                      final IncomeModel income = IncomeModel(
                        id: isUpdate ? widget.income!.id : null,
                        source: sourceNameController.text.trim(),
                        date: date,
                        name: expenseNameController.text.trim(),
                        amount: double.parse(amountController.text.trim()),
                      );
                      log(income.toString());
                      //GetIt.I<IncomeBloc>().add(widget.income != null? UpdateIncomeEvent(income): AddIncomeEvent(income));
                      //Navigator.pop(context);
                      setState(() {
                        canSave = true;
                      });
                    }
                  },
            child: Text(
              isUpdate ? 'edit'.tr() : 'add'.tr(),
            )),
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
      controller: sourceNameController,
      validator: (text) {
        if (text!.trim().isEmpty) {
          return "error".tr();
        }
        return null;
      },
      textAlign: TextAlign.center,
      maxLength: 20,
      decoration: InputDecoration(
        counterText: '',
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
    return SelectDate(
      onDateSelected: (DateTime pickedDate) {
        setState(() {
          date = pickedDate;
        });
      },
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
      maxLength: 10,
      decoration: InputDecoration(
        counterText: '',
        labelText: 'Amount'.tr(),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.0),
          borderSide: const BorderSide(),
        ),
        hintText: '\$1434',
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
      onChanged: (text) {
        setState(() {
          if (text.trim().isNotEmpty &&
              expenseNameController.text.trim().isNotEmpty) {
            canSave = true;
          }
        });
      },
      textAlign: TextAlign.center,
      maxLength: 20,
      decoration: InputDecoration(
        counterText: '',
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
