import '../../screens/recharge/sales/recharge_sales_chats.dart';
import '../../screens/recharge/stock/recharge_charts.dart';
import '../chart_data.dart';
import 'recharge.dart';

class RechargeSalesData {
  List<RechargeSaleModel> rechargeSalesList = [];
  RechargeSalesData({
    required this.rechargeSalesList,
  });
  /////////////////////////////////////////////////////////////////////////////////
  //////// getters  ////////////////////////////////////////////////////
  //List<RechargeModel> get allRecharges => rechargeList;
  List<RechargeSaleModel> get allRechargeSales => rechargeSalesList;
///////////////////////////////////////////////////////////////////////////////
  List<RechargeSaleModel> get inwiList =>
      rechargeSalesList.where((e) => e.oprtr == RechargeOperator.inwi).toList();
  /////////////////////////////////////////////////////////////////////////////////
  List<RechargeSaleModel> get orangeList => rechargeSalesList
      .where((e) => e.oprtr == RechargeOperator.orange)
      .toList();
  /////////////////////////////////////////////////////////////////////////////////
  List<RechargeSaleModel> get iamList =>
      rechargeSalesList.where((e) => e.oprtr == RechargeOperator.iam).toList();
  /////////////////////////////////////////////////////////////////////////////////

  ///distincts ///////////////////////////////
  Map<DateTime, List<RechargeSaleModel>> get dailySales {
    Map<DateTime, List<RechargeSaleModel>> map = {};
    for (RechargeSaleModel r in allRechargeSales) {
      map[DateTime(
        r.dateSld.year,
        r.dateSld.month,
        r.dateSld.day,
      )] ??= [];
      map[DateTime(
        r.dateSld.year,
        r.dateSld.month,
        r.dateSld.day,
      )]!
          .add(r);
    }
    return map;
  }

  Map<DateTime, List<RechargeSaleModel>> get monthlySales {
    Map<DateTime, List<RechargeSaleModel>> map = {};
    for (RechargeSaleModel r in allRechargeSales) {
      map[DateTime(
        r.dateSld.year,
        r.dateSld.month,
      )] ??= [];
      map[DateTime(
        r.dateSld.year,
        r.dateSld.month,
      )]!
          .add(r);
    }
    return map;
  }

  Map<DateTime, List<RechargeSaleModel>> get yearlySales {
    Map<DateTime, List<RechargeSaleModel>> map = {};
    for (RechargeSaleModel r in allRechargeSales) {
      map[DateTime(
        r.dateSld.year,
      )] ??= [];
      map[DateTime(
        r.dateSld.year,
      )]!
          .add(r);
    }
    return map;
  }

//////////////////////////////////////////////////////////////////////////
  /// get the recharge amount for each operator ///////////////////////////////
  Map<String, List<RechargeSaleModel>> get oprtrRechargeAmntStck {
    Map<String, List<RechargeSaleModel>> map = {};
    for (RechargeSaleModel r in allRechargeSales) {
      map[r.oprtr.name] ??= [];
      map[r.oprtr.name]!.add(r);
    }
    return map;
  }

  /// get the recharge amount for each operator as a list of chartdata ///////////////////////////////
  List<RechargeSaleChartData> get oprtrRechargeAmntStckList {
    List<RechargeSaleChartData> list = [];
    for (String key in oprtrRechargeAmntStck.keys) {
      list.add(RechargeSaleChartData(
        label: key,
        list: oprtrRechargeAmntStck[key],
        date: DateTime.now(),
      ));
    }
    return list;
  }

  List<RechargeSaleChartData> get inwiChartDataDaily {
    List<RechargeSaleChartData> list = [];
    for (DateTime key in dailySales.keys) {
      list.add(RechargeSaleChartData(
        label: RechargeOperator.inwi.name,
        date: key,
        list: dailySales[key]!
            .where((element) => element.oprtr == RechargeOperator.inwi)
            .toList(),
      ));
    }
    return list;
  }

  List<RechargeSaleChartData> get orangeChartDataDaily {
    List<RechargeSaleChartData> list = [];
    for (DateTime key in dailySales.keys) {
      list.add(RechargeSaleChartData(
        label: RechargeOperator.orange.name,
        date: key,
        list: dailySales[key]!
            .where((element) => element.oprtr == RechargeOperator.orange)
            .toList(),
      ));
    }
    return list;
  }

  ///  get the recharge amount for each operator as a list of chartdata
  List<RechargeSaleChartData> get iamChartDataDaily {
    List<RechargeSaleChartData> list = [];
    for (DateTime key in dailySales.keys) {
      list.add(RechargeSaleChartData(
        label: RechargeOperator.iam.name,
        date: key,
        list: dailySales[key]!
            .where((element) => element.oprtr == RechargeOperator.iam)
            .toList(),
      ));
    }
    return list;
  }

  List<RechargeSaleChartData> get allOperatorsChartDataDaily {
    List<RechargeSaleChartData> list = [];
    for (DateTime key in dailySales.keys) {
      list.add(RechargeSaleChartData(
        label: 'all',
        date: key,
        list: dailySales[key],
      ));
    }
    return list;
  }

///////////////////////////////////////////////////////////////////////////////
  /// get the recharge amount for each operator ///////////////////////////////
  RechargeSaleChartData get oprtrRechargeAmntStckMonthly {
    return RechargeSaleChartData(
      label: '',
      list: allRechargeSales,
      date: DateTime.now(),
    );
  }

/////////////////////////////////////////////////////////////////////////////
/////// chartData////////////////////////////////////////////////////
  List<ChartData> get chartData {
    List<ChartData> chartData = [];
    for (DateTime date in dailySales.keys) {
      chartData.add(ChartData(
        date: date,
        data: dailySales[date],
      ));
    }
    return chartData;
  }

/////////////////////////////////////////////////////////////////////////////
/////// chartData////////////////////////////////////////////////////
  RechargeSaleChartData oprtrRechargeSaleChartData(
      String label, List<RechargeSaleModel> list) {
    return RechargeSaleChartData(
      label: label,
      list: list,
      date: DateTime.now(),
    );
  }

  RechargeChartData oprtrRechargeChartData(
      String label, List<RechargeModel> list) {
    return RechargeChartData(
      label: label,
      list: list,
      date: DateTime.now(),
    );
  }

/////// chartData////////////////////////////////////////////////////
  ///////// sums  ////////////////////////////////////////////////////
  /// sum of all recharge amount without percentage calculation in sales
  num get sumOfRecharges =>
      rechargeSalesList.fold(0, (sum, recharge) => sum + recharge.amount);

  /// sum of all recharge amount with percentage calculation in sales
  num get sumOfRechargeSales =>
      rechargeSalesList.fold(0, (sum, recharge) => sum + recharge.netProfit);
}
