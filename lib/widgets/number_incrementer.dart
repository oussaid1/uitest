import 'package:flutter/material.dart';

class NumberIncrementerWidget extends StatefulWidget {
  final num fraction;
  final bool signed;

  const NumberIncrementerWidget({
    Key? key,
    required this.onChanged,
    this.fraction = 1,
    this.signed = false,
  }) : super(key: key);
  final void Function(num) onChanged;

  @override
  State<NumberIncrementerWidget> createState() =>
      _NumberIncrementerWidgetState();
}

class _NumberIncrementerWidgetState extends State<NumberIncrementerWidget> {
  num number = 1;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 41,
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).bottomAppBarColor),
          borderRadius: BorderRadius.circular(6)),
      width: 140,
      child: Row(
        children: [
          IconButton(
              icon: const Icon(
                Icons.arrow_drop_down,
                size: 30,
                color: Colors.white,
              ),
              onPressed: () {
                if (widget.signed) {
                  setState(() {
                    number -= widget.fraction;
                    widget.onChanged(number);
                  });
                } else if (number > 0) {
                  setState(() {
                    number -= widget.fraction;
                    widget.onChanged(number);
                  });
                }
              }),
          Expanded(
              child: Text(
            number.toString(),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline3,
          )),
          IconButton(
              icon: const Icon(Icons.arrow_drop_up),
              color: Colors.white,
              iconSize: 30,
              onPressed: () {
                setState(() {
                  number += widget.fraction;
                });
                widget.onChanged(number);
              }),
        ],
      ),
    );
  }
}
