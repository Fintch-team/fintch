import 'package:fintch/gen_export.dart';
import 'package:flutter/material.dart';

class CircularLoading extends StatelessWidget {
  const CircularLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      color: AppTheme.darkYellow,
      valueColor: AlwaysStoppedAnimation<Color>(AppTheme.yellow),
      strokeWidth: 6,
    );
  }
}
