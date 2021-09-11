import 'package:fintch/data/exceptions/api_exception.dart';
import 'package:fintch/logic/blocs/blocs.dart';
import 'package:fintch/presentation/routes/routes.dart';
import 'package:fintch/presentation/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logging/logging.dart';


void main() async {
  await GetStorage.init();
  Bloc.observer = SimpleBlocObserver();
  Helper.setLightAppBar();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  late final PageRouter _router;

  MyApp() : _router = PageRouter() {
    initLogger();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      onGenerateRoute: _router.getRoute,
      navigatorObservers: [_router.routeObserver],
    );
  }

  void initLogger() {
    Logger.root.level = Level.ALL;
    Logger.root.onRecord.listen((record) {
      dynamic e = record.error;
      String m = e is APIException ? e.message : e.toString();
      print(
          '${record.loggerName}: ${record.level.name}: ${record.message} ${m != 'null' ? m : ''}');
    });
    Logger.root.info("Logger initialized.");
  }
}
