import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:uitest/extensions.dart';

import 'glass_widgets.dart';

class SearchCategorySpinner extends StatefulWidget {
  const SearchCategorySpinner({
    Key? key,
    this.list,
    required this.onChanged,
    this.validator,
    this.initialItem,
  }) : super(key: key);
  final List<String>? list;
  final void Function(String) onChanged;
  final String? Function(String?)? validator;

  final String? initialItem;

  @override
  State<SearchCategorySpinner> createState() => _SearchCategorySpinnerState();
}

class _SearchCategorySpinnerState extends State<SearchCategorySpinner> {
  List<String> fruits = [];
  void initialize() {
    fruits = widget.list ?? [];
    // (widget.initialItem != null && !fruits.contains(widget.initialItem))
    (widget.initialItem != null &&
            !fruits.toLowerCase().contains(widget.initialItem!.toLowerCase()))
        ? fruits.add(widget.initialItem!)
        : null;
  }

  @override
  void initState() {
    initialize();
    super.initState();
  }

  @override
  void dispose() {
    formkey.currentState!.dispose();
    super.dispose();
  }

  /// form key for the form field
  final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 220.0,
      child: GlassContainer(
        child: DropdownButtonHideUnderline(
          child: ButtonTheme(
            alignedDropdown: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
            child: Form(
              key: formkey,
              child: DropdownButtonFormField<String>(
                  isDense: true,
                  elevation: 4,
                  dropdownColor: const Color(0xff38B2F7),
                  focusColor: const Color.fromARGB(0, 255, 255, 255),
                  iconSize: 30,
                  icon: const Icon(Icons.keyboard_arrow_down_sharp),
                  isExpanded: true,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: widget.validator,
                  hint: Text(
                    'Search by'.tr(),
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  ),
                  value: widget.initialItem, //selecrtedValue,
                  onChanged: (value) {
                    widget.onChanged(value!);
                    formkey.currentState!.validate();
                  },
                  items: fruits
                      .toSet()
                      .map((itemName) {
                        return DropdownMenuItem<String>(
                          value: itemName,
                          child: SizedBox(
                            width: 100,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 4.0, right: 4),
                              child: Text(
                                itemName,
                                textAlign: TextAlign.start,
                                style: Theme.of(context).textTheme.subtitle2!,
                              ),
                            ),
                          ),
                        );
                      })
                      .toSet()
                      .toList()),
            ),
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class SelectOrAddNewCategory extends StatefulWidget {
  SelectOrAddNewCategory({
    Key? key,
    this.labelText,
    this.hintText,
    required this.onSaved,
    required this.list,
    this.initialItem,
    this.validator,
  }) : super(key: key);
  List<String>? list;
  final void Function(String) onSaved;
  final String? hintText;
  final String? labelText;
  final String? Function(String?)? validator;

  final String? initialItem;

  @override
  State<SelectOrAddNewCategory> createState() => _SelectOrAddNewState();
}

class _SelectOrAddNewState extends State<SelectOrAddNewCategory> {
  //String? selectedItem;
  List<String> mList = [];
  void initialize() {
    mList = widget.list ?? [];
    // (widget.initialItem != null && !fruits.contains(widget.initialItem))
    mList.add('New');
    (widget.initialItem != null &&
            !mList.toLowerCase().contains(widget.initialItem!.toLowerCase()))
        ? mList.add(widget.initialItem!)
        : null;
  }

  bool isNew = false;
  @override
  void initState() {
    initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
          // border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(6)),
      child: isNew
          ? _buildTextForm()
          : DropdownButtonHideUnderline(
              child: ButtonTheme(
                alignedDropdown: true,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: DropdownButtonFormField<String>(
                    isDense: true,
                    elevation: 4,
                    dropdownColor: const Color(0xff38B2F7),
                    focusColor: const Color.fromARGB(0, 255, 255, 255),
                    iconSize: 30,
                    icon: const Icon(Icons.keyboard_arrow_down_sharp),
                    isExpanded: true,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: widget.validator,
                    hint: Text(
                      'Search by'.tr(),
                      style: Theme.of(context).textTheme.headline6!.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                    ),
                    value: widget.initialItem, //selecrtedValue,
                    onChanged: (value) {
                      widget.onSaved(value!);
                      //formkey.currentState!.validate();
                      value == 'New'
                          ? setState(() {
                              isNew = true;
                            })
                          : null;
                    },
                    items: mList
                        .toSet()
                        .map((itemName) {
                          return DropdownMenuItem<String>(
                            value: itemName,
                            child: SizedBox(
                              width: 100,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 4.0, right: 4),
                                child: Text(
                                  itemName,
                                  textAlign: TextAlign.start,
                                  style: Theme.of(context).textTheme.subtitle2!,
                                ),
                              ),
                            ),
                          );
                        })
                        .toSet()
                        .toList()),
              ),
            ),
    );
  }

  _buildTextForm() {
    return TextFormField(
      validator: widget.validator,
      onChanged: (value) {
        widget.onSaved(value);
      },
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide:
              const BorderSide(color: Color.fromARGB(137, 255, 255, 255)),
          borderRadius: BorderRadius.circular(6),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.0),
          borderSide: const BorderSide(color: Colors.white),
        ),
        hintText: widget.hintText!,
        hintStyle: Theme.of(context).textTheme.subtitle2!,
        contentPadding: const EdgeInsets.only(top: 4),
        prefixIcon: const Icon(Icons.card_travel_outlined),
        suffixIcon: IconButton(
          icon: const Icon(Icons.add_circle_outline),
          onPressed: () {
            setState(() {
              isNew = false;
            });
          },
        ),
        filled: true,
        labelText: widget.labelText!,
      ),
    );
  }
}
