import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:uitest/autocomplete.dart';
import 'package:uitest/screens/recharge/recharge_list.dart';
import 'package:uitest/screens/splash.dart';
import 'package:uitest/theme.dart';
import 'package:uitest/widgets/addstuff_fab.dart';
import 'blocs/datefilterbloc/date_filter_bloc.dart';
import 'expandable_fab.dart';
import 'glass_widgets.dart';
import 'models/models.dart';
import 'models/product_data.dart';
import 'screens/dashboard.dart';
import 'screens/debtslist.dart';
import 'screens/home.dart';
import 'screens/recharge/reachrge_tab.dart';

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
      decoration: const BoxDecoration(
          image: DecorationImage(
            // colorFilter:
            //     ColorFilter.mode(Color.fromARGB(43, 0, 0, 0), BlendMode.darken),
            image: AssetImage(
              'assets/images/background1.jpg',
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
              length: 5,
              child: Scaffold(
                backgroundColor: Colors.transparent,
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.endDocked,
                floatingActionButton: const Padding(
                  padding: EdgeInsets.only(bottom: 80.0),
                  child: ExpandableFab(
                    distance: 0,
                    children: [
                      AddStuffWidget(),
                    ],
                  ),
                ),
                appBar: AppBar(
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
                      Tab(
                        child: Align(
                          alignment: Alignment.center,
                          child: Text("Test"),
                        ),
                      ),
                      Tab(
                        child: Align(
                          alignment: Alignment.center,
                          child: Text("Recharges"),
                        ),
                      ),
                    ],
                  ),
                ),
                body: TabBarView(
                  children: [
                    const DashboardPage(),
                    const DebtsView(),
                    BlocProvider(
                        create: (context) => DateFilterBloc(),
                        child: const HomePage()),
                    //MyNavBarWidget(),
                    const MyWidget(),
                    const RechargeTab()
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

class MyWidget extends StatelessWidget {
  const MyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const BluredContainer(
            width: 420,
            height: 200,
            child: SalesByCategoryWidget(
              taggedSales: [],
            ),
          ),
          const SizedBox(height: 20),
          BluredContainer(
            start: 0.4,
            end: 0.5,
            width: MediaQuery.of(context).size.width * 0.5,
            height: MediaQuery.of(context).size.height * 0.5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Headline1', style: Theme.of(context).textTheme.headline1),
                Text('Headline2', style: Theme.of(context).textTheme.headline2),
                Text('Headline3', style: Theme.of(context).textTheme.headline3),
                Text('Headline4', style: Theme.of(context).textTheme.headline4),
                Text('Headline5', style: Theme.of(context).textTheme.headline5),
                Text('Headline6', style: Theme.of(context).textTheme.headline6),
                Text('Subtitle1', style: Theme.of(context).textTheme.subtitle1),
                Text('Subtitle2', style: Theme.of(context).textTheme.subtitle2),
                Text('BodyLarge', style: Theme.of(context).textTheme.bodyLarge),
                Text('BodyMedium',
                    style: Theme.of(context).textTheme.bodyMedium),
                Text('BodySmall', style: Theme.of(context).textTheme.bodySmall),
                Text('Caption', style: Theme.of(context).textTheme.caption),
                Text('Button', style: Theme.of(context).textTheme.button),
                Text('Overline', style: Theme.of(context).textTheme.overline),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
