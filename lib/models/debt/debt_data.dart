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

//DateTime   nearestDeadlineDate = DateTime.now().subtract(const Duration(days: 15));
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

// // total paid detsAmount of  debts
//   double get totalPaidDebtAmount {
//     double total = 0;
//     for (var item in allDebts) {
//       total += item.paidAmount;
//     }
//     total += totalPayments;
//     return total;
//   }

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
    double unit = 0;
    unit = totalDifferencePercentage / 100;

    /// take only the first two digits after the decimal point
    /// and round it to the nearest integer
    unit = unit.toPrecision(2);
    if (unit > 1) {
      unit = 1;
    } else if (unit < 0) {
      unit = 0;
    }
    return unit;
  }
  ////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////
  ///sums and totals/////////////////////////////////////////////////////

  // get total  paid  for the client
  double get totalPaid {
    double total = 0;
    for (var item in allDebts) {
      //total += item.paidAmount;
    }
    return total;
  }

// get total paid amount paidamount + payments
  double get totalPaidDebtAmount {
    double total = 0;
    for (var item in allDebts) {
      // total += item.paidAmount;
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

///////////////////////////////////////////////////////////////////////
  ///other return types /////////////////////////////////////////////////////
  // bool get isPaid if total left is 0
  bool get isFullyPaid {
    return totalLeft == 0;
  }

  /// get the nearest debt deadline Date/////////////////////////////////////////////////////
  DateTime get nearestDeadlineDate {
    DateTime nearestDeadlineDate = DateTime.now();
    for (var item in allDebts) {
      if (item.deadLine.isBefore(nearestDeadlineDate)) {
        nearestDeadlineDate = item.deadLine;
      }
    }
    return nearestDeadlineDate;
  }

  ///////////////////////////////////////////////////////////////////////
  /// Filtered Lists /////////////////////////////////////////////////////////////
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

//////////////////////////////////////////////////////////////////////////////
  /// distincts //////////////////////////////////////////
  /// for debts///
  /// get distinct days as a map /////////////////////////////////////////////
  Map<DateTime, double> get debtsByYear {
    Map<DateTime, double> debtsByYear = {};
    for (DebtModel debt in allDebts) {
      debtsByYear[DateTime(debt.timeStamp.year, 00, 00)] ??= 0.0;
      debtsByYear[DateTime(debt.timeStamp.year, 00, 00)] =
          debtsByYear[DateTime(debt.timeStamp.year, 00, 00)]! + debt.amount;
    }
    return debtsByYear;
  }

  /// get distinct months /////////////////////////////////////////////
  Map<DateTime, double> get debtsByMonth {
    Map<DateTime, double> debtsByMonth = {};
    for (DebtModel debt in allDebts) {
      debtsByMonth[DateTime(debt.timeStamp.year, debt.timeStamp.month, 00)] ??=
          0.0;
      debtsByMonth[DateTime(debt.timeStamp.year, debt.timeStamp.month, 00)] =
          debtsByMonth[
                  DateTime(debt.timeStamp.year, debt.timeStamp.month, 00)]! +
              debt.amount;
    }
    return debtsByMonth;
  }

  /// get distinct years /////////////////////////////////////////////
  Map<DateTime, double> get debtsByDay {
    Map<DateTime, double> debtsByDay = {};
    for (DebtModel debt in allDebts) {
      debtsByDay[DateTime(debt.timeStamp.year, debt.timeStamp.month,
          debt.timeStamp.day)] ??= 0.0;
      debtsByDay[DateTime(debt.timeStamp.year, debt.timeStamp.month,
          debt.timeStamp.day)] = debtsByDay[DateTime(
              debt.timeStamp.year, debt.timeStamp.month, debt.timeStamp.day)]! +
          debt.amount;
    }
    return debtsByDay;
  }

  ////////////////////////////////////////////////////////////////////////////////
  /// for payments///
  /// get distinct days as a map /////////////////////////////////////////////
  Map<DateTime, double> get paymentsByYear {
    Map<DateTime, double> paymentsByYear = {};
    for (PaymentModel payment in allpayments) {
      paymentsByYear[DateTime(payment.date.year, 00, 00)] ??= 0.0;
      paymentsByYear[DateTime(payment.date.year, 00, 00)] =
          paymentsByYear[DateTime(payment.date.year, 00, 00)]! + payment.amount;
    }
    return paymentsByYear;
  }

  /// get distinct months /////////////////////////////////////////////
  Map<DateTime, double> get paymentsByMonth {
    Map<DateTime, double> paymentsByMonth = {};
    for (PaymentModel payment in allpayments) {
      paymentsByMonth[DateTime(payment.date.year, payment.date.month, 00)] ??=
          0.0;
      paymentsByMonth[DateTime(payment.date.year, payment.date.month, 00)] =
          paymentsByMonth[
                  DateTime(payment.date.year, payment.date.month, 00)]! +
              payment.amount;
    }
    return paymentsByMonth;
  }

  /// get distinct years /////////////////////////////////////////////
  Map<DateTime, double> get paymentsByDay {
    Map<DateTime, double> paymentsByDay = {};
    for (PaymentModel payment in allpayments) {
      paymentsByDay[DateTime(
          payment.date.year, payment.date.month, payment.date.day)] ??= 0.0;
      paymentsByDay[DateTime(
              payment.date.year, payment.date.month, payment.date.day)] =
          paymentsByDay[DateTime(
                  payment.date.year, payment.date.month, payment.date.day)]! +
              payment.amount;
    }
    return paymentsByDay;
  }

  ////////////////////////////////////////////////////////////////////////////////
  ///get each month debts as a list of ChartData ////////////////////////////////////////////////////////////////
  /// for debts///
  /// get a list of ChartData for each day
  List<ChartData> get debtsChartDataDDMMYY {
    return debtsByDay.entries.map((entry) {
      return ChartData(
          label: entry.key.toString(), value: entry.value, date: entry.key);
    }).toList();
  }

  /// get a list of ChartData for each month
  List<ChartData> get debtsChartDataMMYY {
    return debtsByMonth.entries.map((entry) {
      return ChartData(
          label: entry.key.toString(), value: entry.value, date: entry.key);
    }).toList();
  }

  /// get a list of ChartData for each year
  List<ChartData> get debtsChartDataYY {
    return debtsByYear.entries.map((entry) {
      return ChartData(
          label: entry.key.toString(), value: entry.value, date: entry.key);
    }).toList();
  }

//////////////////////////////////////////////////////////////////////////////////
  /// for payments///
  /// get a list of ChartData for each day
  List<ChartData> get paymentsChartDataDDMMYY {
    return paymentsByDay.entries.map((entry) {
      return ChartData(
          label: entry.key.toString(), value: entry.value, date: entry.key);
    }).toList();
  }

  /// get a list of ChartData for each month
  List<ChartData> get paymentsChartDataMMYY {
    return paymentsByMonth.entries.map((entry) {
      return ChartData(
          label: entry.key.toString(), value: entry.value, date: entry.key);
    }).toList();
  }

  /// get a list of ChartData for each year
  List<ChartData> get paymentsChartDataYY {
    return paymentsByYear.entries.map((entry) {
      return ChartData(
          label: entry.key.toString(), value: entry.value, date: entry.key);
    }).toList();
  }
//////////////////////////////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////////////////////////////////////////////

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

//////////////////////////////////////////////////////////////////////////////
  /// get DataClasses for the client //////////////////////////////////////////
  /// get DebtData for the client /////////////////////////////////////////////
  DebtData get debtData {
    return DebtData(
      allDebts: allDebts,
      allpayments: allPayments,
    );
  }

  ///
  ////////////////////////////////////////////////////////////////////////////////
  ///get each month payments as a list of ChartData ////////////////////////////////////////////////////////////////
  ///

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
