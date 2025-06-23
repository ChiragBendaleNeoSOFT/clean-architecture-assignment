import 'package:clean_architecture_assignment/core/blocs/locale_bloc/locale_bloc.dart';
import 'package:clean_architecture_assignment/core/blocs/locale_bloc/locale_state.dart';
import 'package:clean_architecture_assignment/core/services/db_service/database_service.dart';
import 'package:clean_architecture_assignment/core/services/network_connectivity/network_connectivity.dart';
import 'package:clean_architecture_assignment/core/widget/connectivity_banner/bloc/network_connectivity_bloc.dart';
import 'package:clean_architecture_assignment/database/database_schemas/user_database_table_schema.dart';
import 'package:clean_architecture_assignment/features/users/presentation/bloc/user_bloc.dart';
import 'package:clean_architecture_assignment/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';

import 'core/widget/connectivity_banner/connectivity_banner.dart';
import 'features/users/presentation/pages/users_list.dart';
import 'l10n/app_localizations.dart';

final diTest = GetIt.instance;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  initDi();
  DatabaseService.instance.initSchemas([UserDatabaseTableSchema()]);

  final networkConnectivityService = diTest.get<NetworkConnectivityService>();
  networkConnectivityService.initialize();

  runApp(
    BlocProvider(
      create: (BuildContext context) => LocaleBloc(),
      child: BlocProvider(
        create: (BuildContext context) => NetworkConnectivityBloc(
          networkConnectivity: networkConnectivityService,
        ),
        child: BlocBuilder<LocaleBloc, LocaleState>(
          builder: (context, locale) {
            return MyApp();
          },
        ),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocaleBloc, LocaleState>(
      builder: (context, locale) {
        return ScreenUtilInit(
          designSize: const Size(360, 690),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (_, child) {
            return MaterialApp(
              title: 'User List',
              locale: Locale(locale.locale),
              debugShowCheckedModeBanner: false,
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: const [Locale('en'), Locale('hi')],
              builder: (context, child) {
                return Stack(
                  children: [
                    child ?? const SizedBox(),
                    const Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: NetworkConnectivityBanner(),
                    ),
                  ],
                );
              },
              theme: ThemeData(
                useMaterial3: true,
                colorScheme: ColorScheme.fromSeed(
                  seedColor: Colors.deepPurple,
                  brightness: Brightness.light,
                ),
              ),
              home: BlocProvider(
                create: (BuildContext context) => di.get<UserBloc>(),
                child: UsersListScreen(),
              ),
            );
          },
        );
      },
    );
  }
}
