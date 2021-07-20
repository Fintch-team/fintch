import 'package:cached_network_image/cached_network_image.dart';
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
                  SizedBox(height: Helper.normalPadding),
                  _articleList(context),
                  _transactionList(),
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


  Widget _articleList(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Helper.normalPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Artikel untukmu', style: AppTheme.headline3),
                SvgPicture.asset(Resources.next, height: 16),
              ],
            ),
          ),
          SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(vertical: Helper.normalPadding),
            child: Row(
              children: List.generate(5, (index) {
                return _articleItem(context, index);
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _articleItem(BuildContext context, int index) {
    return Container(
      height: MediaQuery.of(context).size.width * 0.4,
      decoration: BoxDecoration(
        boxShadow: Helper.getShadow(),
        color: AppTheme.white,
        borderRadius: BorderRadius.circular(20),
      ),
      margin: index == 0
          ? EdgeInsets.only(left: 20, right: 10)
          : index == 5
              ? EdgeInsets.only(left: 10, right: 20)
              : EdgeInsets.symmetric(horizontal: 10),
      child: AspectRatio(
        aspectRatio: 16 / 11,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                child: CachedNetworkImage(
                  imageUrl:
                      "https://img.freepik.com/free-vector/gradient-dynamic-blue-lines-background_23-2148995756.jpg?size=626&ext=jpg",
                  fit: BoxFit.cover,
                  width: double.infinity,
                  fadeInCurve: Curves.easeInCubic,
                  fadeInDuration: Duration(milliseconds: 500),
                  fadeOutCurve: Curves.easeOutCubic,
                  fadeOutDuration: Duration(milliseconds: 500),
                  progressIndicatorBuilder: (context, url, downloadProgress) {
                    return Center(
                      child: CircularProgressIndicator(
                        value: downloadProgress.progress,
                        backgroundColor: AppTheme.purple,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          AppTheme.yellow,
                        ),
                      ),
                    );
                  },
                  errorWidget: (context, url, error) => Container(
                    height: double.infinity,
                    width: double.infinity,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                '5 Tips untuk menabung bagi para siswa',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: AppTheme.text3.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _transactionList() {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Helper.normalPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Transaksi terakhir', style: AppTheme.headline3),
                SvgPicture.asset(Resources.next, height: 16),
              ],
            ),
          ),
          ListView.builder(
            itemCount: 10,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(vertical: 10),
            itemBuilder: (context, index) => TransactionItem(),
          ),
        ],
      ),
    );
  }
}

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: Helper.getShadow(),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '#1234053934',
                  style: AppTheme.subText1.purpleOpacity,
                ),
                SizedBox(height: 8),
                Text(
                  'Dari Adithya untuk PT. Dunia Akhirat',
                  style: AppTheme.text2.black,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 8),
                Text(
                  '15 Jul 2021 16:13',
                  style: AppTheme.subText2.black.bold,
                ),
              ],
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SvgPicture.asset(
                    Resources.icFintchPoint,
                    height: 20,
                  ),
                  SizedBox(width: 4),
                  Text(
                    '-20,000',
                    style: AppTheme.text1.red.bold,
                  ),
                ],
              ),
              SizedBox(height: 4),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    Resources.icFintchWallet,
                    height: 16,
                  ),
                  SizedBox(width: 4),
                  Text(
                    '156,000',
                    style: AppTheme.text2,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
