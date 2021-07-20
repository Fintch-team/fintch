import 'package:fintch/presentation/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Stack(
        children: [
          _headerContent(context),
          _homeScrollableSheet(),
        ],
      ),
    );
  }

  Widget _headerContent(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.35,
        padding: EdgeInsets.fromLTRB(20, 32, 20, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _userInfo(),
                      SizedBox(height: 16),
                      _levelBar(),
                    ],
                  ),
                ),
                SizedBox(width: Helper.normalPadding),
                _homeIllustration(context),
              ],
            ),
            SizedBox(height: Helper.normalPadding),
            _fintchWallet(),
          ],
        ),
      ),
    );
  }

  Widget _userInfo() {
    return Row(
      children: [
        CircleAvatar(
          radius: 32,
          backgroundImage: NetworkImage(Dummy.profileImg),
        ),
        SizedBox(width: 16),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Halo\nAdithya!', style: AppTheme.headline2.white),
              SizedBox(height: 8),
              Text('Edit Profil >', style: AppTheme.text2.white),
            ],
          ),
        ),
      ],
    );
  }

  Widget _levelBar() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(Resources.icExp),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text('Level 1', style: AppTheme.text3.white),
              ),
              SizedBox(height: 4),
              LinearPercentIndicator(
                percent: 0.3,
                progressColor: AppTheme.white,
                backgroundColor: AppTheme.whiteOpacity,
                animationDuration: 500,
                animation: true,
                lineHeight: 10,
                padding: EdgeInsets.symmetric(horizontal: 12),
                center: Text('34/144', style: AppTheme.subText2.black),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _homeIllustration(BuildContext context) {
    return SvgPicture.asset(
      Resources.homeIllustration,
      width: MediaQuery.of(context).size.width * 0.3,
      fit: BoxFit.fitWidth,
    );
  }

  Widget _fintchWallet() {
    return Expanded(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Text('Isi Fintch Wallet kamu',
                  style: AppTheme.text2.white.light),
            ),
            SizedBox(height: 4),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  Resources.icFintchWallet,
                  height: 32,
                ),
                SizedBox(width: 8),
                Text(
                  '156,000',
                  style: AppTheme.headline1.white,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _homeScrollableSheet() {
    return Positioned.fill(
      child: DraggableScrollableSheet(
        initialChildSize: 0.6,
        minChildSize: 0.6,
        expand: true,
        builder: (BuildContext context, ScrollController scrollController) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              color: AppTheme.scaffold,
            ),
            child: SingleChildScrollView(
              controller: scrollController,
              physics: BouncingScrollPhysics(),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _bottomSheetLine(context),
                  SizedBox(height: Helper.normalPadding),
                  _listFeature(),
                ],
              ),
            ),
          );
        },
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

  Widget _listFeature() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: Helper.normalPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _featureItem(
            name: 'Bayar',
            assetName: Resources.icPay,
          ),
          SizedBox(width: 20),
          _featureItem(
            name: 'Terima',
            assetName: Resources.icReceive,
            isOpacity: true,
          ),
          SizedBox(width: 20),
          _featureItem(
            name: 'Barrier Cash',
            assetName: Resources.icBarrierCash,
          ),
          SizedBox(width: 20),
          _featureItem(
            name: 'Tabungan',
            assetName: Resources.icSaving,
            isOpacity: true,
          ),
        ],
      ),
    );
  }

  Widget _featureItem({
    bool isOpacity: false,
    required String name,
    required String assetName,
  }) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: Container(
              decoration: BoxDecoration(
                color: isOpacity ? AppTheme.purpleOpacity : AppTheme.purple,
                image: DecorationImage(
                  image: AssetImage(Resources.bgPatternPng),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: Helper.getShadow(),
              ),
              padding: EdgeInsets.all(20),
              child: SvgPicture.asset(assetName),
            ),
          ),
          SizedBox(height: 8),
          Text(
            name,
            style: AppTheme.text2.black.bold,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
