import 'package:flutter/material.dart';

class AppTheme {

  static const Color scaffold = Color(0xFFF4F7FA);
  static const Color purple = Color(0xFFB570F7);
  static const Color yellow = Color(0xFFFFDC00);
  static const Color red = Color(0xFFEC6E6E);
  static const Color green = Color(0xFF66CC7C);
  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);
  static const Color darkYellow = Color(0xFFBDA300);
  static const Color colorRank1 = Color(0xFFFFD94F);
  static const Color colorRank2 = Color(0xFFFBFBFB);
  static const Color colorRank3 = Color(0xFFFFB957);
  static const Color grey = Color(0xFFE3E3E3);
  static Color blackOpacity = black.withOpacity(0.6);
  static Color purpleOpacity = purple.withOpacity(0.3);
  static Color whiteOpacity = white.withOpacity(0.6);
  static Color darkPurple = Color(0xFF9024A1);
  static Color darkPurpleOpacity = Color(0xFF9024A1).withOpacity(0.5);

  ///font size: 30, color: black, fontWeight: bold
  static const TextStyle headline1 = TextStyle(
    fontWeight: FontWeight.bold,
    color: black,
    fontSize: 30,
  );

  ///font size: 24, color: black, fontWeight: bold
  static const TextStyle headline2 = TextStyle(
    fontWeight: FontWeight.bold,
    color: black,
    fontSize: 24,
  );

  ///font size: 20, color: black, fontWeight: bold
  static const TextStyle headline3 = TextStyle(
    fontWeight: FontWeight.bold,
    color: black,
    fontSize: 20,
  );

  ///font size: 16, color: black, fontWeight: normal
  static const TextStyle text1 = TextStyle(
    fontWeight: FontWeight.w500,
    color: black,
    fontSize: 16,
  );

  ///font size: 14, color: black, fontWeight: normal
  static const TextStyle text2 = TextStyle(
    fontWeight: FontWeight.w500,
    color: black,
    fontSize: 14,
  );

  ///font size: 12, color: black, fontWeight: normal
  static const TextStyle text3 = TextStyle(
    fontWeight: FontWeight.w500,
    color: black,
    fontSize: 12,
  );

  ///font size: 10, color: black, fontWeight: normal
  static const TextStyle subText1 = TextStyle(
    fontWeight: FontWeight.w500,
    color: black,
    fontSize: 10,
  );

  ///font size: 8, color: black, fontWeight: normal
  static const TextStyle subText2 = TextStyle(
    fontWeight: FontWeight.w500,
    color: black,
    fontSize: 8,
  );

  static OutlineInputBorder enabledBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: BorderSide(color: white),
  );

  static OutlineInputBorder focusedBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide:
    BorderSide(color: yellow),
  );

  static OutlineInputBorder errorBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: BorderSide(color: red),
  );

  static OutlineInputBorder focusedErrorBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: BorderSide(color: red),
  );
}
