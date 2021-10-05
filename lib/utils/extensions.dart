import 'package:flutter/material.dart';
import 'package:fintch/gen_export.dart';
import 'package:intl/intl.dart';
import 'app_theme.dart';

extension StyleText on TextStyle {
  TextStyle get bold => this.copyWith(fontWeight: FontWeight.bold);
  TextStyle get normal => this.copyWith(fontWeight: FontWeight.w500);
  TextStyle get light => this.copyWith(fontWeight: FontWeight.w100);
  TextStyle get scaffold => this.copyWith(color: AppTheme.scaffold);
  TextStyle get purple => this.copyWith(color: AppTheme.purple);
  TextStyle get darkPurple => this.copyWith(color: AppTheme.darkPurple);
  TextStyle get yellow => this.copyWith(color: AppTheme.yellow);
  TextStyle get red => this.copyWith(color: AppTheme.red);
  TextStyle get green => this.copyWith(color: AppTheme.green);
  TextStyle get black => this.copyWith(color: AppTheme.black);
  TextStyle get white => this.copyWith(color: AppTheme.white);
  TextStyle get grey => this.copyWith(color: AppTheme.grey);
  TextStyle get darkYellow => this.copyWith(color: AppTheme.darkYellow);
  TextStyle get blackOpacity => this.copyWith(color: AppTheme.blackOpacity);
  TextStyle get purpleOpacity => this.copyWith(color: AppTheme.purpleOpacity);
  TextStyle get whiteOpacity => this.copyWith(color: AppTheme.whiteOpacity);
  TextStyle get darkPurpleOpacity => this.copyWith(color: AppTheme.darkPurpleOpacity);
}

extension StringInsert on String {
  String parseCurrency() {
    final currency = NumberFormat("#,##0", "id_ID");
    double? currDouble = double.tryParse(this);
    return currDouble != null ? currency.format(currDouble) : '-';
  }
}

extension DateParsing on DateTime {
  String parseDate() {
    return DateFormat(FormatDate.dayDayMonthYear).format(this);
  }

  String parseDateAndMonth() {
    var outputFormat = DateFormat(FormatDate.dayMonth);
    var outputDate = outputFormat.format(this);
    return outputDate;
  }

  String parseHourDateAndMonth() {
    var outputFormat = DateFormat(FormatDate.fullDateTime);
    var outputDate = outputFormat.format(this);
    return outputDate;
  }

  String parseYearMonthDay() {
    var outputFormat = DateFormat(FormatDate.yearMonthDay);
    var outputDate = outputFormat.format(this);
    return outputDate;
  }
}

