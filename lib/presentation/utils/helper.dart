import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Helper {
  static void unfocus() {
    WidgetsBinding.instance?.focusManager.primaryFocus?.unfocus();
  }

  static double get normalPadding {
    return 20;
  }

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
}