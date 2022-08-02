import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/recharge/recharge.dart';

part 'fullrechargesales_event.dart';
part 'fullrechargesales_state.dart';

class FullrechargesalesBloc
    extends Bloc<FullrechargesalesEvent, FullrechargesalesState> {
  /// an instance of database operations
//final Database
  FullrechargesalesBloc()
      : super(const FullrechargesalesState(
          status: FullrechargesalesStatus.initial,
          rechargeList: [],
          rechargeSalesList: [],
          fullRechargeSalesList: [],
        )) {
    on<FullrechargesalesEvent>((event, emit) {});
  }
}
