import 'package:uitest/models/daterange.dart';
import 'package:uitest/models/enums/date_filter.dart';

import 'recharge.dart';

class FilteredRechargesSales {
  List<RechargeSaleModel> fullRechargeList = [];
  DateFilter? dateFilter;
  MDateRange? dateRange;
  FilteredRechargesSales({
    required this.fullRechargeList,
    this.dateFilter,
    this.dateRange,
  });
  /////////////////////////////////////////////////////////////////////////////////
  /// getters  ////////////////////////////////////////////////////
  List<RechargeModel> get allRecharges => fullRechargeList;
  List<RechargeSaleModel> get allRechargeSales => fullRechargeList;
  ///////////////////////////////////////////////////////////////////////////////
  List<RechargeSaleModel> get inwiList =>
      fullRechargeList.where((e) => e.oprtr == RechargeOperator.inwi).toList();
  List<RechargeSaleModel> get orangeList => fullRechargeList
      .where((e) => e.oprtr == RechargeOperator.orange)
      .toList();
  List<RechargeSaleModel> get iamList =>
      fullRechargeList.where((e) => e.oprtr == RechargeOperator.iam).toList();
}

class FilteredRecharges {
  List<RechargeModel> rechargeList = [];
  DateFilter? dateFilter;
  MDateRange? dateRange;
  FilteredRecharges({
    required this.rechargeList,
    this.dateFilter,
    this.dateRange,
  });
  /////////////////////////////////////////////////////////////////////////////////
  /// getters  ////////////////////////////////////////////////////
  List<RechargeModel> get allRecharges => rechargeList;
  ///////////////////////////////////////////////////////////////////////////////
  List<RechargeModel> get inwiList =>
      rechargeList.where((e) => e.oprtr == RechargeOperator.inwi).toList();
  List<RechargeModel> get orangeList =>
      rechargeList.where((e) => e.oprtr == RechargeOperator.orange).toList();
  List<RechargeModel> get iamList =>
      rechargeList.where((e) => e.oprtr == RechargeOperator.iam).toList();
}
