part of 'date_filter_bloc.dart';

abstract class DateFilterEvent extends Equatable {
  const DateFilterEvent();

  @override
  List<Object> get props => [];
}

/// add event to filter by date
class UpdateFilterEvent extends DateFilterEvent {
  final DateFilter filterType;
  final MDateRange? dateRange;

  const UpdateFilterEvent({
    required this.filterType,
    this.dateRange,
  });

  @override
  List<Object> get props => [filterType];
}
