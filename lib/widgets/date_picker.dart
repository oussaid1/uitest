import 'package:flutter/material.dart';
import 'package:uitest/extentions.dart';

// final pickedDateTime = StateProvider<DateTime>((ref) {
//   return DateTime.now();
// });

class SelectDate extends StatefulWidget {
  final String? labelText;

  const SelectDate({
    Key? key,
    this.labelText = 'Date',
    this.initialDate,
    this.firstDate,
    this.lastDate,
    this.onDateSelected,
  }) : super(key: key);
  final DateTime? initialDate;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final void Function(DateTime)? onDateSelected;

  @override
  State<SelectDate> createState() => _SelectDateState();
}

class _SelectDateState extends State<SelectDate> {
  //final DatePickerMode initialDatePickerMode;
  DateTime? _pickedDateTime = DateTime.now();
  void selectDate(BuildContext context) async {
    DateTime picked = (await showDatePicker(
      context: context,
      initialDate: widget.initialDate ?? DateTime.now(),
      firstDate: widget.firstDate ?? DateTime(2010),
      lastDate: widget.lastDate ?? DateTime(2030),
      // initialEntryMode: DatePickerEntryMode.input,
    ))!;
    if (picked != DateTime.now()) {
      widget.onDateSelected!.call(picked);
      setState(() {
        _pickedDateTime = picked;
      });
    }
  }

  @override
  void initState() {
    if (widget.initialDate != null) {
      _pickedDateTime = widget.initialDate;
      // widget.onDateChanged!.call(widget.initialDateTime!);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: TextEditingController(
        text: _pickedDateTime?.ddmmyyyy(),
      ),
      onTap: () {
        selectDate(context);
      },
      enableInteractiveSelection: true,
      readOnly: true,
      decoration: InputDecoration(
        hintText: 'Select Date',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        filled: true,
        prefixIcon: const Icon(
          Icons.calendar_today,
          size: 18,
        ),
        label: Text(widget.labelText ?? 'Date',
            style: Theme.of(context).textTheme.bodyMedium),
      ),
    );
  }
}
