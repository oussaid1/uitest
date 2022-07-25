import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:uitest/extentions.dart';

import 'glass_widgets.dart';
import 'spinner.dart';

class SearchByWidget extends StatefulWidget {
  final bool withCategory;
  final List<String> listOfCategories;
  final void Function(String)? onChanged;
  final String? initialCategoryValue;
  final void Function(String) onSearchTextChanged;
  final void Function(String, String) onBothChanged;

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
  String selectedCategory = '';
  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      child: Row(
        children: [
          (widget.withCategory)
              ? SizedBox(
                  width: 200,
                  child: Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SearchCategorySpinner(
                        initialItem: 'Name',
                        onChanged: (value) {
                          setState(() {
                            selectedCategory = value;
                          });
                          //if (widget.onChanged != null)
                          widget.onChanged!(value);
                        },
                        list: widget.listOfCategories,
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
                      selectedCategory,
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
                        color: Colors.transparent,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: const BorderSide(
                          //  color: Colors.transparent,
                          color: Colors.transparent,
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
                        color: Colors.transparent,
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
      ),
    );
  }
}
