import 'package:fintch/presentation/routes/routes.dart';
import 'package:fintch/presentation/utils/utils.dart';
import 'package:fintch/presentation/widgets/widgets.dart';
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
            SvgPicture.asset(Resources.icHelp),
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

  Widget _nextButton(BuildContext context){
    return CustomButton(
      onTap: () => Navigator.pushReplacementNamed(context, PagePath.base),
      text: 'Lanjut',
    );
  }
}
