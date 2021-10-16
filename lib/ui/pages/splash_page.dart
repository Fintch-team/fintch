import 'package:fintch/gen_export.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  static const Duration _navigateDelay = Duration(seconds: 3);

  @override
  void initState() {
    context.read<AuthBloc>().add(GetIsLoggedIn());
    super.initState();
  }

  // void _navigateOtherScreen() {
  //   GetStorage _getStorage = GetStorage();
  //   bool isInitial = _getStorage.read(Keys.isLoggedIn) ?? true;
  //   if (isInitial) {
  //     Future.delayed(_navigateDelay)
  //         .then((_) => Navigator.pushReplacementNamed(context, PagePath.login));
  //   } else {
  //     Future.delayed(_navigateDelay)
  //         .then((_) => Navigator.pushReplacementNamed(context, PagePath.base));
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        print(state);
        if(state is AuthIsLoggedIn){
          print(state.isLoggedIn);
          if(state.isLoggedIn){
            Future.delayed(_navigateDelay)
                .then((_) => Navigator.pushReplacementNamed(context, PagePath.base));
          } else {
            Future.delayed(_navigateDelay)
                .then((_) => Navigator.pushReplacementNamed(context, PagePath.login));
          }
        }
      },
      child: Scaffold(
        body: Background(
          child: Center(
            child: Hero(
              tag: Keys.textLogoHero,
              child: SvgPicture.asset(
                Resources.textLogo,
                fit: BoxFit.fitWidth,
                width: MediaQuery
                    .of(context)
                    .size
                    .width * 0.4,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
