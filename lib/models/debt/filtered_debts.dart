part of 'debt.dart';

class FilteredDebts {
  late List<DebtModel> debts;
  late DateFilter filterType;
  // List<ShopClientModel>? shopClients;
  FilteredDebts({
    required this.debts,
    this.filterType = DateFilter.all,
    // this.shopClients,
  });

  List<String> get distinctClients {
    List<String> clients = [];
    // for (var item in shopClients!) {
    //   clients.add(item.clientName!);
    // }
    return clients;
  }

  List<DebtModel> debtsByClient(List<DebtModel> debts) {
    List<DebtModel> debts = [];
    for (var item in distinctClients) {
      debts = debts.where((element) => element.clientId == item).toList();
    }
    return debts;
  }

  List<DebtModel> debtsByDate(DateTime date) {
    List<DebtModel> debts = [];
    for (var item in debts) {
      if (item.timeStamp.day == date.day &&
          item.timeStamp.month == date.month &&
          item.timeStamp.year == date.year) {
        debts.add(item);
      }
    }
    return debts;
  }

  List<DateTime> get distinctDates {
    List<DateTime> list = [];
    for (var element in debts) {
      list.add(element.timeStamp);
    }
    return list.toSet().toList();
  }

  List<DebtModel> debtsToday() {
    List<DebtModel> debts = [];
    for (var item in debts) {
      if (item.timeStamp.day == DateTime.now().day &&
          item.timeStamp.month == DateTime.now().month &&
          item.timeStamp.year == DateTime.now().year) {
        debts.add(item);
      }
    }
    return debts;
  }

// get debts which are 10 days or more overdue
  List<DebtModel> overdueDebts({int days = 10}) {
    List<DebtModel> debtsz = debts;
    // debts.retainWhere((debt) => debt.daysOverdue >= days);
    return debtsz;
  }

  List<DebtModel> debtsThisMonth() {
    List<DebtModel> debts = [];
    for (var item in debts) {
      if (item.timeStamp.month == DateTime.now().month &&
          item.timeStamp.year == DateTime.now().year) {
        debts.add(item);
      }
    }
    return debts;
  }

  List<DebtModel> debtsThisYear() {
    List<DebtModel> debts = [];
    for (var item in debts) {
      if (item.timeStamp.year == DateTime.now().year) {
        debts.add(item);
      }
    }
    return debts;
  }

  List<DebtModel> debtsThisWeek() {
    List<DebtModel> debts = [];
    for (var item in debts) {
      if (item.timeStamp.weekday == DateTime.now().weekday &&
          item.timeStamp.year == DateTime.now().year) {
        debts.add(item);
      }
    }
    return debts;
  }

  List<DebtModel> debtsByDateRange(DateTime start, DateTime end) {
    List<DebtModel> debts = [];
    for (var item in debts) {
      if (item.timeStamp.isAfter(start) && item.timeStamp.isBefore(end)) {
        debts.add(item);
      }
    }
    return debts;
  }
}
