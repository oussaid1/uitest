import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:uitest/autocomplete.dart';
import 'package:uitest/extentions.dart';

import 'glass_widgets.dart';

class SearchByWidget extends StatefulWidget {
  final bool withCategory;
  final List<String> listOfCategories;
  final void Function(String)? onChanged;
  final String? initialCategoryValue;
  final void Function(String searchText) onSearchTextChanged;
  final void Function(String catg, String searchText) onBothChanged;

  //final String searchText;
  const SearchByWidget({
    Key? key,
    this.withCategory = false,
    required this.listOfCategories,
    this.onChanged,
    required this.onSearchTextChanged,
    required this.onBothChanged,

    /// required this.searchText,
    this.initialCategoryValue,
  }) : super(key: key);

  @override
  State<SearchByWidget> createState() => _SearchByWidgetState();
}

class _SearchByWidgetState extends State<SearchByWidget> {
  String searchText = '';
  String? selectedCategory;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        (widget.withCategory)
            ? SizedBox(
                width: 200,
                child: Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),

                    /// a dropdown button with a list of categories
                    child: DropdownButtonFormField<String>(
                      borderRadius: BorderRadius.circular(10),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        labelText: 'category',
                      ),
                      dropdownColor: Colors.white.withOpacity(0.8),
                      value: selectedCategory,
                      icon: const Icon(Icons.arrow_drop_down),
                      iconSize: 24,
                      elevation: 16,
                      style: const TextStyle(color: Colors.deepPurple),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedCategory = newValue!;
                        });
                        widget.onBothChanged.call(newValue!, searchText);
                      },
                      items: widget.listOfCategories
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ))
            : const SizedBox.shrink(),
        Expanded(
          flex: 2,
          child: SizedBox(
            width: 300,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (fillterText) {
                  widget.onSearchTextChanged(fillterText);
                  widget.onBothChanged(
                    selectedCategory!,
                    fillterText,
                  );
                },
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(color: context.theme.primary),
                decoration: InputDecoration(
                  disabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                        //    color: Colors.transparent,
                        ),
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide: const BorderSide(
                          //  color: Colors.transparent,
//color: Colors.transparent,
                          )),
                  suffixIcon: const Icon(
                    Icons.search_outlined,
                    size: 18,
                  ),
                  hintText: 'Search'.tr(),
                  contentPadding:
                      const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(
                        //      color: Colors.transparent,
                        ),
                  ),
                  filled: true,
                  fillColor: AppConstants.whiteOpacity,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// class SearchCategorySpinnner extends StatefulWidget {
//   const SearchCategorySpinner({
//     Key? key,
//     this.list,
//     required this.onChanged,
//     this.validator,
//     this.initialItem,
//   }) : super(key: key);
//   final List<String>? list;
//   final void Function(String) onChanged;
//   final String? Function(String?)? validator;

//   final String? initialItem;

//   @override
//   State<SearchCategorySpinner> createState() => _SearchCategorySpinnerState();
// }

// class _SearchCategorySpinnerState extends State<SearchCategorySpinner> {
//   late List<String> fruits;
//   void initialize() {
//     fruits = widget.list ?? [];
//     // (widget.initialItem != null && !fruits.contains(widget.initialItem))
//     // (widget.initialItem != null &&
//     //         !fruits.toLowerCase().contains(widget.initialItem!.toLowerCase()))
//     //     ? fruits.add(widget.initialItem!)
//     //     : null;
//   }

//   @override
//   void initState() {
//     initialize();
//     super.initState();
//   }

//   @override
//   void dispose() {
//     formkey.currentState!.dispose();
//     super.dispose();
//   }

//   /// form key for the form field
//   final formkey = GlobalKey<FormState>();
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: 220.0,
//       child: Container(
//         child: DropdownButtonHideUnderline(
//           child: ButtonTheme(
//             alignedDropdown: true,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(6),
//             ),
//             child: Form(
//               key: formkey,
//               child: DropdownButtonFormField<String>(
//                   isDense: true,
//                   elevation: 4,
//                   dropdownColor: const Color(0xff38B2F7),
//                   focusColor: const Color.fromARGB(0, 255, 255, 255),
//                   iconSize: 30,
//                   icon: const Icon(Icons.keyboard_arrow_down_sharp),
//                   isExpanded: true,
//                   autovalidateMode: AutovalidateMode.onUserInteraction,
//                   validator: widget.validator,
//                   hint: Text(
//                     'Search by'.tr(),
//                     style: Theme.of(context).textTheme.headline6!.copyWith(
//                           color: context.theme.primary,
//                         ),
//                   ),
//                   value: widget.initialItem, //selecrtedValue,
//                   onChanged: (value) {
//                     widget.onChanged(value!);
//                     formkey.currentState!.validate();
//                   },
//                   items: fruits
//                       .toSet()
//                       .map((itemName) {
//                         return DropdownMenuItem<String>(
//                           value: itemName,
//                           child: SizedBox(
//                             width: 100,
//                             child: Padding(
//                               padding:
//                                   const EdgeInsets.only(left: 4.0, right: 4),
//                               child: Text(
//                                 itemName,
//                                 textAlign: TextAlign.start,
//                                 style: Theme.of(context).textTheme.subtitle2!,
//                               ),
//                             ),
//                           ),
//                         );
//                       })
//                       .toSet()
//                       .toList()),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
