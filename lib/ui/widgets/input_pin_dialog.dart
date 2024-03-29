import 'dart:async';

import 'package:fintch/gen_export.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class InputPinDialog extends StatefulWidget {
  final Function whenSuccess;

  const InputPinDialog({Key? key, required this.whenSuccess}) : super(key: key);

  @override
  _InputPinDialogState createState() => _InputPinDialogState();
}

class _InputPinDialogState extends State<InputPinDialog> {
  late TextEditingController inputPinController;
  StreamController<ErrorAnimationType>? errorController;
  FocusNode inputFocusNode = FocusNode();

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    inputPinController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    errorController?.close();
    inputPinController.dispose();
    inputFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      child: BlocListener<AuthPinBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthPinFetched) {
            context.loaderOverlay.hide();
            if (state.isCorrect) {
              Navigator.pop(context);
              widget.whenSuccess.call();
            } else {
              inputPinController.clear();
              inputFocusNode.requestFocus();
              errorController!.add(ErrorAnimationType.shake);
            }
          } else if (state is AuthFailure) {
            context.loaderOverlay.hide();
            inputPinController.clear();
            inputFocusNode.requestFocus();
            errorController!.add(ErrorAnimationType.shake);
          } else if (state is AuthLoading) {
            context.loaderOverlay.show();
          }
        },
        child: CustomDialog(
          title: 'Masukin PIN Kamu',
          content: CustomPinCode(
            pinController: inputPinController,
            errorController: errorController,
            focusNode: inputFocusNode,
            isDialog: true,
            isObscure: true,
            isAutoFocus: true,
            onChanged: (value) {},
            onCompleted: (value) {
              if (inputPinController.text.length < 6) {
                errorController!.add(ErrorAnimationType.shake);
                inputFocusNode.requestFocus();
                Helper.snackBar(
                  context,
                  message: 'PIN harus 6 Digit!',
                );
                return;
              }
              context.read<AuthPinBloc>().add(AuthPin(
                  entity: AuthPinPostEntity(pin: inputPinController.text)));
            },
          ),
        ),
      ),
    );
  }
}
