part of 'fullrechargesales_bloc.dart';

enum FullrechargesalesStatus {
  initial,
  loading,
  added,
  updated,
  deleted,
  loaded,
  error
}

class FullrechargesalesState extends Equatable {
  final List<RechargeModel> rechargeList;
  final List<RechargeSaleModel> rechargeSalesList;
  final List<RechargeSaleModel> fullRechargeSalesList;
  final FullrechargesalesStatus status;
  const FullrechargesalesState({
    required this.status,
    required this.rechargeList,
    required this.rechargeSalesList,
    required this.fullRechargeSalesList,
  });

  /// copyWith() is a good way to deep copy a class.
  FullrechargesalesState copyWith({
    List<RechargeModel>? rechargeList,
    List<RechargeSaleModel>? rechargeSalesList,
    List<RechargeSaleModel>? fullRechargeSalesList,
    FullrechargesalesStatus? status,
  }) {
    return FullrechargesalesState(
      status: status ?? this.status,
      rechargeList: rechargeList ?? this.rechargeList,
      rechargeSalesList: rechargeSalesList ?? this.rechargeSalesList,
      fullRechargeSalesList:
          fullRechargeSalesList ?? this.fullRechargeSalesList,
    );
  }

  @override
  List<Object> get props =>
      [status, rechargeList, rechargeSalesList, fullRechargeSalesList];
}
