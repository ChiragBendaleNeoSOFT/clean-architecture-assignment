import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class NetworkConnectivityService with WidgetsBindingObserver {
  final Connectivity _connectivity;

  NetworkConnectivityService({Connectivity? connectivity})
    : _connectivity = connectivity ?? Connectivity();

  // Future<bool> get isConnected async {
  //   final result = await _connectivity.checkConnectivity();
  //   return result != ConnectivityResult.none;
  // }

  // Stream<ConnectivityResult> get connectionStream =>
  //     _connectivity.onConnectivityChanged;

  // final Connectivity _connectivity = Connectivity();

  // Stream controller to broadcast network status

  final StreamController<bool> _connectionStreamController =
      StreamController<bool>();

  StreamSubscription<List<ConnectivityResult>>? _subscription;

  Stream<bool> get connectionStream => _connectionStreamController.stream;

  Future<bool> get isConnected async {
    final results = await _connectivity.checkConnectivity();
    return results.isNotEmpty && results.last != ConnectivityResult.none;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      final online = await isConnected;
      _connectionStreamController.add(online);
    }
  }

  void dispose() {
    _subscription?.cancel();
    _connectionStreamController.close();
  }

  void initialize() async {
    WidgetsBinding.instance.addObserver(this);

    final online = await isConnected;
    _connectionStreamController.add(online);

    _subscription ??= _connectivity.onConnectivityChanged.listen((results) {
      final isOnline =
          results.isNotEmpty && results.last != ConnectivityResult.none;
      _connectionStreamController.add(isOnline);
    });
  }
}
