import 'package:uitest/models/chart_data.dart';
import 'package:uitest/models/client/shop_client.dart';
import '../../screens/recharge/stock/recharge_charts.dart';
import 'recharge.dart';

class RechargeData {
  List<RechargeModel> rechargesList = [];
  RechargeData({
    required this.rechargesList,
  });
  /////////////////////////////////////////////////////////////////////////////////
  //////// getters  ////////////////////////////////////////////////////
  //List<RechargeModel> get allRecharges => rechargesList;
  /////////////////////////////////////////////////////////////////////////////////
  //////// getters  ////////////////////////////////////////////////////
  //List<RechargeModel> get allRecharges => rechargesList;
  List<RechargeModel> get allRecharge => rechargesList;
///////////////////////////////////////////////////////////////////////////////
  List<RechargeModel> get inwiList =>
      rechargesList.where((e) => e.oprtr == RechargeOperator.inwi).toList();
  /////////////////////////////////////////////////////////////////////////////////
  List<RechargeModel> get orangeList =>
      rechargesList.where((e) => e.oprtr == RechargeOperator.orange).toList();
  /////////////////////////////////////////////////////////////////////////////////
  List<RechargeModel> get iamList =>
      rechargesList.where((e) => e.oprtr == RechargeOperator.iam).toList();
  /////////////////////////////////////////////////////////////////////////////////

  ///distincts ///////////////////////////////
  Map<DateTime, List<RechargeModel>> get daily {
    Map<DateTime, List<RechargeModel>> map = {};
    for (RechargeModel r in allRecharge) {
      map[DateTime(
        r.date.year,
        r.date.month,
        r.date.day,
      )] ??= [];
      map[DateTime(
        r.date.year,
        r.date.month,
        r.date.day,
      )]!
          .add(r);
    }
    return map;
  }

  Map<DateTime, List<RechargeModel>> get monthly {
    Map<DateTime, List<RechargeModel>> map = {};
    for (RechargeModel r in allRecharge) {
      map[DateTime(
        r.date.year,
        r.date.month,
      )] ??= [];
      map[DateTime(
        r.date.year,
        r.date.month,
      )]!
          .add(r);
    }
    return map;
  }

  Map<DateTime, List<RechargeModel>> get yearly {
    Map<DateTime, List<RechargeModel>> map = {};
    for (RechargeModel r in allRecharge) {
      map[DateTime(
        r.date.year,
      )] ??= [];
      map[DateTime(
        r.date.year,
      )]!
          .add(r);
    }
    return map;
  }

//////////////////////////////////////////////////////////////////////////
  /// get the recharge amount for each operator ///////////////////////////////
  Map<String, List<RechargeModel>> get oprtrRechargeAmntStck {
    Map<String, List<RechargeModel>> map = {};
    for (RechargeModel r in allRecharge) {
      map[r.oprtr.name] ??= [];
      map[r.oprtr.name]!.add(r);
    }
    return map;
  }

  /// get the recharge amount for each operator as a list of chartdata ///////////////////////////////
  List<RechargeChartData> get oprtrRechargeAmntStckList {
    List<RechargeChartData> list = [];
    for (String key in oprtrRechargeAmntStck.keys) {
      list.add(RechargeChartData(
        label: key,
        list: oprtrRechargeAmntStck[key],
        date: DateTime.now(),
      ));
    }
    return list;
  }

  List<RechargeChartData> get inwiChartDataDaily {
    List<RechargeChartData> list = [];
    for (DateTime key in daily.keys) {
      list.add(RechargeChartData(
        label: RechargeOperator.inwi.name,
        date: key,
        list: daily[key]!
            .where((element) => element.oprtr == RechargeOperator.inwi)
            .toList(),
      ));
    }
    return list;
  }

  List<RechargeChartData> get orangeChartDataDaily {
    List<RechargeChartData> list = [];
    for (DateTime key in daily.keys) {
      list.add(RechargeChartData(
        label: RechargeOperator.orange.name,
        date: key,
        list: daily[key]!
            .where((element) => element.oprtr == RechargeOperator.orange)
            .toList(),
      ));
    }
    return list;
  }

  ///  get the recharge amount for each operator as a list of chartdata
  List<RechargeChartData> get iamChartDataDaily {
    List<RechargeChartData> list = [];
    for (DateTime key in daily.keys) {
      list.add(RechargeChartData(
        label: RechargeOperator.iam.name,
        date: key,
        list: daily[key]!
            .where((element) => element.oprtr == RechargeOperator.iam)
            .toList(),
      ));
    }
    return list;
  }

  List<RechargeChartData> get allOperatorsChartDataDaily {
    List<RechargeChartData> list = [];
    for (DateTime key in daily.keys) {
      list.add(RechargeChartData(
        label: 'all',
        date: key,
        list: daily[key],
      ));
    }
    return list;
  }

///////////////////////////////////////////////////////////////////////////////
  /// get the recharge amount for each operator ///////////////////////////////
  RechargeChartData get oprtrRechargeAmntStckMonthly {
    return RechargeChartData(
      label: '',
      list: allRecharge,
      date: DateTime.now(),
    );
  }

/////////////////////////////////////////////////////////////////////////////
/////// chartData////////////////////////////////////////////////////
  List<ChartData> get chartData {
    List<ChartData> chartData = [];
    for (DateTime date in daily.keys) {
      chartData.add(ChartData(
        date: date,
        data: daily[date],
      ));
    }
    return chartData;
  }

/////////////////////////////////////////////////////////////////////////////
/////// chartData////////////////////////////////////////////////////
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
      rechargesList.fold(0, (sum, recharge) => sum + recharge.amount);

  /// sum of all recharge amount with percentage calculation in sales
  num get sumOfRecharge =>
      rechargesList.fold(0, (sum, recharge) => sum + recharge.netProfit);
}

class ShopClientRechargesData {
  ShopClientModel shopClient;
  List<RechargeModel> fullRechargesList = [];
  ShopClientRechargesData({
    required this.fullRechargesList,
    required this.shopClient,
  });
  /////////////////////////////////////////////////////////////////////////////////
  /// getters  ////////////////////////////////////////////////////
  RechargeData get rechargesData => RechargeData(
        rechargesList: fullRechargesList,
      );
}
