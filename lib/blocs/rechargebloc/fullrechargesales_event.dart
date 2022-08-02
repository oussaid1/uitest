part of 'fullrechargesales_bloc.dart';

abstract class FullrechargesalesEvent extends Equatable {
  const FullrechargesalesEvent();

  @override
  List<Object> get props => [];
}

/// get full recharge sales event
/// This event is used to get full recharge sales.
class GetFullRechargeSales extends FullrechargesalesEvent {}

/// load FullRechargeSales
class LoadFullRechargeSales extends FullrechargesalesEvent {
  final List<RechargeModel> rechargeList;
  final List<RechargeSaleModel> rechargeSalesList;
  final List<RechargeSaleModel> fullRechargeSalesList;
  final FullrechargesalesStatus status;
  const LoadFullRechargeSales({
    required this.status,
    required this.rechargeList,
    required this.rechargeSalesList,
    required this.fullRechargeSalesList,
  });
}
