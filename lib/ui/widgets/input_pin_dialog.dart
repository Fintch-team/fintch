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
  TextEditingController inputPinController = TextEditingController();
  StreamController<ErrorAnimationType>? errorController;
  FocusNode inputFocusNode = FocusNode();

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
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
        child: BlocListener<PayBloc, PayState>(
          listener: (context, state) {
            if (state is PayTransctionSuccess) {
              context.loaderOverlay.hide();
              if (state.entity.amount.isNotEmpty) {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) => SuccessPaymentDialog(
                      fintchPoint: state.entity.amount.parseCurrency(),
                      fintchWallet: state.entity.pay.walletAmount
                          .toString()
                          .parseCurrency()),
                );
              } else {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) => FailedPaymentDialog(
                      message: 'Pembayaran belum berhasil!'),
                );
              }
            } else if (state is PayLoading) {
              context.loaderOverlay.show();
            } else if (state is PayFailure) {
              context.loaderOverlay.hide();
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) =>
                    FailedPaymentDialog(message: state.message),
              );
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
      ),
    );
  }
}
