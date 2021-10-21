import 'dart:io';

import 'package:fintch/gen_export.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Helper {
  static void unfocus() {
    WidgetsBinding.instance?.focusManager.primaryFocus?.unfocus();
  }

  ///padding 32
  static double get bigPadding {
    return 32;
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

  static void snackBar(BuildContext context,
      {required String message, bool isFailure: false}) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: AppTheme.text1),
        backgroundColor: isFailure ? AppTheme.red : AppTheme.yellow,
        behavior: SnackBarBehavior.floating,
        elevation: 40,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  static Future<DateTime?> showDeadlineDatePicker(
    BuildContext context,
    DateTime datePicked,
  ) async {
    if (Platform.isIOS) {
      DateTime? pickedDate = await showModalBottomSheet<DateTime>(
        context: context,
        builder: (context) {
          DateTime tempPickedDate = DateTime.now();
          return Container(
            height: 250,
            child: Column(
              children: <Widget>[
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      CupertinoButton(
                        child: Text('Cancel'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      CupertinoButton(
                        child: Text('Done'),
                        onPressed: () {
                          Navigator.of(context).pop(tempPickedDate);
                        },
                      ),
                    ],
                  ),
                ),
                Divider(
                  height: 0,
                  thickness: 1,
                ),
                Expanded(
                  child: Container(
                    child: CupertinoDatePicker(
                      mode: CupertinoDatePickerMode.date,
                      initialDateTime: datePicked,
                      onDateTimeChanged: (DateTime dateTime) {
                        tempPickedDate = dateTime;
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
      if (pickedDate != null && pickedDate != datePicked) {
        return pickedDate;
      }
    } else {
      final DateTime? picked = await showCustomDatePicker(
        context: context,
        initialDate: datePicked,
        firstDate: DateTime(2019),
        lastDate: DateTime(2025),
        helpText: 'Pilih tenggat waktu',
        confirmText: 'Pilih',
        cancelText: 'Gajadi',
        builder: (context, child) {
          return Theme(
            data: ThemeData(fontFamily: 'Gotham').copyWith(
              colorScheme: ColorScheme.light().copyWith(
                primary: AppTheme.purple,
              ),
            ), // This will change to light theme.
            child: child!,
          );
        },
      );
      return picked;
    }
  }
}
