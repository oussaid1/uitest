import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uitest/extentions.dart';

class NumberIncrementerWidget extends StatefulWidget {
  final num fraction;
  final bool signed;
  final num? initialValue;
  final void Function(num) onChanged;
  final num? limitUp;
  final num? limitDown;
  final String? labelText;

  const NumberIncrementerWidget({
    Key? key,
    required this.onChanged,
    this.labelText = 'Number',
    this.initialValue,
    this.fraction = 1,
    this.signed = false,
    this.limitUp,
    this.limitDown = 1,
  }) : super(key: key);

  @override
  State<NumberIncrementerWidget> createState() =>
      _NumberIncrementerWidgetState();
}

class _NumberIncrementerWidgetState extends State<NumberIncrementerWidget> {
  late num number;
  @override
  void initState() {
    if (widget.initialValue != null) {
      setState(() {
        number = widget.initialValue!;
      });
    } else {
      number = 1;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      readOnly: true,
      inputFormatters: [
        /// numbers opnly
        FilteringTextInputFormatter.allow(RegExp('[0-9.]+')),
      ],
      controller: TextEditingController(text: number.toString()),
      keyboardType: TextInputType.number,
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.headline3,
      decoration: InputDecoration(
        prefixIcon: IconButton(
            icon: Icon(
              Icons.remove_circle_outline_outlined,
              color: context.theme.primaryContainer,
            ),
            onPressed: () {
              if (widget.signed) {
                setState(() {
                  number -= widget.fraction;
                  widget.onChanged(number);
                });
              } else if (number > widget.limitDown!) {
                setState(() {
                  number -= widget.fraction;
                  widget.onChanged(number);
                });
              }
            }),
        suffixIcon: IconButton(
            icon: const Icon(Icons.add_circle_outline_outlined),
            color: context.theme.primaryContainer,
            onPressed: () {
              if (widget.limitUp != null) {
                setState(() {
                  while (number < widget.limitUp!) {
                    number += widget.fraction;
                    widget.onChanged(number);
                  }
                });
              } else {
                setState(() {
                  number += widget.fraction;
                });
                widget.onChanged(number);
              }
            }),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        filled: true,
        hintText: '0',
        label: Text(widget.labelText ?? 'Number',
            style: Theme.of(context).textTheme.bodyMedium),
      ),
    );
  }
}
