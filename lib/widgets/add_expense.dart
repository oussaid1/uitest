import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../autocomplete.dart';
import '../models/expenses/expenses.dart';
import '../theme.dart';
import 'date_picker.dart';

class AddExpense extends ConsumerStatefulWidget {
  const AddExpense({Key? key, this.expense}) : super(key: key);
  final ExpenseModel? expense;
  @override
  ConsumerState<AddExpense> createState() => AddExpenseState();
}

class AddExpenseState extends ConsumerState<AddExpense> {
  final expenseformKey = GlobalKey<FormState>();
  final TextEditingController expenseNameController = TextEditingController();
  final TextEditingController amuontPaidController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  DateTime date = DateTime.now();
  DateTime dueDate = DateTime.now();
  String expenseCategory = 'other';
  void clear() {
    expenseNameController.clear();
    amuontPaidController.clear();
    amountController.clear();
  }

  @override
  void initState() {
    if (widget.expense != null) {
      expenseNameController.text = widget.expense!.name;
      amuontPaidController.text = widget.expense!.amountPaid.toString();
      amountController.text = widget.expense!.amount.toString();
      date = widget.expense!.date;
      dueDate = widget.expense!.deadLine;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<String> categoriesList = [];
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Form(
        key: expenseformKey,
        child: Column(
          children: [
            //  const SizedBox(height: 20),
            buildCategory(context, categoriesList),
            const SizedBox(height: 20),
            buildProductName(),
            const SizedBox(height: 20),
            buildDueAmount(),
            const SizedBox(height: 20),
            buildDate(),
            const SizedBox(height: 20),
            buildPaidAmount(),
            const SizedBox(height: 20),
            buildDueDate(),
            const SizedBox(height: 40),
            buildSaveButton(ref, context),
          ],
        ),
      ),
    );
  }

  buildSaveButton(WidgetRef ref, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ElevatedButton(
            style: MThemeData.raisedButtonStyleSave,
            child: Text(
              widget.expense != null ? 'Update'.tr() : 'Add'.tr(),
            ),
            onPressed: () {
              if (expenseformKey.currentState!.validate()) {
                final ExpenseModel expense = ExpenseModel(
                  id: widget.expense == null ? null : widget.expense!.id,
                  date: date,
                  name: expenseNameController.text.trim(),
                  amount: double.parse(amountController.text.trim()),
                  amountPaid: double.parse(amuontPaidController.text.trim()),
                  deadLine: dueDate,
                  expenseCategory: expenseCategory,
                );
                log('expense: $expense');
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

  TextFormField buildPaidAmount() {
    return TextFormField(
      controller: amuontPaidController,
      validator: (text) {
        if (text!.trim().isEmpty) {
          return "error".tr();
        }
        return null;
      },
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp('[0-9.]+')),
      ],
      textAlign: TextAlign.center,
      maxLength: 10,
      decoration: InputDecoration(
        counterText: '',
        labelText: 'Amount-Paid'.tr(),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.0),
          borderSide: const BorderSide(),
        ),
        hintText: '1234 \$',
        hintStyle: Theme.of(context).textTheme.subtitle2!,
        contentPadding: const EdgeInsets.only(top: 4),
        prefixIcon: const Icon(Icons.monetization_on_outlined),
        filled: true,
      ),
    );
  }

  Widget buildDueDate() {
    return SelectDate(
      initialDate: date,
      labelText: 'Due Date'.tr(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2050),
      onDateSelected: (value) {
        dueDate = value;
      },
    );
  }

  Widget buildDate() {
    return SelectDate(
      onDateSelected: (date) {
        date = date;
      },
    );
  }

  buildDueAmount() {
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
        labelText: 'Amount-Due'.tr(),
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

  buildProductName() {
    return TextFormField(
      controller: expenseNameController,
      validator: (text) {
        if (text!.trim().isEmpty) {
          return "error".tr();
        }
        return null;
      },
      maxLength: 20,
      decoration: InputDecoration(
        counterText: '',
        labelText: 'Expense-Name'.tr(),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.0),
          borderSide: const BorderSide(),
        ),
        hintText: 'expense name',
        hintStyle: Theme.of(context).textTheme.subtitle2!,
        contentPadding: const EdgeInsets.only(top: 4),
        prefixIcon: const Icon(Icons.shopping_bag_outlined),
        filled: true,
      ),
    );
  }

  Widget buildCategory(BuildContext context, List<String> list) {
    return CategoryAutocompleteField(
      categories: ExpenseCategory.values.map((e) => e.name).toList(),
      onChanged: (category) {
        setState(() {
          expenseCategory = category;
        });
      },
    );
  }
}
