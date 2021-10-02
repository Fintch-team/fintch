import 'dart:async';

import 'package:fintch/gen_export.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:loader_overlay/loader_overlay.dart';

class ConfirmPinPage extends StatefulWidget {
  final ArgumentBundle? bundle;

  const ConfirmPinPage({Key? key, this.bundle}) : super(key: key);

  @override
  _ConfirmPinPageState createState() => _ConfirmPinPageState();
}

class _ConfirmPinPageState extends State<ConfirmPinPage> {
  late String setPin = widget.bundle!.extras[Keys.setPin];
  late String username = widget.bundle!.extras['username'];
  late String password = widget.bundle!.extras['password'];
  TextEditingController confirmPinController = TextEditingController();
  StreamController<ErrorAnimationType>? errorController;

  _onKeyboardTap(String value) {
    if (confirmPinController.text.length < 6) {
      confirmPinController.text += value;
    }
  }

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    errorController?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
        child: SafeArea(
          child: BlocListener<PinBloc, AuthState>(
            listener: (context, state) {
              if (state is ChangeSuccess) {
                context.loaderOverlay.hide();
                Helper.snackBar(context, message: 'Ganti Pin Berhasil!');
                Navigator.of(context)
                    .pushNamedAndRemoveUntil(PagePath.base, (route) => false);
              } else if (state is AuthLoading) {
                context.loaderOverlay.show();
                Helper.snackBar(context, message: 'Mengganti Pin...');
              } else if (state is AuthFailure) {
                context.loaderOverlay.hide();
                Helper.snackBar(context,
                    message: 'Ganti Pin gagal', isFailure: true);
              }
            },
            child: Container(
              padding: EdgeInsets.all(Helper.normalPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CustomAppBar(title: ''),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _headerPinCode(),
                        _keypad(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _headerPinCode() {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: Helper.bigPadding),
          Text('Konfirmasi PIN Kamu', style: AppTheme.headline1.white),
          SizedBox(height: Helper.bigPadding),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: CustomPinCode(
              pinController: confirmPinController,
              errorController: errorController,
              onChanged: (value) {},
              onCompleted: (value) {},
            ),
          ),
        ],
      ),
    );
  }

  Widget _keypad() {
    return NumericKeyboard(
        onKeyboardTap: _onKeyboardTap,
        rightButtonFn: () {
          setState(() {
            if (confirmPinController.text.isNotEmpty) {
              confirmPinController.text = confirmPinController.text
                  .substring(0, confirmPinController.text.length - 1);
            }
          });
        },
        rightIcon: Icon(
          Icons.backspace,
          color: Colors.white,
        ),
        leftButtonFn: () {
          if (confirmPinController.text.length < 6) {
            errorController!.add(ErrorAnimationType.shake);
            Helper.snackBar(
              context,
              message: 'PIN harus 6 Digit!',
            );
            return;
          } else if (confirmPinController.text != setPin) {
            confirmPinController.clear();
            errorController!.add(ErrorAnimationType.shake);
            Helper.snackBar(
              context,
              message: 'PIN harus sama dengan sebelumnya!',
            );
            return;
          }
          context.read<PinBloc>().add(ChangePin(
                entity: PostChangePinEntity(
                  nickname: username,
                  password: password,
                  pin: confirmPinController.text,
                ),
              ));
        },
        leftIcon: Icon(
          Icons.check,
          color: Colors.white,
        ),
        mainAxisAlignment: MainAxisAlignment.spaceBetween);
  }
}
