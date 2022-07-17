import 'package:flutter/material.dart';
import 'package:uitest/extentions.dart';

import '../glass_widgets.dart';

class AutocomleteTextfield extends StatelessWidget {
  final String? labelText;

  final String? hintText;
  final List<String> suggestions;
  // TextEditingController controller;

  final TextStyle? style;
  final Function(String) onSuggestionSelected;
  const AutocomleteTextfield({
    Key? key,
    required this.suggestions,

    ///required this.controller,
    this.labelText,
    this.hintText,
    this.style,
    required this.onSuggestionSelected,
  }) : super(key: key);

  @override
  Widget build(
    BuildContext context,
  ) {
    return SizedBox(
      width: context.width,
      child: Autocomplete<String>(
        optionsBuilder: (TextEditingValue textEditingValue) {
          if (textEditingValue.text == '') {
            return const Iterable<String>.empty();
          }
          return suggestions.where((String option) {
            return option
                .toString()
                .contains(textEditingValue.text.toLowerCase());
          });
        },
        fieldViewBuilder: (BuildContext context,
            TextEditingController textEditingController,
            FocusNode focusNode,
            VoidCallback onFieldSubmitted) {
          return TextFormField(
            controller: textEditingController,
            onChanged: onSuggestionSelected,
            decoration: InputDecoration(
              labelText: labelText,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6.0),
                borderSide: BorderSide(color: AppConstants.whiteOpacity),
              ),
              //border: InputBorder.none,
              suffixIcon: IconButton(
                icon: const Icon(
                  Icons.backspace_outlined,
                  size: 18,
                ),
                onPressed: () {
                  textEditingController.clear();
                },
              ),
              hintText: hintText,
              hintStyle: Theme.of(context).textTheme.subtitle2!,
              filled: true,
            ),
            focusNode: focusNode,
          );
        },
        onSelected: onSuggestionSelected,
      ),
    );
  }
}
