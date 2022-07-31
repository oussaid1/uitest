import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uitest/extentions.dart';

import '../../models/recharge/recharge.dart';
import '../../theme.dart';
import '../../widgets/date_picker.dart';
import '../../widgets/number_incrementer.dart';

typedef OnRechargeSelected = void Function(RechargeOperator? opertr)?;

class RechargeOperatorRadioWidget extends StatefulWidget {
  final OnRechargeSelected onRechargeSelected;
  final RechargeOperator? initialValue;

  const RechargeOperatorRadioWidget({
    Key? key,
    required this.onRechargeSelected,
    this.initialValue,
  }) : super(key: key);

  @override
  State<RechargeOperatorRadioWidget> createState() =>
      _RechargeOperatorRadioWidgetState();
}

class _RechargeOperatorRadioWidgetState
    extends State<RechargeOperatorRadioWidget> {
  RechargeOperator _groupValue = RechargeOperator.orange;
  @override
  void initState() {
    if (widget.initialValue != null) {
      _groupValue = widget.initialValue!;
    }
    super.initState();
  }

  bool _isSelected(RechargeOperator opertr) => _groupValue == opertr;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildRadioOperator(
          context,
          backgroundColor: RechargeModel.inwi,
          color: _isSelected(RechargeOperator.inwi)
              ? Colors.white
              : RechargeModel.inwi,
          label: 'INWI'.tr(),
          child: Radio<RechargeOperator>(
            fillColor: MaterialStateProperty.resolveWith((states) =>
                states.contains(MaterialState.selected)
                    ? Colors.white
                    : RechargeModel.inwi),
            value: RechargeOperator.inwi,
            groupValue: _groupValue,
            onChanged: (value) {
              log('onChanged: $value');
              setState(() {
                _groupValue = value!;
                widget.onRechargeSelected?.call(value);
              });
            },
          ),
        ),
        _buildRadioOperator(
          context,
          backgroundColor: RechargeModel.orange,
          color: _isSelected(RechargeOperator.orange)
              ? Colors.white
              : RechargeModel.orange,
          label: 'ORANGE'.tr(),
          child: Radio<RechargeOperator>(
            fillColor: MaterialStateProperty.resolveWith((states) =>
                states.contains(MaterialState.selected)
                    ? Colors.white
                    : RechargeModel.orange),
            value: RechargeOperator.orange,
            groupValue: _groupValue,
            onChanged: (value) {
              log('onChanged: $value');
              setState(() {
                _groupValue = value!;
                widget.onRechargeSelected?.call(value);
              });
            },
          ),
        ),
        _buildRadioOperator(
          context,
          backgroundColor: RechargeModel.iam,
          color: _isSelected(RechargeOperator.iam)
              ? Colors.white
              : RechargeModel.iam,
          label: 'IAM'.tr(),
          child: Radio<RechargeOperator>(
            fillColor: MaterialStateProperty.resolveWith((states) =>
                states.contains(MaterialState.selected)
                    ? Colors.white
                    : RechargeModel.iam),
            value: RechargeOperator.iam,
            groupValue: _groupValue,
            onChanged: (value) {
              log('onChanged: $value');
              setState(() {
                _groupValue = value!;
                widget.onRechargeSelected?.call(value);
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _buildRadioOperator(
    BuildContext context, {
    required Color color,
    required Color backgroundColor,
    required String label,
    required Widget child,
  }) {
    return Container(
      width: 67,
      height: 67,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: color,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                  )),
          const SizedBox(height: 5),
          child,
        ],
      ),
    );
  }
}

class AddRechargeWidget extends StatefulWidget {
  final RechargeModel? recharge;
  const AddRechargeWidget({
    Key? key,
    this.recharge,
  }) : super(key: key);

  @override
  State<AddRechargeWidget> createState() => _AddRechargeStateWidget();
}

class _AddRechargeStateWidget extends State<AddRechargeWidget> {
  final GlobalKey<FormState> dformKey = GlobalKey<FormState>();
  //final TextEditingController clientController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  String suplierID = "any";
  final TextEditingController percentageController = TextEditingController();
  DateTime _date = DateTime.now();
  num quantity = 1;
  RechargeOperator? oprtr;
  bool _canSave = false;
  bool _isUpdate = false;
  @override
  void initState() {
    if (widget.recharge != null) {
      _isUpdate = true;
      _date = widget.recharge!.date;
      amountController.text = widget.recharge!.amount.toString();
      percentageController.text = widget.recharge!.percntg.toString();
      suplierID = widget.recharge!.suplyrID!;
      quantity = widget.recharge!.qntt;
      oprtr = widget.recharge!.oprtr;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            key: dformKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _buildOperator(),
                const SizedBox(height: 20),
                buildPercentage(),
                const SizedBox(height: 20),
                _buildQuantity(context),
                const SizedBox(height: 20),
                buildAmount(),
                const SizedBox(height: 20),
                buildDate(),
                const SizedBox(height: 20),
                buildSaveButton(context),
                const SizedBox(height: 40) //but
              ],
            ),
          ),
        ),
      ],
    );
  }

  buildSaveButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ElevatedButton(
            style: MThemeData.raisedButtonStyleSave,
            onPressed: !_canSave
                ? null
                : () {
                    if (dformKey.currentState!.validate()) {
                      setState(() {
                        _canSave = false;
                      });
                      final rchrge = RechargeModel(
                        id: _isUpdate ? widget.recharge!.id : null,
                        amount: double.tryParse(amountController.text)!,
                        date: _date,
                        suplyrID: suplierID,
                        percntg: double.tryParse(percentageController.text)!,
                        qntt: quantity,
                        oprtr: oprtr!,
                      );
                      log('${rchrge.toMap()}');
                      // GetIt.I<DebtBloc>().add(_isUpdate
                      //     ? UpdateDebtEvent(debt)
                      //     : AddDebtEvent(debt));
                      // // Navigator.pop(context);
                    }
                  },
            child: Text(_isUpdate ? "Update" : "Save").tr()),
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

  Widget _buildQuantity(BuildContext context) {
    return SizedBox(
      width: context.width,
      child: NumberIncrementerWidget(
        initialValue: quantity,
        onChanged: (num number) {
          setState(() {
            quantity = number;
          });
        },
      ),
    );
  }

  Widget buildDate() {
    return SelectDate(
      initialDate: _date,
      onDateSelected: (value) {
        setState(() {
          _canSave = true;
          _date = value;
        });
      },
    );
  }

  TextFormField buildPercentage() {
    return TextFormField(
      controller: percentageController,
      validator: (text) {
        if (text!.trim().isEmpty) {
          return "error".tr();
        }
        return null;
      },
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp('[0-9.]+')),
      ],
      onChanged: (value) {
        setState(() {
          _canSave = true;
        });
      },
      // style: Theme.of(context).textTheme.headline1!.copyWith(
      //       // color: Colors.black,
      //       fontWeight: FontWeight.bold,
      //     ),
      textAlign: TextAlign.center,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      maxLength: 5,
      decoration: InputDecoration(
        counterText: '',
        labelText: 'Percentage'.tr(),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.0),
          borderSide: const BorderSide(),
        ),
        hintText: '6.5 %',
        // hintStyle: Theme.of(context).textTheme.subtitle2!,
        contentPadding: const EdgeInsets.only(top: 4),
        prefixIcon: const Icon(Icons.percent),

        /// a clear button to clear the text
        suffix: percentageController.text.trim().isEmpty
            ? null
            : IconButton(
                icon: const Icon(
                  Icons.clear,
                  size: 18,
                ),
                onPressed: () {
                  setState(() {
                    percentageController.clear();
                    _canSave = false;
                  });
                },
              ),
        filled: true,
      ),
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
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp('[0-9.]+')),
      ],
      onChanged: (value) {
        setState(() {
          _canSave = true;
        });
      },
      textAlign: TextAlign.center,
      maxLength: 10,
      decoration: InputDecoration(
        counterText: '',
        labelText: 'Amount'.tr(),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.0),
          borderSide: const BorderSide(),
        ),
        hintText: '\$',
        hintStyle: Theme.of(context).textTheme.subtitle2!,
        contentPadding: const EdgeInsets.only(top: 4),
        prefixIcon: const Icon(Icons.monetization_on_outlined),
        filled: true,
      ),
    );
  }

  _buildOperator() {
    return RechargeOperatorRadioWidget(
      initialValue: oprtr,
      onRechargeSelected: (value) {
        setState(() {
          _canSave = true;
          oprtr = value;
        });
      },
    );
  }
}
