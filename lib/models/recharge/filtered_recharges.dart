import 'package:uitest/models/daterange.dart';
import 'package:uitest/models/enums/date_filter.dart';

import 'recharge.dart';

class FilteredRecharges {
  List<RechargeSaleModel> fullRechargeList = [];
  DateFilter? dateFilter;
  MDateRange? dateRange;
  FilteredRecharges({
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
