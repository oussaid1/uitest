part of 'expenses.dart';

class FilteredExpenses {
  List<ExpenseModel> expenses;
  FilteredExpenses({required this.expenses});
  expensesByDate(DateTime date) {
    return expenses
        .where((expense) =>
            expense.date.day == date.day &&
            expense.date.month == date.month &&
            expense.date.year == date.year)
        .toList();
  }

  List<ExpenseModel> expensesToday() {
    return expenses
        .where((expense) =>
            expense.date.day == DateTime.now().day &&
            expense.date.month == DateTime.now().month &&
            expense.date.year == DateTime.now().year)
        .toList();
  }

  List<ExpenseModel> expensesThisMonth() {
    return expenses
        .where((expense) =>
            expense.date.month == DateTime.now().month &&
            expense.date.year == DateTime.now().year)
        .toList();
  }

  List<ExpenseModel> expensesThisWeek() {
    return expenses
        .where((expense) =>
            expense.date.weekday == DateTime.now().weekday &&
            expense.date.month == DateTime.now().month &&
            expense.date.year == DateTime.now().year)
        .toList();
  }

  List<ExpenseModel> expensesThisYear() {
    return expenses
        .where((expense) => expense.date.year == DateTime.now().year)
        .toList();
  }

  List<ExpenseModel> expensesByDateRange(DateTime start, DateTime end) {
    return expenses
        .where((expense) =>
            expense.date.isAfter(start) && expense.date.isBefore(end))
        .toList();
  }
}
