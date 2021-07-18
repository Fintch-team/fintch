import 'package:fintch/presentation/utils/utils.dart';
import 'package:fintch/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

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
                padding: EdgeInsets.all(20),
                height: MediaQuery.of(context).size.height - (MediaQuery.of(context).padding.top + MediaQuery.of(context).padding.bottom) - 40,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _changeLanguage(),
                    SizedBox(height: 32),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Hero(
                            tag: Keys.textLogoHero,
                            child: SvgPicture.asset(
                              Resources.text_logo,
                              width: MediaQuery.of(context).size.width * 0.5,
                            ),
                          ),
                          Container(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('NISN', style: AppTheme.text3.white.bold),
                                SizedBox(height: 8),
                                TextField(
                                  style: AppTheme.text3.white,
                                  decoration: InputDecoration(
                                    hintText: 'NISN Kamu',
                                  ),
                                  keyboardType: TextInputType.number,
                                ),
                                SizedBox(height: 16),
                                Text('Kata Sandi',
                                    style: AppTheme.text3.white.bold),
                                SizedBox(height: 8),
                                TextField(
                                  style: AppTheme.text3.white,
                                  decoration: InputDecoration(
                                    hintText: 'Masukan kata sandi kamu',
                                    suffixIcon: Icon(
                                      Icons.visibility_off,
                                      color: AppTheme.white,
                                    ),
                                  ),
                                  keyboardType: TextInputType.visiblePassword,
                                ),
                                SizedBox(height: 8),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: GestureDetector(
                                    onTap: () {},
                                    child: Text(
                                      'Lupa Kata Sandi?',
                                      style: AppTheme.subText1.white,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 24),
                                CustomButton(
                                  onTap: (){},
                                  text: 'Masuk',
                                ),
                              ],
                            ),
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text.rich(
                                TextSpan(
                                  style: AppTheme.text3.white,
                                  children: [
                                    TextSpan(
                                      text:
                                          'Dengan masuk atau mendaftar, saya setuju dengan ',
                                    ),
                                    TextSpan(
                                      text: 'Syarat & Ketentuan ',
                                      style: AppTheme.text3.yellow,
                                    ),
                                    TextSpan(
                                      text: 'dan ',
                                    ),
                                    TextSpan(
                                      text: 'Kebijakan Privasi',
                                      style: AppTheme.text3.yellow,
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 28),
                              GestureDetector(
                                onTap: () {},
                                child: Text(
                                  'Butuh Bantuan?',
                                  style: AppTheme.subText1.yellow,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _changeLanguage() {
    return Align(
      alignment: Alignment.centerRight,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Bahasa: ', style: AppTheme.text3.white),
          GestureDetector(
            onTap: () {},
            child: Text('EN', style: AppTheme.text3.white),
          ),
          Text(' / ', style: AppTheme.text3.white),
          GestureDetector(
            onTap: () {},
            child: Text('ID', style: AppTheme.text3.whiteOpacity),
          ),
        ],
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final bool isEnable;

  const CustomButton({
    Key? key,
    required this.onTap,
    required this.text,
    this.isEnable: true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: isEnable ? AppTheme.yellow : AppTheme.darkYellow,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 12,
        ),
        child: Center(
          child: Text(
            text.toUpperCase(),
            style: AppTheme.text2.bold,
          ),
        ),
      ),
    );
  }
}
