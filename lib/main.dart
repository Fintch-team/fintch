import 'package:fintch/gen_export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'gen_export.dart';
import 'logic/blocs/auth/auth_bloc.dart';

void main() async {
  await initializeGetStorage();

  Bloc.observer = SimpleBlocObserver();
  Helper.setLightAppBar();
  runApp(MyApp());
}

final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

class MyApp extends StatefulWidget {
  late final PageRouter _router;

  MyApp() : _router = PageRouter();

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

    registerServices(services: [
      // Remote Service
      ServiceInjector(create: () => UserService()),
      ServiceInjector(create: () => HistoryService()),
      ServiceInjector(create: () => WalletService()),
      ServiceInjector(create: () => TransactionService()),
      ServiceInjector(create: () => MoneyPlanService()),
      ServiceInjector(create: () => MoneyManageService()),

      // Local Service
      ServiceInjector.value(value: LocalAuthService()),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => UserRepository(
            userService: Service.find(),
            localAuthService: Service.find(),
          ),
        )
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthBloc(
              userRepository: context.read<UserRepository>(),
            ),
          )
        ],
        child: MaterialApp(
          title: 'Fintch',
          theme: ThemeData(
            primarySwatch: Colors.deepPurple,
            scaffoldBackgroundColor: AppTheme.scaffold,
            inputDecorationTheme: InputDecorationTheme(
              enabledBorder: AppTheme.enabledBorder,
              focusedBorder: AppTheme.focusedBorder,
              errorBorder: AppTheme.errorBorder,
              focusedErrorBorder: AppTheme.focusedErrorBorder,
              isDense: true,
              hintStyle: AppTheme.text3.whiteOpacity,
            ),
          ),
          onGenerateRoute: widget._router.getRoute,
          navigatorObservers: [widget._router.routeObserver],
        ),
      ),
    );
  }
}
