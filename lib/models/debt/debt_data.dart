part of 'debt.dart';

// final debtsDatasProvider = StateProvider<DebtData>((
//   ref,
// ) {
//   final data = ref.watch(filteredDebtsProvider);
//   return DebtData(filteredDebts: data.state.debts);
// });

class DebtData {
  List<DebtModel> allDebts;
  List<PaymentModel> allpayments;
  DebtData({
    required this.allDebts,
    required this.allpayments,
  });
  // get highest debts
  List<DebtModel> get highestDebts {
    List<DebtModel> debts = allDebts;
    debts.sort((b, a) => a.amount.compareTo(b.amount));
    return debts;
  }

// get lowestDebts
  List<DebtModel> get lowestDebts {
    List<DebtModel> debts = allDebts;
    debts.sort((a, b) => a.amount.compareTo(b.amount));
    return debts;
  }

  double get highestDebtAmount {
    var amount = 0.0;
    highestDebts.sort((b, a) => a.amount.compareTo(b.amount));
    if (highestDebts.isNotEmpty) {
      amount = highestDebts.first.amount;
    }
    return amount;
  }
//check if expenses is empty or not then return the first element

  double get lowestDebtAmount {
    var amount = 0.0;

    if (lowestDebts.isNotEmpty) {
      amount = lowestDebts.first.amount;
    }
    return amount;
  }

// get total debts amount regardless of the status
  double get totalDebtAmount {
    var amount = 0.0;
    if (allDebts.isNotEmpty) {
      amount = allDebts.map((debt) => debt.amount).reduce((a, b) => a + b);
    }
    return amount;
  }

//total debts amount for the provided debts list
  double get totalDebtAmountLeft {
    double total = 0;
    total = totalDebtAmount - totalPaidDebtAmount;
    return total;
  }

  // totall payments amount for the provided payments list
  double get totalPayments {
    double total = 0;
    for (var item in allpayments) {
      total += item.amount;
    }
    return total;
  }

// total paid detsAmount of  debts
  double get totalPaidDebtAmount {
    double total = 0;
    for (var item in allDebts) {
      total += item.paidAmount;
    }
    total += totalPayments;
    return total;
  }

  // get difference between total unpaid expenses and total paid expenses in percentage
  int get totalDifferencePercentage {
    double total = 0;

    if (totalDebtAmount != 0) {
      total = (totalPaidDebtAmount * 100) / totalDebtAmount;
    }
    // total = 100;
    if (total > 100) {
      total = 100;
    } else if (total < 0) {
      total = 0;
    }
    return total.toInt();
  }

// get unit Interval
  double get unitInterval {
    double total = 0;
    if (totalDebtAmount != 0) {
      total = totalPaidDebtAmount / totalDebtAmount;
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

/// join the client object with its payments
class ClientDebt {
  ShopClientModel shopClient;
  List<DebtModel> debts;
  List<PaymentModel> payments;
  ClientDebt({
    required this.shopClient,
    required this.debts,
    required this.payments,
  });
  // all debts for this client
  List<DebtModel> get allDebts {
    return debts.where((element) => element.clientId == shopClient.id).toList();
  }

  // all payments for this client
  List<PaymentModel> get allPayments {
    List<PaymentModel> paymentsall =
        payments.where((element) => element.clientId == shopClient.id).toList();
    return paymentsall;
  }

  // get total payments for the client
  double get totalPayments {
    double total = 0;
    for (var item in allPayments) {
      total += item.amount;
    }
    return total;
  }

  // get total debt amount for the client
  double get totalDebtAmount {
    double total = 0;
    for (var item in allDebts) {
      total += item.amount;
    }
    return total;
  }

  // get total  paid  for the client
  double get totalPaid {
    double total = 0;
    for (var item in allDebts) {
      total += item.paidAmount;
    }
    return total;
  }

// get total paid amount paidamount + payments
  double get totalPaidDebtAmount {
    double total = 0;
    for (var item in allDebts) {
      total += item.paidAmount;
    }
    total += totalPayments;
    return total;
  }

  // get total left for the client
  double get totalLeft {
    double total = 0;
    total = totalDebtAmount - totalPaidDebtAmount;
    return total;
  }

  // bool get isPaid if total left is 0
  bool get isFullyPaid {
    return totalLeft == 0;
  }

  // get overdue debts for this client
  List<DebtModel> get overdueDebts {
    List<DebtModel> debts =
        allDebts.where((element) => element.isOverdue).toList();
    return debts;
  }

// debts today
  List<DebtModel> get todayDebts {
    List<DebtModel> debts = allDebts
        .where((element) => element.timeStamp.day == DateTime.now().day)
        .toList();
    return debts;
  }

// debts this month
  List<DebtModel> get debtsThisMonth {
    List<DebtModel> debts = allDebts.where((element) {
      return element.timeStamp.month == DateTime.now().month;
    }).toList();
    return debts;
  }

// debts this year
  List<DebtModel> get debtsThisYear {
    List<DebtModel> debts = allDebts.where((element) {
      return element.timeStamp.year == DateTime.now().year;
    }).toList();
    return debts;
  }
}
// }
// // provider for the list of ClientDebt
// final clientDebtStateProvider =
//     StateProvider<ClientDebtStateNotifier>((ref) {
//   return ClientDebtStateNotifier(ref);
// });
// class ClientDebtStateNotifier extends StateNotifier<ListClientDebt> {
//  final StateProviderRef mref;

//   ClientDebtStateNotifier(this.mref)
//       : super(ClientDebt(
//           shopClient: mref.watch(shopClientsProvider.state).state.first,
//           debts: mref.watch(debtsListProvider.state).state,
//           payments: mref.watch(paymentsListProvider.state).state,
//         ));
//  RangeFilter get rangeFilter => mref.watch((rangeFilterProvider).state).state;
//   SelectedDateRange get userDateRange =>
//       mref.watch((dateRangeStateNotifier)).range;

//   List<ClientDebt> get filterDebts {
//     switch (rangeFilter) {
//       case RangeFilter.all:
//         return state =
//             ClientDebt();

//       case RangeFilter.month:
//         return state =
//             DebtData(clientDebts: mref.watch(clientDebtListProvider.state).state);

//       case RangeFilter.today:
//         return state =
//             DebtData(clientDebts: mref.watch(clientDebtListProvider.state).state);

//       case RangeFilter.week:
//         return state =
//             DebtData(clientDebts: mref.watch(clientDebtListProvider.state).state);

//       case RangeFilter.year:
//         return state =
//             DebtData(clientDebts: mref.watch(clientDebtListProvider.state).state);

//       case RangeFilter.custom:
//         return state =
//             DebtData(clientDebts: mref.watch(clientDebtListProvider.state).state);
//     }
//   }

//   DebtData get thisMonthDebtsData {
//     return state =
//         DebtData(clientDebts: mref.watch(clientDebtListProvider.state).state);
//   }

//   DebtData get todayDebtsData {
//     return state =
//         DebtData(clientDebts: mref.watch(clientDebtListProvider.state).state);
//   }

//   DebtData get thisYearDebtsData {
//     return state =
//         DebtData(clientDebts: mref.watch(clientDebtListProvider.state).state);
//   }

// }
