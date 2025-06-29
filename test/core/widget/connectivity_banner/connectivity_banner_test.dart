import 'package:clean_architecture_assignment/core/services/network_connectivity/network_connectivity_service.dart';
import 'package:clean_architecture_assignment/core/widget/connectivity_banner/bloc/network_connectivity_bloc.dart';
import 'package:clean_architecture_assignment/core/widget/connectivity_banner/bloc/network_connectivity_state.dart';
import 'package:clean_architecture_assignment/core/widget/connectivity_banner/connectivity_banner.dart';
import 'package:clean_architecture_assignment/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

final diNetworkTest = GetIt.instance;
@GenerateMocks([NetworkConnectivityBloc])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  diNetworkTest.registerLazySingleton<NetworkConnectivityService>(
    () => NetworkConnectivityService(),
  );
  late NetworkConnectivityBloc mockNetworkConnectivityBloc;

  final networkConnectivityService = diNetworkTest
      .get<NetworkConnectivityService>();
  networkConnectivityService.initialize();

  setUp(() {
    mockNetworkConnectivityBloc = NetworkConnectivityBloc(
      networkConnectivity: networkConnectivityService,
    );
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: BlocProvider<NetworkConnectivityBloc>.value(
        value: mockNetworkConnectivityBloc,
        child: const Scaffold(body: NetworkConnectivityBanner()),
      ),
    );
  }

  group('NetworkConnectivityBanner', () {
    testWidgets('shows disconnected message when network is disconnected', (
      WidgetTester tester,
    ) async {
      when(
        mockNetworkConnectivityBloc.state,
      ).thenReturn(NetworkConnectivityDisconnected());

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      expect(find.text('No Internet Connection'), findsOneWidget);
      expect(find.byType(Container), findsOneWidget);
    });

    testWidgets('shows reconnected message when network is reconnected', (
      WidgetTester tester,
    ) async {
      when(
        mockNetworkConnectivityBloc.state,
      ).thenReturn(NetworkConnectivityReconnected());

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      expect(find.text('Back Online'), findsOneWidget);
      expect(find.byType(Container), findsOneWidget);
    });

    testWidgets('shows nothing in idle state', (WidgetTester tester) async {
      when(
        mockNetworkConnectivityBloc.state,
      ).thenReturn(NetworkConnectivityIdle());

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      expect(find.byType(Container), findsNothing);
    });
  });
}
