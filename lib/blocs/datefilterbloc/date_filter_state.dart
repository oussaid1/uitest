part of 'date_filter_bloc.dart';

class DateFilterState extends Equatable {
  final DateFilter filterType;
  final MDateRange? dateRange;
  const DateFilterState({
    required this.filterType,
    this.dateRange,
  });
  @override
  List<Object> get props => [filterType];
}
