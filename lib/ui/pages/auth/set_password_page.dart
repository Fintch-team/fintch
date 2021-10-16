import 'package:fintch/gen_export.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loader_overlay/loader_overlay.dart';

class SetPasswordPage extends StatefulWidget {
  final ArgumentBundle? bundle;

  const SetPasswordPage({Key? key, required this.bundle}) : super(key: key);

  @override
  State<SetPasswordPage> createState() => _SetPasswordPageState();
}

class _SetPasswordPageState extends State<SetPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  bool isPasswordObscure = true;
  bool isPasswordConfirmationObscure = true;
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmationController =
      TextEditingController();
  String username = '';
  String password = '';

  @override
  void initState() {
    if (widget.bundle != null) {
      username = widget.bundle!.extras['username'];
      password = widget.bundle!.extras['password'];
    }
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
              child: BlocListener<PasswordBloc, AuthState>(
                listener: (context, state) {
                  if (state is ChangeSuccess) {
                    context.loaderOverlay.hide();
                    Helper.snackBar(context,
                        message: 'Ganti Password Berhasil!');
                    Navigator.pushReplacementNamed(context, PagePath.setPin,
                        arguments: ArgumentBundle(extras: {
                          'username': username,
                          'password': _passwordConfirmationController.text,
                        }));
                  } else if (state is AuthLoading) {
                    context.loaderOverlay.show();
                    Helper.snackBar(context, message: 'Mengganti Password...');
                  } else if (state is AuthFailure) {
                    context.loaderOverlay.hide();
                    Helper.snackBar(context,
                        message: 'Ganti Password gagal', isFailure: true);
                  }
                },
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
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Kata Sandi Baru', style: AppTheme.text3.white.bold),
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
            SizedBox(height: 16),
            Text('Konfirmasi Kata Sandi', style: AppTheme.text3.white.bold),
            SizedBox(height: 8),
            TextFormField(
              controller: _passwordConfirmationController,
              style: AppTheme.text3.white,
              obscureText: isPasswordConfirmationObscure,
              decoration: InputDecoration(
                hintText: 'Masukin kata sandi kamu sebelumnya',
                errorStyle: AppTheme.text3.red,
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      isPasswordConfirmationObscure =
                          !isPasswordConfirmationObscure;
                    });
                  },
                  child: Icon(
                      isPasswordConfirmationObscure
                          ? CupertinoIcons.eye
                          : CupertinoIcons.eye_slash,
                      color: AppTheme.white),
                ),
              ),
              validator: (value) {
                Validator.notEmpty(value);

                if (_passwordController.text != value) {
                  return 'Password tidak sama dengan sebelumnya!';
                }
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
          context.read<PasswordBloc>().add(ChangePassword(
                entity: PostChangePasswordEntity(
                  nickname: username,
                  password: _passwordConfirmationController.text,
                  passwordOld: password,
                ),
              ));
        }
      },
      text: 'Lanjut',
    );
  }

  Widget _helpDialog(BuildContext context) {
    return CustomDialog(
      title: 'Kenapa harus ganti Sandi?',
      content: Text(
          'Karena sandi kalian yang sebelumya bukan sandi tetap, jadi kalian harus masukin sandi yang baru.\n\nBiar lebih aman!! >_<',
          style: AppTheme.text3),
      buttons: CustomButton(
        onTap: () => Navigator.of(context).pop(),
        text: 'Oke Mengerti',
      ),
    );
  }
}
