import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'app_theme.dart';

extension StyleText on TextStyle {
  TextStyle get bold => this.copyWith(fontWeight: FontWeight.bold);
  TextStyle get normal => this.copyWith(fontWeight: FontWeight.w500);
  TextStyle get light => this.copyWith(fontWeight: FontWeight.w100);
  TextStyle get scaffold => this.copyWith(color: AppTheme.scaffold);
  TextStyle get purple => this.copyWith(color: AppTheme.purple);
  TextStyle get yellow => this.copyWith(color: AppTheme.yellow);
  TextStyle get red => this.copyWith(color: AppTheme.red);
  TextStyle get green => this.copyWith(color: AppTheme.green);
  TextStyle get black => this.copyWith(color: AppTheme.black);
  TextStyle get white => this.copyWith(color: AppTheme.white);
  TextStyle get darkYellow => this.copyWith(color: AppTheme.darkYellow);
  TextStyle get purpleOpacity => this.copyWith(color: AppTheme.purpleOpacity);
  TextStyle get whiteOpacity => this.copyWith(color: AppTheme.whiteOpacity);
}

extension StringInsert on String {
  String parseCurrency() {
    final currency = NumberFormat("#,##0", "id_ID");
    double? currDouble = double.tryParse(this);
    return currDouble != null ? currency.format(currDouble) : '-';
  }
}
