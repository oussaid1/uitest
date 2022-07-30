import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/daterange.dart';
import '../../models/enums/date_filter.dart';

part 'date_filter_event.dart';
part 'date_filter_state.dart';

class DateFilterBloc extends Bloc<DateFilterEvent, DateFilterState> {
  DateFilterBloc()
      : super(const DateFilterState(
          filterType: DateFilter.all,
          dateRange: null,
        )) {
    on<UpdateFilterEvent>((event, emit) {
      emit(DateFilterState(
        filterType: event.filterType,
        dateRange: event.dateRange,
      ));
    });
  }
}
