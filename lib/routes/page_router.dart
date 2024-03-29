import 'package:fintch/gen_export.dart';
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
        return _buildRoute(
            settings,
            SetPasswordPage(
              bundle: args as ArgumentBundle?,
            ));
      case PagePath.setPin:
        return _buildRoute(
            settings,
            SetPinPage(
              bundle: args as ArgumentBundle?,
            ));
      case PagePath.confirmPin:
        return _buildRoute(
            settings, ConfirmPinPage(bundle: args as ArgumentBundle?));
      case PagePath.base:
        return _buildRoute(settings, BasePage());
      case PagePath.receive:
        return _buildRoute(settings, ReceivePage());
      case PagePath.barcodeReceive:
        return _buildRoute(
            settings, BarcodeReceivePage(bundle: args as ArgumentBundle?));
      case PagePath.setting:
        return _buildRoute(settings, SettingPage());
      case PagePath.pay:
        return _buildRoute(settings, PayPage());
      case PagePath.fGoals:
        return _buildRoute(settings, FGoalsPage());
      case PagePath.topUp:
        return _buildRoute(settings, TopUpPage());
      case PagePath.payment:
        return _buildRoute(
            settings, PaymentPage(bundle: args as ArgumentBundle?));
      case PagePath.changePassword:
        return _buildRoute(settings, ChangePasswordPage());
      case PagePath.changePin:
        return _buildRoute(settings, ChangePinPage());
      case PagePath.barcode:
        return _buildRoute(settings, BarcodePage());
      case PagePath.biometric:
        return _buildRoute(settings, BiometricPage());
      // case PagePath.qrCodeFile:
      //   return _buildRoute(
      //       settings,
      //       QrCodeFile(
      //         subtitle1: 'SMK Negeri 1 Majalengka',
      //         data: 'businesscenter',
      //         title: 'Business Center',
      //         subtitle2: 'businesscenter',
      //       ));
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
