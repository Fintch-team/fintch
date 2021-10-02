import 'dart:async';

import 'package:fintch/gen_export.dart';

import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class SetPinPage extends StatefulWidget {
  final ArgumentBundle? bundle;
  const SetPinPage({Key? key, required this.bundle}) : super(key: key);

  @override
  _SetPinPageState createState() => _SetPinPageState();
}

class _SetPinPageState extends State<SetPinPage> {
  TextEditingController setPinController = TextEditingController();
  StreamController<ErrorAnimationType>? errorController;
  String username = '';
  String password = '';

  _onKeyboardTap(String value) {
    if (setPinController.text.length < 6) {
      setPinController.text += value;
    }
  }

  @override
  void initState() {
    if(widget.bundle != null){
      username = widget.bundle!.extras['username'];
      password = widget.bundle!.extras['password'];
    }
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
    );
  }

  Widget _headerPinCode() {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: Helper.bigPadding),
          Text('Atur PIN Kamu', style: AppTheme.headline1.white),
          SizedBox(height: Helper.bigPadding),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: CustomPinCode(
              pinController: setPinController,
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
            if (setPinController.text.isNotEmpty) {
              setPinController.text = setPinController.text
                  .substring(0, setPinController.text.length - 1);
            }
          });
        },
        rightIcon: Icon(
          Icons.backspace,
          color: Colors.white,
        ),
        leftButtonFn: () {
          if (setPinController.text.length < 6) {
            errorController!.add(ErrorAnimationType.shake);
            Helper.snackBar(
              context,
              message: 'PIN harus 6 Digit!',
            );
            return;
          }
          Navigator.of(context).pushNamed(
            PagePath.confirmPin,
            arguments: ArgumentBundle(
              extras: {
                Keys.setPin: setPinController.text,
                'username': username,
                'password': password,
              },
            ),
          );
        },
        leftIcon: Icon(
          Icons.check,
          color: Colors.white,
        ),
        mainAxisAlignment: MainAxisAlignment.spaceBetween);
  }
}
