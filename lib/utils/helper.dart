import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:fintch/gen_export.dart';


class Helper {
  static void unfocus() {
    WidgetsBinding.instance?.focusManager.primaryFocus?.unfocus();
  }

  ///padding 32
  static double get bigPadding {
    return 20;
  }

  ///padding 20
  static double get normalPadding {
    return 20;
  }

  ///padding 12
  static double get smallPadding {
    return 12;
  }

  static List<BoxShadow> getShadow() {
    return [
      BoxShadow(
        color: Colors.grey.withOpacity(0.2),
        blurRadius: 8,
        offset: Offset(0, 4),
      ),
    ];
  }

  static List<BoxShadow> getShadowBold() {
    return [
      BoxShadow(
        color: Colors.deepPurple.withOpacity(0.8),
        blurRadius: 8,
        offset: Offset(0, 4),
      ),
    ];
  }

  static void setLightAppBar() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
      statusBarColor: Colors.transparent,
    ));
  }

  static void setDarkAppBar() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
      statusBarColor: Colors.transparent,
    ));
  }


  static void snackBar(BuildContext context, {required String message, bool isFailure: false}) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: AppTheme.text1),
        backgroundColor: isFailure ? AppTheme.red : AppTheme.yellow,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

}
