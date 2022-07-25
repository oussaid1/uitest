import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:uitest/extentions.dart';

import '../blocs/bloc/date_filter_bloc.dart';
import '../glass_widgets.dart';
import '../models/daterange.dart';
import '../models/enums/date_filter.dart';
import '../theme.dart';

class RangeFilterSpinner extends StatelessWidget {
  const RangeFilterSpinner({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        // margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: AppConstants.whiteOpacity,
        ),
        width: 120.0,
        //height: 40,
        child: buildFilterSelectMenu(context));
  }

  /// build popup menu
  Widget buildFilterSelectMenu(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<DateFilter>(
        alignment: Alignment.center,
        value: context.watch<DateFilterBloc>().state.filterType,
        onChanged: (value) {
          switch (value) {
            case DateFilter.all:
              context
                  .read<DateFilterBloc>()
                  .add(const UpdateFilterEvent(filterType: DateFilter.all));
              break;
            case DateFilter.custom:
              showDialog<void>(
                context: context,
                builder: (BuildContext bcontext) {
                  return AlertDialog(
                    title: const Text('Date Range Picker'),
                    content: SizedBox(
                      height: 300,
                      width: 400,
                      child: Material(
                        child: Scaffold(
                          body: SfDateRangePicker(
                              backgroundColor:
                                  Theme.of(context).backgroundColor,
                              showTodayButton: true,
                              rangeSelectionColor:
                                  MThemeData.accentColor.withOpacity(0.5),
                              initialSelectedDate: DateTime.now(),
                              initialDisplayDate: DateTime.now(),
                              todayHighlightColor: MThemeData.revenuColor,
                              selectionColor: MThemeData.accentColor,
                              selectionShape:
                                  DateRangePickerSelectionShape.rectangle,
                              selectionMode: DateRangePickerSelectionMode.range,
                              showActionButtons: true,
                              onCancel: () {
                                Navigator.pop(context);
                              },
                              onSubmit: (Object? range) {
                                var dateRange = range as PickerDateRange;

                                context
                                    .read<DateFilterBloc>()
                                    .add(UpdateFilterEvent(
                                      filterType: DateFilter.custom,
                                      dateRange: MDateRange(
                                        start: dateRange.startDate!,
                                        end: dateRange.endDate!,
                                      ),
                                    ));
                                Navigator.pop(context);
                              }),
                        ),
                      ),
                    ),
                  );
                },
              );
              break;

            case DateFilter.month:
              context
                  .read<DateFilterBloc>()
                  .add(const UpdateFilterEvent(filterType: DateFilter.month));
              break;
            default:
              context
                  .read<DateFilterBloc>()
                  .add(const UpdateFilterEvent(filterType: DateFilter.all));
          }
        },
        items: DateFilter.values.map((DateFilter value) {
          return DropdownMenuItem<DateFilter>(
              value: value,
              child: Text(
                value.name.tr(),
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.subtitle1!,
              ));
        }).toList(),
      ),
    );
  }
}

class DateRangePicker extends StatelessWidget {
  const DateRangePicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DateFilterBloc, DateFilterState>(
      // buildWhen: (previous, current) =>
      //     previous.dateRange != current.dateRange && current.dateRange != null,
      builder: (context, state) {
        if (state.filterType == DateFilter.custom && state.dateRange != null) {
          log('custom date range is ${state.dateRange}');
          return MaterialButton(
            child: Wrap(
              direction: Axis.horizontal,
              children: [
                Text(
                  (state.dateRange ?? MDateRange.empty).start.ddmmyyyy(),
                ),
                Text(
                  '-',
                ),
                Text((state.dateRange ?? MDateRange.empty).end.ddmmyyyy()),
              ],
            ),
            onPressed: () {},
          );
        }

        return Container();
      },
    );
  }
}
