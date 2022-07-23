import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../glass_widgets.dart';
import '../models/daterange.dart';
import 'filter_cubit.dart';

class RangeFilterSpinner extends StatelessWidget {
  const RangeFilterSpinner({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //var selectedRangeFilter = ref.watch(rangeFilterProvider.state);
    //final debtsData = ref.watch(debtsDataStateNotifierProvider.state).state;
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
    var filter = context.select((FilterCubit element) => element.state);
    return PopupMenuButton<FilterType>(
      color: AppConstants.whiteOpacity,
      icon: Row(
        children: [
          const Icon(Icons.filter_list),
          const SizedBox(width: 3),
          Text(filter.status.toString().split('.').last),
        ],
      ),
      onSelected: (value) {
        switch (value) {
          case FilterType.all:
            context.read<FilterCubit>().updateFilter(FilterType.all, null);
            break;
          case FilterType.custom:
            context.read<FilterCubit>().updateFilter(
                  FilterType.custom,
                  MDateRange(
                    start: DateTime(2020, 1, 1),
                    end: DateTime(2020, 1, 31),
                  ),
                );
            break;
          // case FilterType.today:
          //   context.read(filterCubit).setFilter(FilterType.today);
          //   break;
          // case FilterType.week:
          //   context.read(filterCubit).setFilter(FilterType.week);
          //   break;
          case FilterType.month:
            context.read<FilterCubit>().updateFilter(
                FilterType.month,
                MDateRange(
                    start: DateTime.now().subtract(Duration(days: 30)),
                    end: DateTime.now()));
            break;
          // case FilterType.year:
          //   context.read(filterCubit).setFilter(FilterType.year);
          //   break;
        }
      },
      itemBuilder: (context) => [
        PopupMenuItem<FilterType>(
          value: FilterType.all,
          child: Text(
            FilterType.all.toString().split('.').last,
            textAlign: TextAlign.start,
            style: Theme.of(context).textTheme.subtitle1!,
          ),
        ),
        PopupMenuItem<FilterType>(
          value: FilterType.month,
          child: Text(
            FilterType.month.toString().split('.').last,
            textAlign: TextAlign.start,
            style: Theme.of(context).textTheme.subtitle1!,
          ),
        ),
        PopupMenuItem<FilterType>(
          value: FilterType.custom,
          child: Text(
            FilterType.custom.toString().split('.').last,
            textAlign: TextAlign.start,
            style: Theme.of(context).textTheme.subtitle1!,
          ),
        ),
      ],
    );
  }
}

// class RangeFilterSpinner extends ConsumerWidget {
//   const RangeFilterSpinner({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     var selectedRangeFilter = ref.watch(rangeFilterProvider.state);
//     //final debtsData = ref.watch(debtsDataStateNotifierProvider.state).state;
//     return Container(
//       margin: const EdgeInsets.all(10),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(50),
//         color: AppConstants.whiteOpacity,
//       ),
//       width: 100.0,
//       height: 40,
//       child: ButtonTheme(
//         alignedDropdown: true,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(AppConstants.radius),
//         ),
//         child: DropdownButtonFormField<FilterType>(
//             borderRadius: BorderRadius.circular(AppConstants.radius),
//             dropdownColor:
//                 const Color.fromARGB(202, 255, 255, 255).withOpacity(0.6),
//             alignment: Alignment.center,
//             autofocus: true,
//             isDense: true,
//             autovalidateMode: AutovalidateMode.always,
//             decoration: const InputDecoration(
//               border: InputBorder.none,
//               contentPadding: EdgeInsets.only(bottom: 20, left: 8),
//             ),
//             elevation: 4,
//             icon: Container(), // const Icon(Icons.keyboard_arrow_down_sharp),
//             // isExpanded: true,
//             value: selectedRangeFilter.state,
//             onChanged: (value) {
//               selectedRangeFilter.state = value!;
//               if (value == FilterType.custom) {
//                 ref.read(rangeFilterIsCustomProvider.state).state = true;
//               } else {
//                 ref.read(rangeFilterIsCustomProvider.state).state = false;
//               }
//               // debtsData.filterDebts();
//             },
//             items: FilterType.values
//                 .map((itemName) {
//                   return DropdownMenuItem<FilterType>(
//                     value: itemName,
//                     child: Text(
//                       itemName.toString().split('.').last.tr(),
//                       textAlign: TextAlign.start,
//                       style: Theme.of(context).textTheme.subtitle1!,
//                     ),
//                   );
//                 })
//                 .toSet()
//                 .toList()),
//       ),
//     );
//   }
// }
