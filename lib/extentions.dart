import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uitest/models/expenses/expenses.dart';

extension Neumorphism on Widget {
  addNeumorphism({
    double borderRadius = 10.0,
    Offset offset = const Offset(5, 5),
    double blurRadius = 10,
    Color topShadowColor = Colors.white60,
    Color bottomShadowColor = const Color(0x26234395),
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
        boxShadow: [
          BoxShadow(
            offset: offset,
            blurRadius: blurRadius,
            color: bottomShadowColor,
          ),
          BoxShadow(
            offset: Offset(-offset.dx, -offset.dx),
            blurRadius: blurRadius,
            color: topShadowColor,
          ),
        ],
      ),
      child: this,
    );
  }
}

/// this extension is used to provide MediaQuery.of(context).size.width and height and navigation
extension ContextExtension on BuildContext {
  double get height => MediaQuery.of(this).size.height;

  double get width => MediaQuery.of(this).size.width;

  void gotoPage(BuildContext context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }
}

extension DtExtension on DateTime {
  String formatted() {
    try {
      return DateFormat("yyyy-MM-dd").format(this);
    } catch (e) {
      return '';
    }
  }

  String formattedHH() {
    try {
      return DateFormat.yMd().add_jm().format(this);
    } catch (e) {
      return '';
    }
  }

//   String ddmmyyyy() {
//     try {
//       return DateFormat("yyyy-MM-dd").format(this);
//     } catch (e) {
//       return '';
//     }
//   }

//   String mmyyyy() {
//     try {
//       return DateFormat("yyyy-MM").format(this);
//     } catch (e) {
//       return '';
//     }
//   }

//   String yyyy() {
//     try {
//       return DateFormat("yyyy").format(this);
//     } catch (e) {
//       return '';
//     }
//   }

//   DateTime stripTime() {
//     {
//       return DateTime(year, month, day, 0, 0, 0);
//     }
//   }

//   DateTime stripTimeDay() {
//     {
//       return DateTime(year, month, 00);
//     }
//   }

//   DateTime stripTimeDayMonth() {
//     {
//       return DateTime(year, 00, 00);
//     }
//   }
// }

// extension EnumExtension on SaleType {
//   String get value => describeEnum(this);
// }

// extension EnumExtension2 on ExpenseCategory {
//   String get value => describeEnum(this);
// }

// extension EnumParser on String {
//   ExpenseCategory toExpenseCategory() {
//     return ExpenseCategory.values.firstWhere(
//         (e) =>
//             e.toString().toLowerCase() == 'ExpenseCategory.$this'.toLowerCase(),
//         orElse: () => ExpenseCategory.other); //return null if not found
//   }
// }
}

extension EnumParser2 on String {
  DateTime? get getDate {
    List<String> date = split('-');
    if (date.length == 3) {
      return DateTime.parse(this);
    } else if (date.length == 2) {
      return DateTime.parse('${date[0]}-${date[1]}-01');
    } else if (date.length == 1) {
      return DateTime.parse('${date[0]}-01-01');
    }
    return null;
  }
}

/// extension on [List<String>] to turn all items to lower case
extension LowerCaseList on List<String> {
  List<String> toLowerCase() {
    for (int i = 0; i < length; i++) {
      this[i] = this[i].toLowerCase();
    }

    return this;
  }
}

/// extension on DateTime to get a string in the format dd/mm/yyyy
extension DateTimeExt on DateTime {
  String ddmmyyyy() {
    return DateFormat("dd/MM/yy").format(this);
  }
}

/// extention on context to get the current theme
extension ThemeExt on BuildContext {
  ColorScheme get theme => Theme.of(this).colorScheme;
  TextTheme get textTheme => Theme.of(this).textTheme;
}

extension Ex on double {
  double toPrecision(int digitsAfter) =>
      double.parse(toStringAsFixed(digitsAfter));
}

/// an extension on enum to get the string values of the enum as a list of strings
// extension EnumExt on T<Enum> {
//   List<String> get list {
//  return this.values.map((e) => e.name).toList();
//   }
// }

// /// an extension on String to get the enum value of the string
// extension EnumParser on String {
//   ExpenseCategory toExpenseCategory() {
//     switch (split('.').first) {
//       case 'electricity':
//         return ExpenseCategory.electricity;
//       default:
//         return ExpenseCategory.other;
//     }
//   }
  
// }
