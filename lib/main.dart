import 'package:clean_architecture_assignment/core/services/db_service/db_service.dart';
import 'package:clean_architecture_assignment/core/services/network_connectivity/network_connectitvity.dart';
import 'package:clean_architecture_assignment/core/widget/connectivity_banner/bloc/connectivity_bloc.dart';
import 'package:clean_architecture_assignment/db/db_schemas/user_schema.dart';
import 'package:clean_architecture_assignment/features/users/presentation/bloc/user_bloc.dart';
import 'package:clean_architecture_assignment/features/users/presentation/bloc/user_event.dart';
import 'package:clean_architecture_assignment/features/users/presentation/screen/users_list.dart';
import 'package:clean_architecture_assignment/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/widget/connectivity_banner/connectivity_banner.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  initDi();
  DBService.instance.registerSchemas([UserTableSchema()]);

  final networkConnectivityService = di.get<NetworkConnectivityService>();
  networkConnectivityService.initialize();

  runApp(
    BlocProvider(
      create: (BuildContext context) =>
          ConnectivityBloc(networkConnectivity: networkConnectivityService),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp(
          title: 'User List',
          debugShowCheckedModeBanner: false,
          builder: (context, child) {
            return Stack(
              children: [
                child ?? const SizedBox(),
                const Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: ConnectivityBanner(),
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
  }
}
