import 'package:uitest/models/client/shop_client.dart';
import 'recharge.dart';

class RechargesData {
  List<RechargeSale> rechargeSalesList = [];
  RechargesData({
    required this.rechargeSalesList,
  });
  /////////////////////////////////////////////////////////////////////////////////
  //////// getters  ////////////////////////////////////////////////////
  //List<RechargeModel> get allRecharges => rechargeList;
  List<RechargeSale> get allRechargeSales => rechargeSalesList;
///////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////
  ///////// sums  ////////////////////////////////////////////////////
  num get sumOfRecharges =>
      rechargeSalesList.fold(0, (sum, recharge) => sum + recharge.amount);
}

class ShopClientRechargesData {
  ShopClientModel shopClient;
  List<RechargeSale> rechargeSalesList = [];
  ShopClientRechargesData({
    required this.rechargeSalesList,
    required this.shopClient,
  });
  /////////////////////////////////////////////////////////////////////////////////
  /// getters  ////////////////////////////////////////////////////
  RechargesData get rechargesData => RechargesData(
        rechargeSalesList: rechargeSalesList,
      );
}
