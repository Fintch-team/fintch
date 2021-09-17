import 'package:fintch/gen_export.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SetPasswordPage extends StatelessWidget {
  const SetPasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Helper.unfocus(),
      child: Scaffold(
        body: Background(
          child: SafeArea(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Container(
                padding: EdgeInsets.all(Helper.normalPadding),
                height: MediaQuery.of(context).size.height -
                    (MediaQuery.of(context).padding.top +
                        MediaQuery.of(context).padding.bottom) -
                    40,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _headerSetPassword(context),
                    _setPasswordTextField(context),
                    _nextButton(context),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _headerSetPassword(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: Text('Yuk atur Kata Sandimu!',
                  style: AppTheme.headline1.white),
            ),
            SizedBox(width: Helper.normalPadding),
            GestureDetector(
              onTap: () => showDialog(
                context: context,
                builder: (context) => _helpDialog(context),
              ),
              child: SvgPicture.asset(Resources.icHelp),
            ),
          ],
        ),
        SizedBox(height: Helper.normalPadding),
        Text(
          'Usahain Kata sandi baru kamu harus beda dari Kata sandi sebelumnya ya!!',
          style: AppTheme.text1.yellow,
        ),
      ],
    );
  }

  Widget _setPasswordTextField(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Kata Sandi Baru', style: AppTheme.text3.white.bold),
          SizedBox(height: 8),
          TextField(
            style: AppTheme.text3.white,
            decoration: InputDecoration(
              hintText: 'Masukin kata sandi baru kamu',
              suffixIcon: Icon(
                Icons.visibility_off,
                color: AppTheme.white,
              ),
              helperText: 'Minimal harus 8 karakter',
              helperStyle: AppTheme.subText1.white,
            ),
            keyboardType: TextInputType.visiblePassword,
          ),
          SizedBox(height: 16),
          Text('Konfirmasi Kata Sandi', style: AppTheme.text3.white.bold),
          SizedBox(height: 8),
          TextField(
            style: AppTheme.text3.white,
            decoration: InputDecoration(
              hintText: 'Masukin kata sandi kamu sebelumnya',
              suffixIcon: Icon(
                Icons.visibility_off,
                color: AppTheme.white,
              ),
            ),
            keyboardType: TextInputType.visiblePassword,
          ),
        ],
      ),
    );
  }

  Widget _nextButton(BuildContext context) {
    return CustomButton(
      onTap: () => Navigator.pushReplacementNamed(context, PagePath.setPin),
      text: 'Lanjut',
    );
  }

  Widget _helpDialog(BuildContext context) {
    return CustomDialog(
      title: 'Kenapa harus ganti Sandi?',
      content: Text('Karena sandi kalian yang sebelumya bukan sandi tetap, jadi kalian harus masukin sandi yang baru.\n\nBiar lebih aman!! >_<', style: AppTheme.text3),
      buttons: CustomButton(
        onTap: () => Navigator.of(context).pop(),
        text: 'Oke Mengerti',
      ),
    );
  }
}
