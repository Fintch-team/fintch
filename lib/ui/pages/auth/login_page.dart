import 'package:fintch/gen_export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loader_overlay/loader_overlay.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController usernameController;
  late TextEditingController passwordController;
  bool isObscurePassword = true;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    usernameController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      child: GestureDetector(
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
                  child: BlocListener<AuthBloc, AuthState>(
                    listener: (context, state) {
                      if (state is AuthSuccess) {
                        context.loaderOverlay.hide();
                        Helper.snackBar(context, message: 'Masuk berhasil!');
                        print(
                            "${state.entity.isSetPin} ${state.entity.isSetPass}");
                        if (!state.entity.isSetPass) {
                          Navigator.pushReplacementNamed(
                              context, PagePath.setPassword,
                              arguments: ArgumentBundle(extras: {
                                'username': usernameController.text,
                                'password': passwordController.text
                              }));
                        } else if (!state.entity.isSetPin) {
                          Navigator.pushReplacementNamed(
                              context, PagePath.setPin,
                              arguments: ArgumentBundle(extras: {
                                'username': usernameController.text,
                                'password': passwordController.text,
                              }));
                        } else {
                          Navigator.pushNamedAndRemoveUntil(
                              context, PagePath.base, (route) => false);
                        }
                      } else if (state is AuthLoading) {
                        context.loaderOverlay.show();
                        Helper.snackBar(context, message: 'Coba masuk...');
                      } else if (state is AuthFailure) {
                        context.loaderOverlay.hide();
                        Helper.snackBar(context,
                            message: state.message, isFailure: true);
                      }
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _changeLanguage(),
                        SizedBox(height: 32),
                        _loginContent(context),
                      ],
                    ),
                  ),
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

  Widget _loginContent(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _fintchLogo(context),
          _loginTextField(context),
          _termConditionHelp(),
        ],
      ),
    );
  }

  Widget _fintchLogo(BuildContext context) {
    return Hero(
      tag: Keys.textLogoHero,
      child: SvgPicture.asset(
        Resources.textLogo,
        width: MediaQuery.of(context).size.width * 0.5,
      ),
    );
  }

  Widget _loginTextField(BuildContext context) {
    return Container(
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // TODO: penggunaan validator
            Text('Username', style: AppTheme.text3.white.bold),
            SizedBox(height: 8),
            TextFormField(
              controller: usernameController,
              style: AppTheme.text3.white,
              decoration: InputDecoration(
                hintText: 'Username kamu',
              ),
              validator: Validator.notEmpty,
            ),
            SizedBox(height: 16),
            Text('Kata Sandi', style: AppTheme.text3.white.bold),
            SizedBox(height: 8),
            StatefulBuilder(builder: (context, passwordSetState) {
              return TextFormField(
                controller: passwordController,
                style: AppTheme.text3.white,
                obscureText: isObscurePassword,
                decoration: InputDecoration(
                  hintText: 'Masukin kata sandi kamu',
                  suffixIcon: GestureDetector(
                    onTap: () => passwordSetState(() {
                      isObscurePassword = !isObscurePassword;
                    }),
                    child: Icon(
                      isObscurePassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: AppTheme.white,
                    ),
                  ),
                ),
                keyboardType: TextInputType.visiblePassword,
                validator: Validator.password,
              );
            }),
            SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () => {},
                child: Text(
                  'Lupa Kata Sandi?',
                  style: AppTheme.subText1.white,
                ),
              ),
            ),
            SizedBox(height: 24),
            CustomButton(
              onTap: () {
                Helper.unfocus();
                if (_formKey.currentState!.validate()) {
                  context.read<AuthBloc>().add(
                        PostAuth(
                          entity: AuthPostEntity(
                            nickname: usernameController.text.trim(),
                            password: passwordController.text,
                          ),
                        ),
                      );
                }
              },
              text: 'Masuk',
            ),
          ],
        ),
      ),
    );
  }

  Widget _termConditionHelp() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text.rich(
          TextSpan(
            style: AppTheme.text3.white,
            children: [
              TextSpan(
                text: 'Dengan masuk atau mendaftar, saya setuju dengan ',
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
    );
  }
}
