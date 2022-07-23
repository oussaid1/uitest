import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';

import '../autocomplete.dart';
import '../data_table.dart';
import '../spinner.dart';
import '../widgets/autocomplete_textfield.dart';
import '../widgets/date_picker.dart';
import '../widgets/number_incrementer.dart';

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
          child: Row(
            children: [
              // SizedBox(
              //   width: 200,
              //   child: SelectDate(
              //     firstDate: DateTime.now(),
              //     onDateSelected: (DateTime date) {},
              //   ),
              // ),
              // const SizedBox(width: 8),
              // IconButton(
              //     onPressed: () {
              //       _controller.clear();
              //     },
              //     icon: const Icon(Icons.textsms)),
              // ElevatedButton(
              //     onPressed: (() {
              //       showDeleteConfirmationDialog(
              //           context, fruits, "itemName", () {});
              //     }),
              //     child: const Text('Change Theme')),
              // SizedBox(
              //   height: 50,
              //   width: 300,
              //   child: Padding(
              //     padding: const EdgeInsets.all(8.0),
              //     child: AutocomleteTextfield(
              //       onSuggestionSelected: (String value) {
              //         log('onSuggestionSelected: $value');
              //       },
              //       suggestions: fruits,
              //       hintText: ' Search',
              //       labelText: 'Search',
              //     ),
              //   ),
              // ),
              const SizedBox(
                width: 200,
                height: 50,
                child: AutocompleteBasicUserExample(),
              ),
              SizedBox(
                width: 300,
                child: NumberIncrementerWidget(
                  fraction: 1,
                  signed: true,
                  onChanged: (value) {
                    log('onChanged: $value');
                    toast('onChanged: $value');
                  },
                ),
              ),
              // SizedBox(
              //   width: 200,
              //   height: 50,
              //   child: SelectOrAddNewDropDown(
              //     hintText: 'Category',
              //     initialItem: 'Plant',
              //     validator: (value) {
              //       if (value!.isEmpty) {
              //         return 'Please select or add a category';
              //       }
              //       return null;
              //     },
              //     onSaved: (value) {
              //       log('onSaved: $value');
              //       toast('onSaved: $value');
              //     },
              //     list: fruits,
              //   ),
              // ),
            ],
          ),
        ),
        // const Expanded(child: MyDataTableDemo()),
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
              SelectOrAddNewDropDown(
                list: items,
                onSaved: (value) {
                  toast('onChanged: $value');
                },
                initialItem: "Egg",
              ),
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
