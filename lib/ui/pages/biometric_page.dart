import 'package:fintch/gen_export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loader_overlay/loader_overlay.dart';

class BiometricPage extends StatefulWidget {
  const BiometricPage({Key? key}) : super(key: key);

  @override
  _BiometricPageState createState() => _BiometricPageState();
}

class _BiometricPageState extends State<BiometricPage> {
  late TextEditingController usernameController;
  late TextEditingController passwordController;
  bool isObscurePassword = true;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    usernameController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();

    context.read<AuthBiometricBloc>().add(GetBio());
  }

  @override
  void dispose() {
    super.dispose();
    usernameController.dispose();
    passwordController.dispose();
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
                        context.read<AuthBloc>().add(
                              SaveBio(
                                entity: BioUserEntity(
                                  user: usernameController.text.trim(),
                                  pass: passwordController.text,
                                ),
                              ),
                            );
                        // Helper.snackBar(context, message: 'Coba ...');
                        Navigator.pop(context);
                      } else if (state is AuthLoading) {
                        context.loaderOverlay.show();
                      } else if (state is AuthFailure) {
                        context.loaderOverlay.hide();
                        Helper.snackBar(context,
                            message: state.message, isFailure: true);
                      }
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // SizedBox(height: 32),
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

  Widget _loginContent(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _headerLogin(context),
          SizedBox(height: 32),
          _loginTextField(context),
        ],
      ),
    );
  }

  Widget _headerLogin(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: Text('Yuk aktifkan Biometric login !',
                  style: AppTheme.headline1.white),
            ),
            SizedBox(width: Helper.normalPadding),
          ],
        ),
        SizedBox(height: Helper.normalPadding),
        Text(
          'Biometric login untuk Fintch lebih aman dan mudah dengan biometric login!!',
          style: AppTheme.text1.yellow,
        ),
      ],
    );
  }

  Widget _loginTextField(BuildContext context) {
    return BlocBuilder<AuthBiometricBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthBioSuccess) {
          if (state.entity.user.isEmpty) {
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
                      text: 'Aktifkan Biometric',
                    ),
                  ],
                ),
              ),
            );
          }
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomButton(
                onTap: () {
                  Helper.unfocus();
                  context.read<AuthBloc>().add(
                        SaveBio(
                          entity: BioUserEntity(
                            user: usernameController.text.trim(),
                            pass: passwordController.text,
                          ),
                        ),
                      );
                  Navigator.pop(context);
                },
                text: 'Nonatifkan Biometric',
              ),
            ],
          );
        }
        return SizedBox();
      },
    );
  }
}
