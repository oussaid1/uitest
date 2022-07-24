import 'package:flutter/material.dart';

class DropDownButton extends StatelessWidget {
  const DropDownButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        width: 120,
        height: 32,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: const Color.fromARGB(61, 255, 255, 255),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            isExpanded: true,
            isDense: true,
            alignment: Alignment.center,
            borderRadius: BorderRadius.circular(8),
            value: 'Stock',
            icon: const Icon(Icons.arrow_drop_down),
            iconSize: 24,
            elevation: 16,
            style: const TextStyle(color: Colors.deepPurple),
            underline: Container(
              height: 2,
              color: const Color.fromARGB(255, 77, 175, 255),
            ),
            onChanged: (String? newValue) {},
            items: <String>['Stock', 'Sales']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    value,
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
