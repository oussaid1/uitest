import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:uitest/extentions.dart';
import 'package:uitest/theme.dart';

class MyInventoryTable extends StatelessWidget {
  /// feilds required for this widget
  ///  [IconData iconData],String wedgetTitle,String bottomText,double bottomValue,
  ///  column1, column2,
  /// String row1Title,double row1Value1,double row1Value2,
  /// String row2Title,double row2Value1,double row2Value2,
  /// String row3Title,double row3Value1,double row3Value2]
  final Map<String, dynamic> data;

  final Widget? endWidget;

  const MyInventoryTable({
    Key? key,
    required this.data,
    this.endWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Icon(
                      data['iconData'] ?? FontAwesomeIcons.circleDot,
                      size: 18,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      data['wedgetTitle'] ?? '',
                      style: Theme.of(context).textTheme.headline3!.copyWith(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                  ],
                ),
              ),
              endWidget ?? Container(),
            ],
          ),
        ),
        Column(
          children: [
            // buildTextOnValue(context,
            //     text: 'Amount'.tr(), value: 3020, withDollarSign: false),
            // buildTextOnValue(context,
            //     text: 'Auantity'.tr(), value: 2000, withDollarSign: false),
            // buildTextOnValue(context,
            //     text: 'Total'.tr(), value: 1000, withDollarSign: false),
            buildTable(
              context,
              rows: [
                buildDataRow(
                  context,
                  cellTitle: data['row1Title'] ?? '',
                  value1: data['row1Value1'] ?? 0,
                  value2: data['row1Value2'] ?? 0,
                ),
                buildDataRow(
                  context,
                  cellTitle: data['row2Title'] ?? '',
                  value1: data['row2Value1'] ?? 0,
                  value2: data['row2Value2'] ?? 0,
                ),
                buildDataRow(
                  context,
                  cellTitle: data['row3Title'] ?? '',
                  value1: data['row3Value1'] ?? 0,
                  value2: data['row3Value2'] ?? 0,
                )
              ],
              label1: data['column1'] ?? '',
              label2: data['column2'] ?? '',
            ),
          ],
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const SizedBox(height: 15),
            Divider(
              height: 0.5,
              thickness: 0.5,
              color: Theme.of(context).colorScheme.onPrimary,
              endIndent: 8,
              indent: 8,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 8, right: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    data['bottomText'] ?? '',
                    style: Theme.of(context).textTheme.caption!.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary),
                  ),
                  PriceNumberZone(
                    right: const SizedBox.shrink(),
                    withDollarSign: false,
                    price: data['bottomValue'] ?? 0,
                    style: Theme.of(context)
                        .textTheme
                        .headline2!
                        .copyWith(color: Theme.of(context).colorScheme.primary),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class PriceNumberZone extends StatelessWidget {
  final TextAlign textAlign;
  final bool withDollarSign;
  final double price;
  final TextStyle style;
  final Widget? right;
  const PriceNumberZone({
    Key? key,
    required this.price,
    required this.style,
    required this.withDollarSign,
    this.textAlign = TextAlign.end,
    this.right,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            '${price.toPrecision()} '.tr(),
            textAlign: textAlign,
            style: style,
          ),
          withDollarSign
              ? Consumer(builder: (context, ref, _) {
                  const currency = '\$';
                  return Text(
                    currency.toString(),
                    style: Theme.of(context).textTheme.subtitle2!.copyWith(
                          fontSize: 8,
                        ),
                  );
                })
              : const SizedBox.shrink(),
          right!,
        ],
      ),
    );
  }
}

buildDataRow(BuildContext context,
    {required String cellTitle,
    required double value1,
    required double value2}) {
  return DataRow(
    cells: [
      DataCell(
        Text(
          cellTitle,
          style: Theme.of(context).textTheme.caption!.copyWith(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
        ),
      ),
      DataCell(
        PriceNumberZone(
          withDollarSign: false,
          right: const SizedBox.shrink(),
          price: value1.toPrecision(),
          style: Theme.of(context)
              .textTheme
              .headline5!
              .copyWith(color: Theme.of(context).colorScheme.onPrimary),
        ),
      ),
      DataCell(
        PriceNumberZone(
          withDollarSign: false,
          right: const SizedBox.shrink(),
          price: value2.toPrecision(),
          style: Theme.of(context)
              .textTheme
              .headline5!
              .copyWith(color: Theme.of(context).colorScheme.onPrimary),
        ),
      ),
    ],
  );
}

buildTable(BuildContext context,
    {required List<DataRow> rows,
    required String label1,
    required String label2}) {
  return DataTable(
    dataRowColor: MaterialStateProperty.all(
        const Color.fromARGB(255, 60, 228, 234).withOpacity(0.1)),
    columns: [
      DataColumn(
        label: Text(
          '',
          style: Theme.of(context).textTheme.caption!.copyWith(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
        ),
      ),
      DataColumn(
        label: Text(
          label1,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: MThemeData.productColor,
              ),
        ),
      ),
      DataColumn(
        label: Text(
          label2,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                color: MThemeData.serviceColor,
              ),
        ),
      ),
    ],
    rows: rows,
  );
}

