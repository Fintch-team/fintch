import 'dart:io';

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
        ),
        RepositoryProvider(
          create: (context) => SchoolRepository(
            schoolService: Service.find(),
          ),
        ),
        RepositoryProvider(
          create: (context) => HistoryRepository(
            historyService: Service.find(),
            localAuthService: Service.find(),
          ),
        ),
        RepositoryProvider(
          create: (context) => WalletRepository(
            walletService: Service.find(),
            localAuthService: Service.find(),
          ),
        ),
        RepositoryProvider(
          create: (context) => TransactionRepository(
            transactionService: Service.find(),
            localAuthService: Service.find(),
          ),
        ),
        RepositoryProvider(
          create: (context) => MoneyManageRepository(
            moneyManageService: Service.find(),
          ),
        ),
        RepositoryProvider(
          create: (context) => MoneyManageItemRepository(
            moneyManageItemService: Service.find(),
            localAuthService: Service.find(),
          ),
        ),
        RepositoryProvider(
          create: (context) => MoneyPlanRepository(
            moneyPlanService: Service.find(),
            localAuthService: Service.find(),
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(
              userRepository: context.read<UserRepository>(),
            ),
          ),
          BlocProvider<PinBloc>(
            create: (context) => AuthBloc(
              userRepository: context.read<UserRepository>(),
            ),
          ),
          BlocProvider<PasswordBloc>(
            create: (context) => AuthBloc(
              userRepository: context.read<UserRepository>(),
            ),
          ),
          BlocProvider<HomeBloc>(
            create: (context) => HomeBloc(
              userRepository: context.read<UserRepository>(),
            ),
          ),
          BlocProvider<ReceiveBloc>(
            create: (context) => HomeBloc(
              userRepository: context.read<UserRepository>(),
            ),
          ),
          BlocProvider<HistoryBloc>(
            create: (context) => HistoryBloc(
              userRepository: context.read<UserRepository>(),
              historyRepository: context.read<HistoryRepository>(),
            ),
          ),
          BlocProvider<SettingsBloc>(
            create: (context) => SettingsBloc(
              userRepository: context.read<UserRepository>(),
            ),
          ),
          BlocProvider<MoneyManageBloc>(
            create: (context) => MoneyManageBloc(
              moneyManageRepository: context.read<MoneyManageRepository>(),
            ),
          ),
          BlocProvider<InComeBloc>(
            create: (context) => MoneyManageBloc(
              moneyManageRepository: context.read<MoneyManageRepository>(),
            ),
          ),
          BlocProvider<TabelBloc>(
            create: (context) => MoneyManageBloc(
              moneyManageRepository: context.read<MoneyManageRepository>(),
            ),
          ),
          BlocProvider<MoneyManageItemBloc>(
            create: (context) => MoneyManageItemBloc(
              moneyManageItemRepository:
                  context.read<MoneyManageItemRepository>(),
            ),
          ),
          BlocProvider<MoneyPlanBloc>(
            create: (context) => MoneyPlanBloc(
              moneyPlanRepository: context.read<MoneyPlanRepository>(),
            ),
          ),
          BlocProvider<WalletBloc>(
            create: (context) => WalletBloc(
              walletRepository: context.read<WalletRepository>(),
            ),
          ),
          BlocProvider<PayBloc>(
            create: (context) => PayBloc(
              userRepository: context.read<UserRepository>(),
              transactionRepository: context.read<TransactionRepository>(),
            ),
          ),
          BlocProvider<ProfilePayBloc>(
            create: (context) => ProfilePayBloc(
              userRepository: context.read<UserRepository>(),
              transactionRepository: context.read<TransactionRepository>(),
            ),
          ),
          BlocProvider<MerchantBloc>(
            create: (context) => MerchantBloc(
              userRepository: context.read<UserRepository>(),
            ),
          ),
          BlocProvider<AuthPinBloc>(
            create: (context) => AuthBloc(
              userRepository: context.read<UserRepository>(),
            ),
          ),
        ],
        child: MaterialApp(
          title: 'Fintch',
          theme: ThemeData(
            primarySwatch: Colors.deepPurple,
            fontFamily: !Platform.isIOS ? 'Gotham' : null,
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
