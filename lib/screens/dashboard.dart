import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:uitest/extentions.dart';
import 'package:uitest/glass_widgets.dart';
import '../models/models.dart';
import '../models/product_data.dart';
import '../stats_widget.dart';
import '../widgets/charts.dart';
import '../widgets/sales_inventory_widget.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Wrap(
              spacing: 15,
              direction: Axis.horizontal,
              runSpacing: 15,
              children: [
                const SalesOverAllWidget(),
                const StockInventory(),
                buildRadialChart(),
              ],
            ),
            const SizedBox(height: 15),
            Wrap(
              runSpacing: 15,
              direction: Axis.horizontal,
              spacing: 15,
              children: [
                buildLineChart(),
                buildBarChart(),
                // buildBarChart(),
              ],
            ),
            const SizedBox(height: 15),
            // Container(
            //   width: 300,
            //   height: 300,
            //   decoration: BoxDecoration(
            //     gradient:const LinearGradient(
            //       transform: GradientRotation(math.pi / 180 * 105),
            //       colors: [
            //         Color.fromRGBO(255, 0, 168, 1),
            //         Color.fromARGB(255, 221, 42, 200),
            //         Color.fromRGBO(44, 169, 239, 1),
            //         Color.fromRGBO(0, 205, 250, 1),
            //         Color.fromRGBO(13, 255, 211, 1),
            //         Color.fromRGBO(13, 255, 211, 1),
            //       ],
            //     ),
            //     borderRadius: BorderRadius.circular(15),
            //   ),
            //   child: const Center(
            //     child: BluredContainer(
            //       height: 200,
            //       width: 200,
            //       child: Text(
            //         'Dashboard',
            //         style: TextStyle(
            //           fontSize: 30,
            //           fontWeight: FontWeight.bold,
            //           color: Colors.white,
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  buildPieChart() {
    var productData = ProductData(products: ProductModel.fakeData);
    return BluredContainer(
      width: 420,
      height: 320,
      child: PieChart(
        title: 'Sales by Product',
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
        title: 'Sales by Product',
        data: productData.chartDataDDMMYY, // chartData(),
      ),
    );
  }

  buildLineChart() {
    // var productData = ProductData(products: ProductModel.fakeData);
    return BluredContainer(
      width: 420,
      height: 320,
      child: LineChart(
        title: 'Sales by Product',
        data: ProductData(products: ProductModel.fakeData).chartDataDDMMYY,
      ),
    );
  }

  buildRadialChart() {
    // var productData = ProductData(products: ProductModel.fakeData);
    return const BluredContainer(
      width: 420,
      height: 200,
      child: RadialChart(
        title: 'Sales by Product',
      ),
    );
  }
}

class StockInventory extends StatelessWidget {
  const StockInventory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    buildOneItem(
            {required String label,
            required num value,
            bool withDollarsign = false}) =>
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 4.0),
              child: Text(label,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontWeight: FontWeight.bold,
                      )),
            ),
            PriceNumberZone(
              withDollarSign: withDollarsign,
              right: const SizedBox.shrink(),
              price: value,
              priceStyle: Theme.of(context).textTheme.caption!.copyWith(
                  // color: AppConstants.whiteOpacity,
                  ),
              // style: Theme.of(context)
              //     .textTheme
              //     .headline5!
              //     .copyWith(color: context.theme.onPrimary),
            ),
          ],
        );
    return BluredContainer(
      width: 420,
      height: 200,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15.0, bottom: 5, top: 15),
            child: Row(
              children: [
                const Icon(
                  FontAwesomeIcons.solidPenToSquare,
                ),
                const SizedBox(width: 15),
                Text('Stock',
                    style: Theme.of(context).textTheme.headline3!.copyWith(
                          fontWeight: FontWeight.bold,
                        )),
              ],
            ),
          ),
          Column(
            children: [
              const SizedBox(height: 21),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  buildOneItem(
                    label: 'Price In',
                    value: 98740.0,
                    withDollarsign: true,
                  ),
                  const SizedBox(width: 21),
                  buildOneItem(
                    label: 'Price Out',
                    value: 98740.0,
                    withDollarsign: true,
                  ),
                  const SizedBox(width: 21),
                  buildOneItem(
                    label: 'Quantity',
                    value: 740,
                    withDollarsign: false,
                  ),
                ],
              ),
              const SizedBox(height: 21),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Total Product Quantities",
                      style: Theme.of(context).textTheme.overline!.copyWith(
                            fontWeight: FontWeight.bold,
                            //color: context.theme.onSecondaryContainer,
                          ),
                    ),
                    PriceNumberZone(
                      withDollarSign: false,
                      right: const SizedBox.shrink(),
                      price: 239,
                      priceStyle: Theme.of(context).textTheme.caption!.copyWith(
                          // color: AppConstants.whiteOpacity,
                          ),
                      // style: Theme.of(context)
                      //     .textTheme
                      //     .headline5!
                      //     .copyWith(color: context.theme.onPrimary),
                    ),
                  ],
                ),
              ),
              Divider(
                height: 0.5,
                thickness: 0.5,
                color: context.theme.onPrimary,
                endIndent: 8,
                indent: 8,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 8, right: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Capital',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          //  color: context.theme.onSecondaryContainer,
                          ),
                    ),
                    PriceNumberZone(
                      right: const SizedBox.shrink(),
                      withDollarSign: true,
                      price: 247328.0,
                      priceStyle: context.textTheme.bodyLarge!.copyWith(
                        //fontWeight: FontWeight.w100,
                        // wordSpacing: 0.5,
                        fontSize: 18,
                        //color: Colors.white.withOpacity(0.8),
                      ),
                      // style: Theme.of(context)
                      //     .textTheme
                      //     .headline2!
                      //     .copyWith(color: context.theme.primary),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
