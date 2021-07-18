import 'package:fintch/presentation/routes/routes.dart';
import 'package:fintch/presentation/utils/utils.dart';
import 'package:fintch/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_storage/get_storage.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  static const Duration _navigateDelay = Duration(seconds: 3);

  @override
  void initState() {
    _navigateOtherScreen();
    super.initState();
  }

  void _navigateOtherScreen() {
    GetStorage _getStorage = GetStorage();
    bool isInitial = _getStorage.read(Keys.isLoggedIn) ?? true;
    if (isInitial) {
      Future.delayed(_navigateDelay)
          .then((_) => Navigator.pushReplacementNamed(context, PagePath.login));
    } else {
      Future.delayed(_navigateDelay)
          .then((_) => Navigator.pushReplacementNamed(context, PagePath.base));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
        child: Center(
          child: Hero(
            tag: Keys.textLogoHero,
            child: SvgPicture.asset(
              Resources.text_logo,
              fit: BoxFit.fitWidth,
              width: MediaQuery.of(context).size.width * 0.4,
            ),
          ),
        ),
      ),
    );
  }
}
