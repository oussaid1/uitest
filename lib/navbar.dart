import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:uitest/glass_widgets.dart';
import 'package:uitest/models/product.dart';
import 'package:uitest/models/product_data.dart';

import 'stats_widget.dart';
import 'widgets/charts.dart';

class MyNavBarWidget extends StatefulWidget {
  const MyNavBarWidget({Key? key}) : super(key: key);

  @override
  MyNavBarWidgetState createState() => MyNavBarWidgetState();
}

class MyNavBarWidgetState extends State<MyNavBarWidget> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Row(
        children: <Widget>[
          LayoutBuilder(
            builder: (context, constraint) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraint.maxHeight),
                  child: IntrinsicHeight(
                    child: NavigationRail(
                      backgroundColor: Theme.of(context).colorScheme.primary,
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
          // This is the main content.
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 18),
                  //SizedBox(height: 16),
                  Row(
                    children: [
                      const BluredContainer(
                        width: 420,
                        height: 320,
                        child: MyInventoryTable(
                          endWidget: DropDownButton(),
                          data: {
                            'iconData': FontAwesomeIcons.store,
                            'wedgetTitle': 'Stock',
                            'bottomText': 'Tottal Quantity',
                            'bottomValue': 14433.43,
                            'column1': 'Products',
                            'column2': 'Services',
                            'row1Title': 'Amount',
                            'row1Value1': 533.43,
                            'row1Value2': 3533.43,
                            'row2Title': 'Quantity',
                            'row2Value1': 4533.43,
                            'row2Value2': 1833.43,
                            'row3Title': 'Total',
                            'row3Value1': 8433.43,
                            'row3Value2': 6433.43,
                          },
                        ),
                      ),
                      const SizedBox(width: 16),
                      BluredContainer(
                        width: 420,
                        height: 320,
                        child: LineChart(
                          data: ProductData(products: ProductModel.fakeData)
                              .chartDataDDMMYY,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const SizedBox(height: 16),
                      buildPieChart(),
                      const SizedBox(width: 16),
                      buildBarChart(),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  buildPieChart() {
    var productData = ProductData(products: ProductModel.fakeData);
    return BluredContainer(
      width: 420,
      height: 320,
      child: PieChart(
        data: productData.chartDataByCategory, // chartData(),
      ),
    );
  }

  buildBarChart() {
    var productData = ProductData(products: ProductModel.fakeData);
    return BluredContainer(
      width: 420,
      height: 320,
      child: BarChart(
        data: productData.chartDataDDMMYY, // chartData(),
      ),
    );
  }
}

class DropDownButton extends StatelessWidget {
  const DropDownButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        width: 120,
        height: 32,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: const Color.fromARGB(61, 255, 255, 255),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            isExpanded: true,
            isDense: true,
            alignment: Alignment.center,
            borderRadius: BorderRadius.circular(8),
            value: 'Stock',
            icon: const Icon(Icons.arrow_drop_down),
            iconSize: 24,
            elevation: 16,
            style: const TextStyle(color: Colors.deepPurple),
            underline: Container(
              height: 2,
              color: const Color.fromARGB(255, 77, 175, 255),
            ),
            onChanged: (String? newValue) {},
            items: <String>['Stock', 'Sales']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    value,
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
