import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:clean_architecture_assignment/core/services/network_connectivity/network_connectivity_service.dart';
import 'package:clean_architecture_assignment/core/widget/connectivity_banner/bloc/network_connectivity_state.dart';

import 'network_connectivity_event.dart';

class NetworkConnectivityBloc
    extends Bloc<NetworkConnectivityEvent, NetworkConnectivityState> {
  final NetworkConnectivityService networkConnectivity;
  StreamSubscription<bool>? _subscription;

  bool isConnected = true;

  NetworkConnectivityBloc({required this.networkConnectivity})
    : super(NetworkConnectivityIdle()) {
    _init();
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    networkConnectivity.dispose();
    return super.close();
  }

  Future<void> _init() async {
    _subscription = networkConnectivity.connectionStream.listen(
      _onConnectivityChanged,
    );
  }

  void _onConnectivityChanged(bool result) async {
    if (!result && isConnected) {
      isConnected = result;
      emit(NetworkConnectivityDisconnected());
    } else if (result && !isConnected) {
      isConnected = true;
      emit(NetworkConnectivityReconnected());
      await Future.delayed(const Duration(seconds: 5));
      emit(NetworkConnectivityIdle());
    }
  }
}
