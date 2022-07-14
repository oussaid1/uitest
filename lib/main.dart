import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:uitest/theme.dart';
import 'data_table.dart';
import 'date_picker.dart';
import 'navbar.dart';
import 'number_incrementer.dart';
import 'spinner.dart';

void main() => runApp(const ProviderScope(child: MyApp()));

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OverlaySupport.global(
      child: MaterialApp(
          theme: MThemeData.lightThemeData,
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          home: const App()),
    );
  }
}

class App extends ConsumerWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: const BoxDecoration(
        gradient: MThemeData.gradient1,
      ),
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: const Text('Flutter Riverpod'),
            backgroundColor: Colors.transparent,
            elevation: 0,
            actions: [
              IconButton(
                icon: const Icon(Icons.settings),
                onPressed: () {
                  //var contains =
                  //  fruits.toLowerCase().contains('strawBerry'.toLowerCase());
                  // log('contains: $contains');
                },
              ),
            ],
            flexibleSpace: TabBar(
              indicatorColor: Theme.of(context).tabBarTheme.labelColor,
              isScrollable: false,
              tabs: [
                Text(
                  'Product',
                  style: Theme.of(context).textTheme.bodyText1!,
                ),
                Text(
                  'Service',
                  style: Theme.of(context).textTheme.bodyText1!,
                ),
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              HomePage(),
              MyNavBarWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
              SelectDate(
                initialDateTime: DateTime.now(),
                onDateChanged: (DateTime date) {},
              ),
              ElevatedButton(
                  onPressed: (() {
                    showDeleteConfirmationDialog(
                        context, fruits, "itemName", () {});
                  }),
                  child: const Text('Change Theme')),
              SizedBox(
                height: 44,
                width: 400,
                child: SearchCategorySpinner(
                  list: fruits,
                  onChanged: (value) {
                    log('onChanged: $value');
                  },
                  initialItem: 'Apple',
                ),
              ),
              NumberIncrementerWidget(
                fraction: 0.5,
                signed: true,
                onChanged: (value) {
                  log('onChanged: $value');
                  toast('onChanged: $value');
                },
              ),
              SizedBox(
                width: 200,
                height: 50,
                child: SelectOrAddNewDropDown(
                  hintText: 'Category',
                  initialItem: 'Plant',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please select or add a category';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    log('onSaved: $value');
                    toast('onSaved: $value');
                  },
                  list: fruits,
                ),
              ),
            ],
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
              SelectOrAddNewDropDown(
                list: items,
                onSaved: (value) {
                  toast('onChanged: $value');
                },
                initialItem: "Egg",
              ),
              SelectDate(
                initialDateTime: DateTime.now().add(const Duration(days: 10)),
                onDateChanged: (DateTime date) {},
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
