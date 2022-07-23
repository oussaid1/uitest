enum DateRangeType { days, weeks, months, years, custom }

class MDateRange {
  DateRangeType? type;
  DateTime start;
  DateTime end;
  MDateRange({this.type, required this.start, required this.end});
  @override
  String toString() {
    return 'start: $start, end: $end';
  }

  /// an empty range
  static MDateRange get empty => MDateRange(
        type: null,
        start: DateTime.now(),
        end: DateTime.now(),
      );
//// custom range from 13 to 13 of every month
  static MDateRange get customRange13to13 {
    DateTime startDate = DateTime.now();
    DateTime endDate = DateTime.now().add(const Duration(days: 30));
    if (DateTime.now().day <= 13) {
      startDate = DateTime(DateTime.now().year, DateTime.now().month - 1, 13);
      endDate = DateTime(DateTime.now().year, DateTime.now().month, 13);
    } else if (DateTime.now().day >= 14) {
      startDate = DateTime(DateTime.now().year, DateTime.now().month, 13);
      endDate = DateTime(DateTime.now().year, DateTime.now().month + 1, 13);
    }
    return MDateRange(type: null, start: startDate, end: endDate);
  }

  /// toJson() is used to create a new instance of the state.
  Map<String, dynamic> toJson() {
    return {
      'type': type?.index,
      'start': start.toIso8601String(),
      'end': end.toIso8601String(),
    };
  }

  /// fromJson() is used to create a new instance of the state.
  factory MDateRange.fromJson(Map<String, dynamic> json) {
    return MDateRange(
      type: json['type'] != null ? DateRangeType.values[json['type']] : null,
      start: DateTime.parse(json['start']),
      end: DateTime.parse(json['end']),
    );
  }
}
