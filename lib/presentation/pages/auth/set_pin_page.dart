import 'package:fintch/presentation/routes/routes.dart';
import 'package:fintch/presentation/utils/utils.dart';
import 'package:fintch/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class SetPinPage extends StatefulWidget {
  const SetPinPage({Key? key}) : super(key: key);

  @override
  _SetPinPageState createState() => _SetPinPageState();
}

class _SetPinPageState extends State<SetPinPage> {
  TextEditingController textEditingController = TextEditingController();

  _onKeyboardTap(String value) {
    textEditingController.text += value;
  }

  snackBar(String? message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message!, style: AppTheme.text1),
        backgroundColor: AppTheme.yellow,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
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
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 30),
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
                controller: textEditingController,
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
              )),
        ],
      ),
    );
  }

  Widget _keypad() {
    return NumericKeyboard(
        onKeyboardTap: _onKeyboardTap,
        rightButtonFn: () {
          setState(() {
            if (textEditingController.text.isNotEmpty) {
              textEditingController.text = textEditingController.text
                  .substring(0, textEditingController.text.length - 1);
            }
          });
        },
        rightIcon: Icon(
          Icons.backspace,
          color: Colors.white,
        ),
        leftButtonFn: () {
          if (textEditingController.text.length < 6) {
            snackBar('PIN harus 6 Digit!');
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
