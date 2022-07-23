part of 'expenses.dart';

class ExpenseData {
  List<ExpenseModel> expenses;
  ExpenseData({required this.expenses});
  List<ExpenseModel> get sortedtExpenses {
    return expenses.where((expense) => expense.isPaid).toList()
      ..sort((a, b) => b.date.compareTo(a.date));
  }

  List<ExpenseModel> get highestExpenses {
    var expensew = expenses;
    expensew.sort((b, a) => a.amount.compareTo(b.amount));
    return expensew;
  }

  List<ExpenseModel> get lowestExpenses {
    List<ExpenseModel> expensew = [];
    expensew = expenses;
    expensew.sort((a, b) => a.amount.compareTo(b.amount));
    return expensew;
  }

  double get highestExpenseAmount {
    var amountz = 0.0;
    if (highestExpenses.isNotEmpty) {
      amountz = highestExpenses.first.amount;
    }
    return amountz;
  }
//check if expenses is empty or not then return the first element

  double get lowestExpenseAmount {
    var amountz = 0.0;
    if (lowestExpenses.isNotEmpty) {
      amountz = lowestExpenses.first.amount;
    }
    return amountz;
  }

  List<ExpenseModel> getUnSortedtExpenses() {
    return expenses.where((expense) => !expense.isPaid).toList();
  }

  List<ExpenseModel> getExpensesByCategory(ExpenseCategory category) {
    return expenses
        .where((expense) => expense.expenseCategory == category)
        .toList();
  }

// get expenses by dateTime
  List<ExpenseModel> getExpensesByDate(DateTime dateTime) {
    return expenses
        .where((expense) =>
            expense.date.day == dateTime.day &&
            expense.date.month == dateTime.month &&
            expense.date.year == dateTime.year)
        .toList();
  }

  Map<String, dynamic> get countDistinctExpenses {
    Map<String, dynamic> map = {};
    for (var expense in expenses) {
      if (map.containsKey(expense.expenseCategory.toString())) {
        map[expense.expenseCategory.toString()] += 1;
      } else {
        map[expense.expenseCategory.toString()] = 1;
      }
    }
    return map;
  }

  Map<String, dynamic> getCountDistinctExpensesByDate(DateTime dateTime) {
    Map<String, dynamic> map = {};
    for (var expense in expenses) {
      if (expense.date.day == dateTime.day &&
          expense.date.month == dateTime.month &&
          expense.date.year == dateTime.year) {
        if (map.containsKey(expense.expenseCategory.toString())) {
          map[expense.expenseCategory.toString()] += 1;
        } else {
          map[expense.expenseCategory.toString()] = 1;
        }
      }
    }
    return map;
  }

  List<ExpenseModel> get paidExpenses {
    return expenses.where((expense) => expense.isPaid).toList();
  }

  List<ExpenseModel> expensesByDueDate(DateTime dateTime) {
    return expenses
        .where((expense) =>
            expense.deadLine.day == dateTime.day &&
            expense.deadLine.month == dateTime.month &&
            expense.deadLine.year == dateTime.year)
        .toList();
  }

  List<ExpenseModel> expensesDueDateLessThanCurrentDate() {
    DateTime currentDate = DateTime.now();
    List<ExpenseModel> expenses = [];
    for (var i = 0; i < 10; i++) {
      expenses.addAll(expensesByDueDate(currentDate));
      currentDate = currentDate.subtract(const Duration(days: 1));
    }
    return expenses;
  }

  // data only from provided expenses

  double get totalExpensesAmount {
    double total = 0;
    for (var expense in expenses) {
      total += expense.amount;
    }
    return total;
  }

// get total unpaid expenses
  double get totalUnPaidExpensesAmount {
    double total = 0;
    for (var expense in expenses) {
      if (!expense.isPaid) {
        total += expense.amount;
      }
    }
    return total;
  }

// get total paid expenses
  double get totalPaidExpensesAmount {
    double total = 0;
    for (var expense in expenses) {
      if (expense.isPaid) {
        total += expense.amount;
      }
    }
    return total;
  }

// get difference between total unpaid expenses and total paid expenses
  double get totalDifference {
    double total = 0;
    total = totalUnPaidExpensesAmount - totalPaidExpensesAmount;

    return total;
  }

// ignore: todo
// TODO: implement get total left percentage
  // get difference between total unpaid expenses and total paid expenses in percentage
  int get totalDifferencePercentage {
    double total = 0;

    if (totalUnPaidExpensesAmount != 0) {
      total = (totalPaidExpensesAmount * 100) / totalExpensesAmount;
    }
    if (total < 0) {
      return 0;
    }
    if (total > 100) {
      return 100;
    }

    return total.toInt();
  }

// get unit Interval
  double get unitInterval {
    double total = 0;
    if (totalExpensesAmount != 0) {
      total = totalPaidExpensesAmount / totalExpensesAmount;
    }
    if (total < 0) {
      total = 0;
    }
    if (total > 1) {
      total = 1;
    }
    return total;
  }
}
