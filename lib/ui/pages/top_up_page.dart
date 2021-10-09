import 'package:fintch/gen_export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TopUpPage extends StatelessWidget {
  const TopUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Helper.setDarkAppBar();
    return Scaffold(
      body: Background(
        isWhite: true,
        child: SafeArea(
          bottom: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: Helper.normalPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomAppBar(
                      title: 'Top Up',
                      isBlack: true,
                    ),
                    SizedBox(height: Helper.smallPadding),
                    _headerTopUp(context),
                  ],
                ),
              ),
              Expanded(child: _bodyTopUp(context)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _headerTopUp(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            'Disini kamu bisa langsung pilih berapa nominal yang kalian butuhkan untuk Top Up Fintch Point',
            style: AppTheme.text1,
          ),
        ),
        SizedBox(width: Helper.normalPadding),
        SvgPicture.asset(
          Resources.topUpIllustration,
          width: MediaQuery.of(context).size.width * 0.3,
        ),
      ],
    );
  }

  Widget _bodyTopUp(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        color: AppTheme.white,
      ),
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _bottomSheetLine(context),
            SizedBox(height: Helper.normalPadding),
          ],
        ),
      ),
    );
  }

  Widget _bottomSheetLine(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppTheme.purpleOpacity,
      ),
      margin: EdgeInsets.only(top: Helper.smallPadding),
      width: MediaQuery.of(context).size.width * 0.15,
      height: 4,
    );
  }
}
