import 'dart:async';

import 'package:fintch/presentation/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class CustomPinCode extends StatelessWidget {
  final TextEditingController pinController;
  final StreamController<ErrorAnimationType>? errorController;
  final FocusNode? focusNode;
  final void Function(String)? onCompleted;
  final void Function(String) onChanged;
  final bool isDialog;
  final bool isObscure;
  final bool isAutoFocus;

  const CustomPinCode({
    Key? key,
    required this.pinController,
    this.errorController,
    this.onCompleted,
    required this.onChanged,
    this.focusNode,
    this.isDialog = false,
    this.isObscure = false,
    this.isAutoFocus = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      appContext: context,
      pastedTextStyle: isObscure ? AppTheme.headline1.purple : AppTheme.headline1,
      length: 6,
      obscureText: isObscure,
      animationType: AnimationType.fade,
      showCursor: false,
      autoFocus: isAutoFocus,
      textStyle: isObscure ? AppTheme.headline1.purple : AppTheme.headline1,
      animationDuration: Duration(milliseconds: 300),
      enableActiveFill: true,
      focusNode: focusNode,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.circle,
        activeColor: isDialog ? AppTheme.purple : AppTheme.yellow,
        activeFillColor: isDialog ? AppTheme.purple : AppTheme.yellow,
        inactiveColor: isDialog ? AppTheme.yellow : AppTheme.whiteOpacity,
        inactiveFillColor: isDialog ? AppTheme.yellow : AppTheme.whiteOpacity,
        selectedFillColor: isDialog ? AppTheme.yellow : AppTheme.whiteOpacity,
        selectedColor: isDialog ? AppTheme.yellow : AppTheme.whiteOpacity,
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
