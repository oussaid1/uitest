import 'package:uitest/models/daterange.dart';
import 'package:uitest/models/enums/date_filter.dart';

import 'recharge.dart';

class FilteredRecharges {
  List<RechargeModel> rechargeList = [];
  List<RechargeSale> rechargeSalesList = [];
  DateFilter? dateFilter;
  MDateRange? dateRange;
  FilteredRecharges({
    required this.rechargeList,
    required this.rechargeSalesList,
    this.dateFilter,
    this.dateRange,
  });
  /////////////////////////////////////////////////////////////////////////////////
  /// getters  ////////////////////////////////////////////////////
  List<RechargeModel> get allRecharges => rechargeList;
  List<RechargeSale> get allRechargeSales => rechargeSalesList;
  ///////////////////////////////////////////////////////////////////////////////
}
