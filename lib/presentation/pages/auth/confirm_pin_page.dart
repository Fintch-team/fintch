import 'package:fintch/presentation/routes/routes.dart';
import 'package:fintch/presentation/utils/utils.dart';
import 'package:fintch/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class ConfirmPinPage extends StatefulWidget {
  final ArgumentBundle? bundle;

  const ConfirmPinPage({Key? key, this.bundle}) : super(key: key);

  @override
  _ConfirmPinPageState createState() => _ConfirmPinPageState();
}

class _ConfirmPinPageState extends State<ConfirmPinPage> {
  late String setPin = widget.bundle!.extras[Keys.setPin];
  TextEditingController confirmPinController = TextEditingController();

  _onKeyboardTap(String value) {
    if (confirmPinController.text.length < 6) {
      confirmPinController.text += value;
    }
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
          Text('Konfirmasi PIN Kamu', style: AppTheme.headline1.white),
          SizedBox(height: Helper.bigPadding),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: PinCodeTextField(
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
              controller: confirmPinController,
              keyboardType: TextInputType.number,
              boxShadows: [
                BoxShadow(
                  offset: Offset(0, 1),
                  color: Colors.black12,
                  blurRadius: 10,
                )
              ],
              onCompleted: (v) {
                print("Completed");
              },
              onChanged: (value) {
                print(value);
              },
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
            Helper.snackBar(
              context,
              message: 'PIN harus 6 Digit!',
            );
            return;
          } else if (confirmPinController.text != setPin) {
            Helper.snackBar(
              context,
              message: 'PIN harus sama dengan sebelumnya!',
            );
            return;
          }
          Navigator.of(context).pushNamed(PagePath.base);
        },
        leftIcon: Icon(
          Icons.check,
          color: Colors.white,
        ),
        mainAxisAlignment: MainAxisAlignment.spaceBetween);
  }
}
