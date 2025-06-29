import 'package:clean_architecture_assignment/core/services/network_connectivity/network_connectivity_service.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../test_injection_container.dart';
import 'network_connectivity_service_test.mocks.dart';

@GenerateMocks([Connectivity])
Future<void> main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  initDiTest();
  late NetworkConnectivityService networkConnectivityService;
  late MockConnectivity mockConnectivity;

  setUp(() {
    mockConnectivity = MockConnectivity();
    networkConnectivityService = NetworkConnectivityService(
      connectivity: mockConnectivity,
    );
  });

  group('NetworkConnectivityService', () {
    test('isConnected returns true when connected to network', () async {
      when(
        mockConnectivity.checkConnectivity(),
      ).thenAnswer((_) async => [ConnectivityResult.wifi]); // ✅ Not a List

      final result = await networkConnectivityService.isConnected;
      expect(result, true);
    });

    test('isConnected returns false when not connected', () async {
      when(
        mockConnectivity.checkConnectivity(),
      ).thenAnswer((_) async => [ConnectivityResult.none]);

      final result = await networkConnectivityService.isConnected;
      expect(result, false);
    });

    test('should listen to connectivity changes', () {
      final stream = Stream<List<ConnectivityResult>>.fromIterable([
        [ConnectivityResult.mobile],
        [ConnectivityResult.none],
      ]);

      when(mockConnectivity.onConnectivityChanged).thenAnswer((_) => stream);

      expectLater(
        networkConnectivityService.connectionStream,
        emitsInOrder([
          [ConnectivityResult.mobile],
          [ConnectivityResult.none],
        ]),
      );
    });
  });
}
