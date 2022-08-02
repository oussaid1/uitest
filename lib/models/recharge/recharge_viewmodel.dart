import 'package:uitest/models/client/shop_client.dart';
import 'package:uitest/models/recharge/recharges_data.dart';

import 'recharge.dart';

class RecghargeViewModel {
  final List<ShopClientModel> shopClients = [];
  final List<RechargeModel> _rechargeList = [];
  final List<RechargeSaleModel> _rechargeSalesList = <RechargeSaleModel>[];
  List<RechargeModel> get rechargeList => _rechargeList;
  List<RechargeSaleModel> get rechargeSalesList => _rechargeSalesList;

  RecghargeViewModel({
    required List<RechargeModel> rechargeList,
    required List<RechargeSaleModel> rechargeSalesList,
    required List<ShopClientModel> shopClients,
  }) {
    _rechargeList.addAll(rechargeList);
    _rechargeSalesList.addAll(rechargeSalesList);
  }

  //////////////////////////////////////////////////////////////
  /// get combined recharge list

  List<RechargeSaleModel> get combinedRechargeList {
    List<RechargeSaleModel> combinedList = [];
    for (RechargeSaleModel rechargeSale in rechargeSalesList) {
      for (RechargeModel recharge in rechargeList) {
        if (rechargeSale.soldRchrgId == recharge.id) {
          combinedList.add(RechargeSaleModel(
            clntID: rechargeSale.clntID,
            rSId: rechargeSale.rSId,
            qnttSld: rechargeSale.qnttSld,
            dateSld: rechargeSale.dateSld,
            soldRchrgId: rechargeSale.soldRchrgId,
            rechargeModel: recharge,
          ));
        }
      }
    }
    return combinedList;
  }

  //////////////////////////////////////////////////////////////
  /// get combined recharge joined to shop client
  List<ShopClientRechargesData> get shopClientCombinedRechargeSales {
    List<ShopClientRechargesData> combinedList = [];
    for (ShopClientModel client in shopClients) {
      combinedList.add(ShopClientRechargesData(
        shopClient: client,
    fullRechargesList: combinedRechargeList
            .where((RechargeSaleModel rechargeSale) =>
                rechargeSale.clntID == client.id)
            .toList(),
      ));
    }

    return combinedList;
  }
}
