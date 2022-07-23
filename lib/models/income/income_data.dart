part of 'income.dart';

class IncomeData {
  List<IncomeModel> filteredIncome;
  IncomeData({required this.filteredIncome});

  double get totalIncomeAmount {
    return filteredIncome.fold(0.0, (sum, income) {
      return sum + income.amount;
    });
  }

  //  get a list of incomes sorted by highest amount
  List<IncomeModel> get sortedHighestIncome {
    return filteredIncome.toList()
      ..sort((a, b) => b.amount.compareTo(a.amount));
  }

  //  get a list of incomes sorted by lowest amount
  List<IncomeModel> get sortedLowestIncome {
    return filteredIncome.toList()
      ..sort((a, b) => a.amount.compareTo(b.amount));
  }

  // check if sortedlowest income not empty then get lowest income amount in the list
  double get lowestIncomeAmount {
    if (sortedLowestIncome.isNotEmpty) {
      return sortedLowestIncome.first.amount;
    }
    return 0.0;
  }

  // check if sortedhighest income not empty then get highest income amount in the list
  double get highestIncomeAmount {
    if (sortedHighestIncome.isNotEmpty) {
      return sortedHighestIncome.first.amount;
    }
    return 0.0;
  }
}
