import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:uitest/extentions.dart';

import 'models.dart';

class TaggedSales {
  String tag;
  Color? mColor;
  List<SaleModel> sales;
  get count {
    return sales.length;
  }

  TaggedSales({
    required this.tag,
    required this.sales,
  });
  // get tad and check if has day month year and parse it to Datetime
  // if not return null
  DateTime? get date {
    List<String> date = tag.split('-');
    if (date.length == 3) {
      return DateTime.parse(tag);
    } else if (date.length == 2) {
      return DateTime.parse('${date[0]}-${date[1]}-01');
    } else if (date.length == 1) {
      return DateTime.parse('${date[0]}-01-01');
    }
    return null;
  }

  DateTime get tagDate {
    var date = DateTime.parse(tag);
    date.formatted();
    return date;
  }

  // ChartData get chartData {
  //   return ChartData(
  //     title: tag,
  //     value: sales.map((sale) => sale.totalPriceSoldFor).reduce((a, b) => a + b),
  //     date: date,
  //     color: mColor,
  //   );

  // }

  String get tagString {
    var today = DateTime.now();
    var yesterday = DateTime.now().subtract(const Duration(days: 1));
    if (tagDate == today) {
      return 'Today'.tr();
    } else if (tagDate == yesterday) {
      return 'Yesterday'.tr();
    }

    return tag;
  }

  SalesData get salesData {
    return SalesData(sales: sales);
  }

  FilteredSales? get filteredSalesData {
    return FilteredSales(sales: sales);
  }

  Map<String, dynamic> toMap() {
    return {
      'tag': tag,
      'length': sales.length.toString(),
      'tagDate': tagDate,
      'tagString': tagString,
      'mColor': mColor,
      'value': salesData.totalSoldAmount.toString(),
      'totalSoldAmount': salesData.totalSoldAmount.toString(),
      'totalQuantitySold': salesData.totalQuantitySold.toString(),
    };
  }

  @override
  String toString() {
    return tag;
  }
}
