import 'package:fintch/gen_export.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({
    Key? key,
  }) : super(key: key);

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _formKey = GlobalKey<FormState>();
  bool isPasswordObscure = true;
  bool isPasswordOldObscure = true;
  bool isPasswordConfirmationObscure = true;
  late TextEditingController _usernameController;
  late TextEditingController _passwordOldController;
  late TextEditingController _passwordController;
  late TextEditingController _passwordConfirmationController;

  @override
  void initState() {
    _usernameController = TextEditingController();
    _passwordOldController = TextEditingController();
    _passwordController = TextEditingController();
    _passwordConfirmationController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _passwordOldController.dispose();
    _passwordConfirmationController.dispose();
    super.dispose();
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
                    Navigator.pop(context);
                  } else if (state is AuthLoading) {
                    context.loaderOverlay.show();
                    Helper.snackBar(context, message: 'Mengganti Password...');
                  } else if (state is AuthFailure) {
                    context.loaderOverlay.hide();
                    Helper.snackBar(context,
                        message: 'Ganti Password gagal: ${state.message}',
                        isFailure: true);
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
                        CustomAppBar(title: ''),
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
        Text('Yuk atur Kata Sandimu!', style: AppTheme.headline1.white),
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
            Text('Kata Sandi Lama', style: AppTheme.text3.white.bold),
            SizedBox(height: 8),
            TextFormField(
              controller: _passwordOldController,
              style: AppTheme.text3.white,
              obscureText: isPasswordOldObscure,
              decoration: InputDecoration(
                hintText: 'Masukin kata sandi kamu yang lama',
                errorStyle: AppTheme.text3.red,
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      isPasswordOldObscure = !isPasswordOldObscure;
                    });
                  },
                  child: Icon(
                      isPasswordOldObscure
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
                  nickname: _usernameController.text,
                  password: _passwordConfirmationController.text,
                  passwordOld: _passwordOldController.text,
                ),
              ));
        }
      },
      text: 'Simpan',
    );
  }
}
