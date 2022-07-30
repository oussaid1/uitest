import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:uitest/extentions.dart';
import 'package:uitest/glass_widgets.dart';
import '../stats_widget.dart';

class SalesOverAllWidget extends StatelessWidget {
  const SalesOverAllWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  FontAwesomeIcons.coins,
                ),
                const SizedBox(width: 15),
                Text('Sales',
                    style: Theme.of(context).textTheme.headline3!.copyWith(
                          fontWeight: FontWeight.bold,
                        )),
              ],
            ),
          ),
          Column(
            children: [
              const SalesDataTableInvent(),
              const SizedBox(height: 10),
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
                      'Net Sales',
                      style: context.textTheme.headline3!
                          .copyWith(fontWeight: FontWeight.w200),
                      //.copyWith(color: context.theme.onSecondaryContainer),
                    ),
                    PriceNumberZone(
                      right: const SizedBox.shrink(),
                      withDollarSign: true,
                      price: 247328.0,
                      priceStyle: context.textTheme.headline1!.copyWith(),
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

class MyWidget extends StatelessWidget {
  const MyWidget({Key? key}) : super(key: key);

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
                      fontWeight: FontWeight.normal,
                      color: context.theme.onSecondaryContainer)),
            ),
            PriceNumberZone(
              withDollarSign: withDollarsign,
              right: const SizedBox.shrink(),
              price: value,
              priceStyle: Theme.of(context).textTheme.caption!.copyWith(
                    color: Colors.white,
                  ),
              // style: Theme.of(context)
              //     .textTheme
              //     .headline5!
              //     .copyWith(color: context.theme.onPrimary),
            ),
          ],
        );
    return Column(
      children: [
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Products',
                  style: Theme.of(context).textTheme.caption!.copyWith(
                      //color: context.theme.onSecondaryContainer
                      )),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                buildOneItem(
                  label: 'Amount',
                  value: 98740.0,
                  withDollarsign: true,
                ),
                const SizedBox(width: 21),
                buildOneItem(
                  label: 'Items',
                  value: 98740.0,
                  withDollarsign: false,
                ),
                const SizedBox(width: 21),
                buildOneItem(
                  label: 'Quantity',
                  value: 740,
                  withDollarsign: false,
                ),
              ],
            ),
            const SizedBox(width: 8),
          ],
        ),
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Services',
                  style: Theme.of(context).textTheme.caption!.copyWith(
                      //color: context.theme.onSecondaryContainer,
                      )),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                buildOneItem(
                  label: 'Amount',
                  value: 98740.0,
                  withDollarsign: true,
                ),
                const SizedBox(width: 21),
                buildOneItem(
                  label: 'Items',
                  value: 98740.0,
                  withDollarsign: false,
                ),
                const SizedBox(width: 21),
                buildOneItem(
                  label: 'Quantity',
                  value: 740,
                  withDollarsign: false,
                ),
              ],
            ),
            const SizedBox(width: 8),
          ],
        ),
      ],
    );
  }
}

class SalesDataTableInvent extends StatelessWidget {
  const SalesDataTableInvent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _buildDataRow(BuildContext context, Color rowColor,
        {required String cellTitle,
        required num value1,
        required num value2,
        required num value3,
        TextStyle? cellStyle,
        bool withDollarSign = false}) {
      return DataRow(
        cells: [
          DataCell(
            Text(
              cellTitle,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  //color: context.theme.onSecondaryContainer,
                  ),
            ),
          ),
          DataCell(
            PriceNumberZone(
              withDollarSign: withDollarSign,
              right: const SizedBox.shrink(),
              price: value1,
              priceStyle: cellStyle ??
                  Theme.of(context).textTheme.caption!.copyWith(
                        color: AppConstants.whiteOpacity,
                      ),
              // style: Theme.of(context)
              //     .textTheme
              //     .headline5!
              //     .copyWith(color: context.theme.onPrimary),
            ),
          ),
          DataCell(
            PriceNumberZone(
              withDollarSign: withDollarSign,
              right: const SizedBox.shrink(),
              price: value2,
              priceStyle: cellStyle ??
                  Theme.of(context).textTheme.caption!.copyWith(
                        color: AppConstants.whiteOpacity,
                      ),
              // style: Theme.of(context)
              //     .textTheme
              //     .headline5!
              //     .copyWith(color: context.theme.onPrimary),
            ),
          ),
          DataCell(
            PriceNumberZone(
              withDollarSign: withDollarSign,
              right: const SizedBox.shrink(),
              price: value3,
              priceStyle: cellStyle ??
                  Theme.of(context).textTheme.caption!.copyWith(
                        color: AppConstants.whiteOpacity,
                      ),
              // style: Theme.of(context)
              //     .textTheme
              //     .headline5!
              //     .copyWith(color: context.theme.onPrimary),
            ),
          ),
        ],
      );
    }

    return DataTable(
      columnSpacing: 30,
      dataRowHeight: 32,
      showBottomBorder: false,
      dividerThickness: 0.01,
      headingRowHeight: 30,
      columns: [
        const DataColumn(
          label: Text(
            '',
          ),
        ),
        DataColumn(
          label: Text(
            "Amount",
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  fontWeight: FontWeight.bold,
                  //color: MThemeData.productColor,
                ),
          ),
        ),
        DataColumn(
          label: Text(
            'Items',
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  fontWeight: FontWeight.bold,
                  // color: context.theme.onSecondaryContainer,
                ),
          ),
        ),
        DataColumn(
          label: Text(
            'Quantity',
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  fontWeight: FontWeight.bold,
                  // color: context.theme.onSecondaryContainer,
                ),
          ),
        ),
      ],
      rows: [
        _buildDataRow(
          context,
          AppConstants.whiteOpacity,
          cellTitle: 'Products',
          value1: 4870,
          value2: 3665,
          value3: 3665,
          withDollarSign: true,
          cellStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.bold,
                color: AppConstants.whiteOpacity,
              ),
        ),
        _buildDataRow(
          context,
          AppConstants.whiteOpacity,
          cellTitle: 'Services',
          value1: 324,
          value2: 222,
          value3: 222,
          cellStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.bold,
                color: AppConstants.whiteOpacity,
              ),
        ),
      ],
    );
  }
}
