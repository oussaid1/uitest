part of 'filter_cubit.dart';

// abstract class FilterState extends Equatable {
//   const FilterState();

//   @override
//   List<Object> get props => [];
// }

// class FilterInitial extends FilterState {}

class FilterState extends Equatable {
  const FilterState(
    this.status,
    this.dateRange,
  );
  final FilterType status;
  final MDateRange? dateRange;

  /// copyWith() is used to create a new instance of the state.
  /// It is used to create a new instance of the state when the state changes.
  FilterState copyWith({
    FilterType? status,
    MDateRange? dateRange,
  }) {
    return FilterState(
      status ?? this.status,
      dateRange ?? this.dateRange,
    );
  }

  /// toJson() is used to create a new instance of the state.
  Map<String, dynamic> toJson() {
    return {
      'status': status.index,
      'dateRange': dateRange?.toJson(),
    };
  }

  /// fromJson() is used to create a new instance of the state.
  FilterState.fromJson(Map<String, dynamic> json)
      : status = json['status'] != null
            ? FilterType.values[json['status']]
            : FilterType.all,
        dateRange = json['dateRange'] != null
            ? MDateRange.fromJson(json['dateRange'])
            : null;
  @override
  List<Object> get props => [status, dateRange!];
}
