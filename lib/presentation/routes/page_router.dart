import 'package:fintch/presentation/pages/pages.dart';
import 'package:fintch/presentation/routes/routes.dart';
import 'package:flutter/material.dart';


class PageRouter {
  final RouteObserver<PageRoute> routeObserver;

  PageRouter() : routeObserver = RouteObserver<PageRoute>();

  Route<dynamic> getRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case PagePath.splash:
        return _buildRoute(settings, SplashPage());
      case PagePath.login:
        return _buildRoute(settings, LoginPage());
      case PagePath.base:
        return _buildRoute(settings, BasePage());
      case PagePath.receive:
        return _buildRoute(settings, ReceivePage());
      default:
        return _errorRoute();
    }
  }

  MaterialPageRoute _buildRoute(RouteSettings settings, Widget page) {
    return MaterialPageRoute(
      settings: settings,
      builder: (ctx) => page,
    );
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
