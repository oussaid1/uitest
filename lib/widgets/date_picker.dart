import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uitest/extensions.dart';

// final pickedDateTime = StateProvider<DateTime>((ref) {
//   return DateTime.now();
// });

class SelectDate extends StatefulWidget {
  const SelectDate({
    Key? key,
    this.initialDateTime,
    this.firstDate,
    this.lastDate,
    this.onDateChanged,
  }) : super(key: key);
  final DateTime? initialDateTime;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final void Function(DateTime)? onDateChanged;

  @override
  State<SelectDate> createState() => _SelectDateState();
}

class _SelectDateState extends State<SelectDate> {
  //final DatePickerMode initialDatePickerMode;
  DateTime? _pickedDateTime;
  void selectDate(BuildContext context) async {
    DateTime picked = (await showDatePicker(
      context: context,
      initialDate: widget.initialDateTime ?? DateTime.now(),
      firstDate: widget.firstDate ?? DateTime(2010),
      lastDate: widget.lastDate ?? DateTime(2030),
      // initialEntryMode: DatePickerEntryMode.input,
    ))!;
    if (picked != DateTime.now()) {
      widget.onDateChanged!.call(picked);
      setState(() {
        _pickedDateTime = picked;
      });
    }
  }

  @override
  void initState() {
    if (widget.initialDateTime != null) {
      _pickedDateTime = widget.initialDateTime;
      widget.onDateChanged!.call(widget.initialDateTime!);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 140,
        height: 50,
        child: GestureDetector(
          onTap: () => selectDate(context),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6.0),
              boxShadow: const [],
            ),
            child: Row(
              children: [
                const Icon(
                  CupertinoIcons.calendar,
                  color: Colors.grey,
                  size: 18,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8),
                  child: Text((_pickedDateTime)!.ddmmyyyy()),
                ),
              ],
            ),
          ),
        ));
  }
}
