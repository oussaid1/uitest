import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:uitest/models/product.dart';
import 'package:uitest/theme.dart';
import 'models/product_data.dart';
import 'navbar.dart';
import 'screens/home.dart';

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
                  final productsData =
                      ProductData(products: ProductModel.fakeData);
                  log('productsData: ${productsData.pricesByCategory}');
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
