import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import '../data_table.dart';
import '../glass_widgets.dart';
import '../spinner.dart';
import '../widgets/date_picker.dart';
import '../widgets/rangefilter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = TextEditingController();
  List<String> fruits = [
    'Apple',
    'Banana',
    'Orange',
    'Grape',
    'Pineapple',
    'Strawberry'
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: BluredContainer(
            height: 50,
            child: Row(
              children: const [RangeFilterSpinner(), DateRangePicker()],
            ),
          ),
        ),
        const Expanded(child: MyDataTableDemo()),
      ],
    );
  }

  buildPopUp() {
    return PopupMenuButton(
      itemBuilder: (context) => [
        const PopupMenuItem(
          value: ThemeMode.light,
          child: Text('Light Theme'),
        ),
        const PopupMenuItem(
          value: ThemeMode.dark,
          child: Text('Dark Theme'),
        ),
      ],
      onSelected: (ThemeMode mode) {
        //ref.read(themeModeProvider).state = mode;
      },
    );
  }

  /// build a dialog to confirm the deletion of the selected item
  static void showDeleteConfirmationDialog(
    BuildContext context,
    List<String> items,
    String itemName,
    void Function() onDelete,
  ) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Delete $itemName?'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Are you sure you want to delete $itemName?'),
              SelectDate(
                firstDate: DateTime.now().add(const Duration(days: 10)),
                onDateSelected: (DateTime date) {},
              ),
            ],
          ),
          actionsAlignment: MainAxisAlignment.spaceBetween,
          actions: [
            ElevatedButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: const Text('Delete'),
              onPressed: () {
                Navigator.of(context).pop();
                onDelete();
              },
            ),
          ],
        );
      },
    );
  }
}
