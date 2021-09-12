import 'dart:async';

import 'package:fintch/presentation/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class CustomPinCode extends StatelessWidget {
  final TextEditingController pinController;
  final StreamController<ErrorAnimationType>? errorController;
  final void Function(String)? onCompleted;
  final void Function(String) onChanged;
  const CustomPinCode({Key? key, required this.pinController, this.errorController, this.onCompleted, required this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      appContext: context,
      pastedTextStyle: AppTheme.headline1,
      length: 6,
      obscureText: false,
      animationType: AnimationType.fade,
      showCursor: false,
      autoFocus: true,
      textStyle: AppTheme.headline1,
      animationDuration: Duration(milliseconds: 300),
      enableActiveFill: true,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.circle,
        activeColor: AppTheme.yellow,
        inactiveColor: AppTheme.whiteOpacity,
        activeFillColor: AppTheme.yellow,
        inactiveFillColor: AppTheme.whiteOpacity,
        selectedFillColor: AppTheme.whiteOpacity,
        selectedColor: AppTheme.whiteOpacity,
      ),
      controller: pinController,
      errorAnimationController: errorController,
      keyboardType: TextInputType.number,
      boxShadows: Helper.getShadow(),
      onCompleted: onCompleted,
      onChanged: onChanged,
    );
  }
}
