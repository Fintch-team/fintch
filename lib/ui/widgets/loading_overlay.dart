import 'package:fintch/gen_export.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';

class LoadingOverlay extends StatelessWidget {
  final Widget child;

  const LoadingOverlay({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      useDefaultLoading: false,
      overlayColor: AppTheme.black.withOpacity(0.5),
      overlayWidget: Center(
        child: CircularProgressIndicator(
          color: AppTheme.darkYellow,
          valueColor: AlwaysStoppedAnimation<Color>(AppTheme.yellow),
          strokeWidth: 6,
        ),
      ),
      child: child,
    );
  }
}
