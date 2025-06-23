import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:clean_architecture_assignment/core/services/network_connectivity/network_connectitvity.dart';
import 'package:clean_architecture_assignment/core/widget/connectivity_banner/bloc/connectivity_state.dart';

import 'connectivity_event.dart';

class ConnectivityBloc extends Bloc<ConnectivityEvent, ConnectivityState> {
  final NetworkConnectivityService networkConnectivity;
  StreamSubscription<bool>? _subscription;

  bool isConnected = true;

  ConnectivityBloc({required this.networkConnectivity})
    : super(ConnectivityIdle()) {
    // Specific event handler for FetchUsers
    on<CheckNetWorkConnectivityEvent>((event, emit) {
      _init();
    });
  }

  Future<void> _init() async {
    _subscription = networkConnectivity.connectionStream.listen(
      _onConnectivityChanged,
    );
  }

  void _onConnectivityChanged(bool result) async {
    if (!result && isConnected) {
      isConnected = result;
      emit(ConnectivityDisconnected());
    } else if (result && !isConnected) {
      isConnected = true;
      emit(ConnectivityReconnected());
      await Future.delayed(const Duration(seconds: 5));
      emit(ConnectivityIdle());
    }
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    networkConnectivity.dispose();
    return super.close();
  }
}
