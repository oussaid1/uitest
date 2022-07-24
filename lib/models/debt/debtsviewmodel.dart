import '../models.dart';

class DebtsStatsViewModel {
  DebtsStatsViewModel({
    required this.debts,
    required this.payments,
    required this.shopClients,
    this.filter = DebtFilter.all,
  });

  final List<DebtModel> debts;
  final List<PaymentModel> payments;
  final List<ShopClientModel> shopClients;
  final DebtFilter? filter;

  /// join each client to its debts payments and debts as a list of ShopClientsDeb
  List<ClientDebt> get clientDebts {
    List<ClientDebt> list = [];
    for (var i = 0; i < shopClients.length; i++) {
      list.add(ClientDebt(
          shopClient: shopClients[i],
          debts: debts.where((d) => shopClients[i].id == d.clientId).toList(),
          payments:
              payments.where((p) => shopClients[i].id == p.clientId).toList()));
    }

    return list;
  }

  /// get each client debt total as a list of ChartData
  List<ChartData> get clientDebtTotal {
    List<ChartData> list = [];
    for (var i = 0; i < clientDebts.length; i++) {
      list.add(ChartData(
          label: clientDebts[i].shopClient.clientName,
          value: clientDebts[i].debtData.totalDebtAmountLeft));
    }

    return list;
  }

  /// conver clientsDebts to a list of DebtsStats
}

// class DebtsStats {
//   DebtsStats({
//     required this.shopClient,
//     required this.debts,
//     required this.payments,
//   });

//   final ShopClientModel shopClient;
//   final List<DebtModel> debts;
//   final List<PaymentModel> payments;
// }
