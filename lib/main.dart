import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:uitest/blocs/bloc/date_filter_bloc.dart';
import 'package:uitest/screens/splash.dart';
import 'package:uitest/theme.dart';
import 'models/models.dart';
import 'models/product_data.dart';
import 'screens/dashboard.dart';
import 'screens/debtslist.dart';
import 'screens/home.dart';

void main() => runApp(const ProviderScope(child: MyApp()));

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OverlaySupport.global(
        child: MaterialApp(
      theme: MThemeData.darkThemeData,
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: const SplashPage(),
    ));
  }
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.2), BlendMode.darken),
            image: const AssetImage(
              'assets/images/background.jpg',
              // bundle: AssetBundle,/// TODO: fix this, read docs
            ),
            fit: BoxFit.cover,
          ),
          //gradient: MThemeData.gradient1,
          color: Colors.transparent),
      child: Row(
        children: <Widget>[
          LayoutBuilder(
            builder: (context, constraint) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraint.maxHeight),
                  child: IntrinsicHeight(
                    child: NavigationRail(
                      backgroundColor: Colors.white.withOpacity(0.5),
                      selectedIndex: _selectedIndex,
                      onDestinationSelected: (int index) {
                        setState(() {
                          _selectedIndex = index;
                        });
                      },
                      labelType: NavigationRailLabelType.selected,
                      destinations: const [
                        NavigationRailDestination(
                          icon: Icon(Icons.favorite_border),
                          selectedIcon: Icon(Icons.favorite),
                          label: Text('First'),
                        ),
                        NavigationRailDestination(
                          icon: Icon(Icons.bookmark_border),
                          selectedIcon: Icon(Icons.book),
                          label: Text('Second'),
                        ),
                        NavigationRailDestination(
                          icon: Icon(Icons.star_border),
                          selectedIcon: Icon(Icons.star),
                          label: Text('Third'),
                        ),
                        NavigationRailDestination(
                          icon: Icon(Icons.favorite_border),
                          selectedIcon: Icon(Icons.favorite),
                          label: Text('First'),
                        ),
                        NavigationRailDestination(
                          icon: Icon(Icons.bookmark_border),
                          selectedIcon: Icon(Icons.book),
                          label: Text('Second'),
                        ),
                        NavigationRailDestination(
                          icon: Icon(Icons.star_border),
                          selectedIcon: Icon(Icons.star),
                          label: Text('Third'),
                        ),
                        NavigationRailDestination(
                          icon: Icon(Icons.bookmark_border),
                          selectedIcon: Icon(Icons.book),
                          label: Text('Second'),
                        ),
                        NavigationRailDestination(
                          icon: Icon(Icons.star_border),
                          selectedIcon: Icon(Icons.star),
                          label: Text('Third'),
                        ),
                        NavigationRailDestination(
                          icon: Icon(Icons.favorite_border),
                          selectedIcon: Icon(Icons.favorite),
                          label: Text('First'),
                        ),
                        NavigationRailDestination(
                          icon: Icon(Icons.bookmark_border),
                          selectedIcon: Icon(Icons.book),
                          label: Text('Second'),
                        ),
                        NavigationRailDestination(
                          icon: Icon(Icons.star_border),
                          selectedIcon: Icon(Icons.star),
                          label: Text('Third'),
                        ),
                        NavigationRailDestination(
                          icon: Icon(Icons.bookmark_border),
                          selectedIcon: Icon(Icons.book),
                          label: Text('Second'),
                        ),
                        NavigationRailDestination(
                          icon: Icon(Icons.star_border),
                          selectedIcon: Icon(Icons.star),
                          label: Text('Third'),
                        ),
                        NavigationRailDestination(
                          icon: Icon(Icons.favorite_border),
                          selectedIcon: Icon(Icons.favorite),
                          label: Text('First'),
                        ),
                        NavigationRailDestination(
                          icon: Icon(Icons.bookmark_border),
                          selectedIcon: Icon(Icons.book),
                          label: Text('Second'),
                        ),
                        NavigationRailDestination(
                          icon: Icon(Icons.star_border),
                          selectedIcon: Icon(Icons.star),
                          label: Text('Third'),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          const VerticalDivider(thickness: 1, width: 1),
          const SizedBox(width: 20),
          Expanded(
            child: DefaultTabController(
              length: 3,
              child: Scaffold(
                backgroundColor: Colors.transparent,
                appBar: AppBar(
                  //title: const Text('Flutter Riverpod'),
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
                  flexibleSpace: const TabBar(
                    physics: NeverScrollableScrollPhysics(),
                    splashFactory: NoSplash.splashFactory,
                    labelStyle: TextStyle(fontSize: 18),
                    indicatorColor: Colors.transparent,
                    labelColor: Color.fromARGB(255, 254, 242, 255),
                    //unselectedLabelColor: Colors.black,
                    indicatorSize: TabBarIndicatorSize.label,
                    labelPadding: EdgeInsets.symmetric(horizontal: 80),
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    //indicatorPadding: const EdgeInsets.symmetric(horizontal: 8),
                    //splashBorderRadius: const BorderRadius.all(Radius.circular(6)),

                    indicator: BoxDecoration(
                      color: Color.fromARGB(50, 255, 255, 255),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                    ),
                    isScrollable: false,
                    tabs: [
                      Tab(
                        child: Align(
                          alignment: Alignment.center,
                          child: Text("Dashboard"),
                        ),
                      ),
                      Tab(
                        child: Align(
                          alignment: Alignment.center,
                          child: Text("Debts"),
                        ),
                      ),
                      Tab(
                        child: Align(
                          alignment: Alignment.center,
                          child: Text("Product"),
                        ),
                      ),
                      // Tab(
                      //   child: Align(
                      //     alignment: Alignment.center,
                      //     child: Text("Service"),
                      //   ),
                      // ),
                    ],
                  ),
                ),
                body: TabBarView(
                  children: [
                    const DashboardPage(),
                    const DebtsView(),
                    BlocProvider(
                      create: (context) => DateFilterBloc(),
                      child: HomePage(),
                    ),
                    //MyNavBarWidget(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Container(
//       decoration: const BoxDecoration(
//         gradient: MThemeData.gradient1,
//       ),
