import 'dart:async';

import 'package:fintch/gen_export.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/src/overlay_controller_widget_extension.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/src/provider.dart';

class ChangePinPage extends StatefulWidget {
  const ChangePinPage({
    Key? key,
  }) : super(key: key);

  @override
  _ChangePinPageState createState() => _ChangePinPageState();
}

class _ChangePinPageState extends State<ChangePinPage> {
  late TextEditingController _setPinController;
  StreamController<ErrorAnimationType>? errorController;
  final _formKey = GlobalKey<FormState>();
  bool isPasswordObscure = true;
  late TextEditingController _passwordController;
  late TextEditingController _usernameController;
  bool isPinPage = false;

  _onKeyboardTap(String value) {
    if (_setPinController.text.length < 6) {
      _setPinController.text += value;
    }
  }

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    _setPinController = TextEditingController();
    _passwordController = TextEditingController();
    _usernameController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    errorController?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      child: Scaffold(
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
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _headerPinCode(),
                    _keypad(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _setPasswordTextField(BuildContext context) {
    return Container(
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Masukan Kata Sandi ', style: AppTheme.text3.white.bold),
            SizedBox(height: 8),
            TextFormField(
              controller: _passwordController,
              style: AppTheme.text3.white,
              obscureText: isPasswordObscure,
              decoration: InputDecoration(
                hintText: 'Masukin kata sandi baru kamu',
                errorStyle: AppTheme.text3.red,
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      isPasswordObscure = !isPasswordObscure;
                    });
                  },
                  child: Icon(
                      isPasswordObscure
                          ? CupertinoIcons.eye
                          : CupertinoIcons.eye_slash,
                      color: AppTheme.white),
                ),
                helperText: 'Minimal harus 8 karakter',
                helperStyle: AppTheme.subText1.white,
              ),
              // TODO: penggunaan validator

              validator: (value) {
                // validator untuk required
                Validator.notEmpty(value);
                // validator untuk password 8 character
                Validator.password(value);
                return null;
              },
              keyboardType: TextInputType.visiblePassword,
            ),
          ],
        ),
      ),
    );
  }

  Widget _nextButton(BuildContext context) {
    return CustomButton(
      onTap: () {
        if (_formKey.currentState!.validate()) {
          setState(() {
            isPinPage = true;
          });
        }
      },
      text: 'Lanjut',
    );
  }

  Widget _headerPinCode() {
    return Expanded(
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Masukan Kata Sandi ', style: AppTheme.text3.white.bold),
            SizedBox(height: 8),
            TextFormField(
              controller: _passwordController,
              style: AppTheme.text3.white,
              obscureText: isPasswordObscure,
              decoration: InputDecoration(
                hintText: 'Masukin kata sandi baru kamu',
                errorStyle: AppTheme.text3.red,
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      isPasswordObscure = !isPasswordObscure;
                    });
                  },
                  child: Icon(
                      isPasswordObscure
                          ? CupertinoIcons.eye
                          : CupertinoIcons.eye_slash,
                      color: AppTheme.white),
                ),
                helperText: 'Minimal harus 8 karakter',
                helperStyle: AppTheme.subText1.white,
              ),
              // TODO: penggunaan validator

              validator: (value) {
                // validator untuk required
                Validator.notEmpty(value);
                // validator untuk password 8 character
                Validator.password(value);
                return null;
              },
              keyboardType: TextInputType.visiblePassword,
            ),
            SizedBox(height: Helper.bigPadding),
            Text('Atur PIN Kamu', style: AppTheme.headline1.white),
            SizedBox(height: Helper.bigPadding),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: CustomPinCode(
                pinController: _setPinController,
                errorController: errorController,
                onChanged: (value) {},
                onCompleted: (value) {},
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _keypad() {
    return NumericKeyboard(
        onKeyboardTap: _onKeyboardTap,
        rightButtonFn: () {
          setState(() {
            if (_setPinController.text.isNotEmpty) {
              _setPinController.text = _setPinController.text
                  .substring(0, _setPinController.text.length - 1);
            }
          });
        },
        rightIcon: Icon(
          Icons.backspace,
          color: Colors.white,
        ),
        leftButtonFn: () {
          if (_setPinController.text.length < 6) {
            errorController!.add(ErrorAnimationType.shake);
            Helper.snackBar(
              context,
              message: 'PIN harus 6 Digit!',
            );
            return;
          }
          context.read<PinBloc>().add(ChangePin(
                entity: PostChangePinEntity(
                  nickname: _usernameController.text,
                  password: _passwordController.text,
                  pin: _setPinController.text,
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
