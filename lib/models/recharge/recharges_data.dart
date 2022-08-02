import 'package:uitest/models/chart_data.dart';
import 'package:uitest/models/client/shop_client.dart';
import '../../screens/recharge/stock/recharge_charts.dart';
import 'recharge.dart';

class RechargesData {
  List<RechargeModel> rechargesList = [];
  RechargesData({
    required this.rechargesList,
  });
  /////////////////////////////////////////////////////////////////////////////////
  //////// getters  ////////////////////////////////////////////////////
  //List<RechargeModel> get allRecharges => rechargeList;
  List<RechargeModel> get allRecharges => rechargesList;
///////////////////////////////////////////////////////////////////////////////
  ///distincts ///////////////////////////////
  Map<DateTime, List<RechargeModel>> get dailys {
    Map<DateTime, List<RechargeModel>> map = {};
    for (RechargeModel r in allRecharges) {
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

  Map<DateTime, List<RechargeModel>> get monthlys {
    Map<DateTime, List<RechargeModel>> map = {};
    for (RechargeModel r in allRecharges) {
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

  Map<DateTime, List<RechargeModel>> get yearlys {
    Map<DateTime, List<RechargeModel>> map = {};
    for (RechargeModel r in allRecharges) {
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
    for (RechargeModel r in allRecharges) {
      map[r.oprtr.name] ??= [];
      map[r.oprtr.name]!.add(r);
    }
    return map;
  }

  /// get the recharge amount for each operator as a list of chartdata ///////////////////////////////
  List<RechargePieChartData> get oprtrRechargeAmntStckList {
    List<RechargePieChartData> list = [];
    for (String key in oprtrRechargeAmntStck.keys) {
      list.add(RechargePieChartData(
        label: key,
        list: oprtrRechargeAmntStck[key],
      ));
    }
    return list;
  }

/////////////////////////////////////////////////////////////////////////////
/////// chartData////////////////////////////////////////////////////
  List<ChartData> get chartData {
    List<ChartData> chartData = [];
    for (DateTime date in dailys.keys) {
      chartData.add(ChartData(
        date: date,
        data: dailys[date],
      ));
    }
    return chartData;
  }

  ///////// sums  ////////////////////////////////////////////////////
  /// sum of all recharge amount without percentage calculation in sales
  num get amountTotal =>
      rechargesList.fold(0, (sum, recharge) => sum + recharge.amount);

  /// sum of all recharge amount with percentage calculation in sales
  num get netProfitTotal =>
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
  RechargesData get rechargesData => RechargesData(
        rechargesList: fullRechargesList,
      );
}
