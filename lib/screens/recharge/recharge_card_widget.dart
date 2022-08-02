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
