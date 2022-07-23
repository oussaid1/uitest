part of 'income.dart';

class FilteredIncomes {
  List<IncomeModel> incomes;
  FilteredIncomes({required this.incomes});

  List<IncomeModel> incomesThisMonth() {
    return incomes.where((income) {
      return income.date.month == DateTime.now().month;
    }).toList();
  }

  List<IncomeModel> incomesToday() {
    return incomes.where((income) {
      return income.date.day == DateTime.now().day;
    }).toList();
  }

  incomesThisWeek() {
    return incomes.where((income) {
      return income.date.weekday == DateTime.now().weekday;
    }).toList();
  }

  List<IncomeModel> incomesByDateRange(DateTime start, DateTime end) {
    return incomes.where((income) {
      return income.date.isAfter(start) && income.date.isBefore(end);
    }).toList();
  }

  DateTime firstIncomeDate() {
    incomes.sort((a, b) => a.date.compareTo(b.date));
    return incomes.first.date;
  }

  List<IncomeModel> incomesThisYear() {
    return incomes.where((income) {
      return income.date.year == DateTime.now().year;
    }).toList();
  }

  List<IncomeModel> incomesByMonth(int month) {
    return incomes.where((income) {
      return income.date.month == month;
    }).toList();
  }

  List<IncomeModel> incomesByYear(int year) {
    return incomes.where((income) {
      return income.date.year == year;
    }).toList();
  }

  List<IncomeModel> incomesByDate(DateTime date) {
    return incomes.where((income) {
      return income.date.isAtSameMomentAs(date);
    }).toList();
  }

  int countIncomes() {
    var count = 0;
    for (var i = 0; i < incomes.length; i++) {
      count += incomes[i].count;
    }
    return count;
  }
}
