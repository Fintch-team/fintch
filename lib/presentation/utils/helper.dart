import 'package:flutter/cupertino.dart';

class Helper {
  static void unfocus() {
    WidgetsBinding.instance?.focusManager.primaryFocus?.unfocus();
  }

  static double get normalPadding {
    return 20;
  }
}