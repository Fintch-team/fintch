import 'package:fintch/gen_export.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final bool isEnable;
  final bool isOutline;
  final bool isUpper;
  final bool isLoading;

  const CustomButton({
    Key? key,
    required this.onTap,
    required this.text,
    this.isEnable: true,
    this.isOutline: false,
    this.isUpper: true,
    this.isLoading: false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: isOutline
              ? Colors.transparent
              : isEnable
                  ? AppTheme.yellow
                  : AppTheme.darkYellow,
          border:
              isOutline ? Border.all(color: AppTheme.black, width: 1) : null,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 12,
        ),
        child: Center(
          child: isLoading
              ? SizedBox(
                  child: Theme(
                    data: Theme.of(context).copyWith(
                        accentColor:
                            isOutline ? AppTheme.black : AppTheme.purple),
                    child: CircularProgressIndicator(
                      color: isOutline ? AppTheme.black : AppTheme.purple,
                    ),
                  ),
                  height: 20.0,
                  width: 20.0,
                )
              : Text(
                  isUpper ? text.toUpperCase() : text,
                  style: AppTheme.text2.bold,
                ),
        ),
      ),
    );
  }
}
