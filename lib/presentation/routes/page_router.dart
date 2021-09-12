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
      case PagePath.setPassword:
        return _buildRoute(settings, SetPasswordPage());
      case PagePath.setPin:
        return _buildRoute(settings, SetPinPage());
      case PagePath.confirmPin:
        return _buildRoute(
            settings, ConfirmPinPage(bundle: args as ArgumentBundle?));
      case PagePath.base:
        return _buildRoute(settings, BasePage());
      case PagePath.receive:
        return _buildRoute(settings, ReceivePage());
      case PagePath.profile:
        return _buildRoute(settings, ProfilePage());
      case PagePath.pay:
        return _buildRoute(settings, PayPage());
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
