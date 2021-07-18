import 'package:flutter/material.dart';

class AppTheme {

  static const Color scaffold = Color(0xFFF4F7FA);
  static const Color purple = Color(0xFFB570F7);
  static const Color yellow = Color(0xFFFFDC00);
  static const Color red = Color(0xFFFF7777);
  static const Color green = Color(0xFFFF7777);
  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);
  static const Color darkYellow = Color(0xFFBDA300);
  static Color purpleOpacity = Color(0xFFB570F7).withOpacity(0.3);
  static Color whiteOpacity = Color(0xFFFFFFFF).withOpacity(0.6);

  static const TextStyle headline1 = TextStyle(
    fontWeight: FontWeight.bold,
    color: black,
    fontSize: 36,
  );

  static const TextStyle headline2 = TextStyle(
    fontWeight: FontWeight.bold,
    color: black,
    fontSize: 24,
  );

  static const TextStyle headline3 = TextStyle(
    fontWeight: FontWeight.bold,
    color: black,
    fontSize: 20,
  );

  static const TextStyle text1 = TextStyle(
    fontWeight: FontWeight.w500,
    color: black,
    fontSize: 16,
  );

  static const TextStyle text2 = TextStyle(
    fontWeight: FontWeight.w500,
    color: black,
    fontSize: 14,
  );

  static const TextStyle text3 = TextStyle(
    fontWeight: FontWeight.w500,
    color: black,
    fontSize: 12,
  );

  static const TextStyle subText1 = TextStyle(
    fontWeight: FontWeight.w500,
    color: black,
    fontSize: 10,
  );

  static const TextStyle subText2 = TextStyle(
    fontWeight: FontWeight.w500,
    color: black,
    fontSize: 8,
  );

  static OutlineInputBorder enabledBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: BorderSide(color: white),
  );

  static OutlineInputBorder focusedBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide:
    BorderSide(color: yellow),
  );

  static OutlineInputBorder errorBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: BorderSide(color: red),
  );

  static OutlineInputBorder focusedErrorBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: BorderSide(color: red),
  );
}