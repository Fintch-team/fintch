import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
}