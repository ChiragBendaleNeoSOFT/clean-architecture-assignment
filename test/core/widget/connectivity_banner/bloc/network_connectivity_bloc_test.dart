import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:clean_architecture_assignment/core/services/network_connectivity/network_connectivity_service.dart';
import 'package:clean_architecture_assignment/core/widget/connectivity_banner/bloc/network_connectivity_bloc.dart';
import 'package:clean_architecture_assignment/core/widget/connectivity_banner/bloc/network_connectivity_event.dart';
import 'package:clean_architecture_assignment/core/widget/connectivity_banner/bloc/network_connectivity_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([NetworkConnectivityService])
void main() {
  late NetworkConnectivityBloc networkConnectivityBloc;
  late NetworkConnectivityService mockNetworkConnectivityService;
  late StreamController<bool> connectionStreamController;

  setUp(() {
    mockNetworkConnectivityService = NetworkConnectivityService();
    connectionStreamController = StreamController<bool>();

    when(
      mockNetworkConnectivityService.connectionStream,
    ).thenAnswer((_) => connectionStreamController.stream);
    when(
      mockNetworkConnectivityService.isConnected,
    ).thenAnswer((_) async => true);

    networkConnectivityBloc = NetworkConnectivityBloc(
      networkConnectivity: mockNetworkConnectivityService,
    );
  });

  tearDown(() {
    connectionStreamController.close();
    networkConnectivityBloc.close();
  });

  group('NetworkConnectivityBloc', () {
    blocTest<NetworkConnectivityBloc, NetworkConnectivityState>(
      'emits [NetworkConnectivityDisconnected] when connection is lost',
      build: () => networkConnectivityBloc,
      act: (bloc) => connectionStreamController.add(false),
      expect: () => [isA<NetworkConnectivityDisconnected>()],
    );

    blocTest<NetworkConnectivityBloc, NetworkConnectivityState>(
      'emits [NetworkConnectivityReconnected] when connection is restored',
      build: () => networkConnectivityBloc,
      act: (bloc) => connectionStreamController.add(true),
      expect: () => [isA<NetworkConnectivityReconnected>()],
    );

    blocTest<NetworkConnectivityBloc, NetworkConnectivityState>(
      'emits correct states on CheckNetWorkConnectivityEvent',
      build: () => networkConnectivityBloc,
      act: (bloc) => bloc.add(CheckNetWorkConnectivityEvent()),
      expect: () => [isA<NetworkConnectivityIdle>()],
    );
  });
}
