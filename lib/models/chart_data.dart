import 'package:flutter/rendering.dart';
import 'package:uitest/models/recharge/recharges_data.dart';

import 'recharge/recharge.dart';

class ChartData<T> {
  String? label;
  num? value;
  List<T>? data;
  DateTime? date;
  Color? color;
  ChartData({this.label, this.value, this.date, this.color, this.data});

  /// to map
  Map<String, dynamic> toMap() {
    return {
      'label': label,
      'value': value,
      'date': date?.toIso8601String(),
      'color': color?.value,
    };
  }
}
