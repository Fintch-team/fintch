import 'package:auto_size_text/auto_size_text.dart';
import 'package:fintch/gen_export.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:percent_indicator/percent_indicator.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int isPayHistory = 0;

  @override
  void initState() {
    _initHome();
    super.initState();
  }

  void _initHome() {
    context.read<HomeBloc>().add(HomeInit());
  }

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      child: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state is HomeLoading) {
            context.loaderOverlay.show();
          } else if (state is HomeFailure) {
            context.loaderOverlay.hide();
            Helper.snackBar(context, message: state.message, isFailure: true);
          } else if (state is HomeSuccess) {
            context.loaderOverlay.hide();
          }
        },
        builder: (context, state) {
          if (state is HomeSuccess) {
            return Container(
              color: Colors.transparent,
              child: Stack(
                children: [
                  _headerContent(context, state.entity),
                  _homeScrollableSheet(state.entity),
                ],
              ),
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _headerContent(BuildContext context, UserEntity user) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.24,
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(
                  Icons.notifications_rounded,
                  color: AppTheme.white,
                ),
                SizedBox(width: Helper.smallPadding),
                GestureDetector(
                  onTap: () => Navigator.pushNamed(context, PagePath.profile)
                      .then((value) => Helper.setLightAppBar()),
                  child: Icon(
                    Icons.settings_rounded,
                    color: AppTheme.white,
                  ),
                ),
              ],
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () =>
                          Navigator.pushNamed(context, PagePath.profile),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _userInfo(context, user),
                          SizedBox(height: Helper.normalPadding),
                          _fintchWallet(user),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: Helper.normalPadding),
                  _homeIllustration(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _userInfo(BuildContext context, UserEntity user) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(64),
            boxShadow: Helper.getShadow(),
          ),
          child: CustomNetworkImage(
            imgUrl: user != null ? user.img : Dummy.profileImg,
            borderRadius: 64,
            width: MediaQuery.of(context).size.width * 0.16,
            height: MediaQuery.of(context).size.width * 0.16,
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AutoSizeText(
                user != null ? 'Halo\n${user.name}!' : ' ',
                style: AppTheme.headline1.white,
                maxLines: 3,
                minFontSize: 20,
                overflow: TextOverflow.visible,
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

  Widget _fintchWallet(UserEntity user) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        AutoSizeText(
          'Isi Fintch Point kamu',
          style: AppTheme.text2.white,
          minFontSize: 12,
        ),
        SizedBox(height: 4),
        Row(
          children: [
            SvgPicture.asset(
              Resources.icFintchWallet,
              height: 32,
            ),
            SizedBox(width: 8),
            Expanded(
              child: AutoSizeText(
                user != null
                    ? user.wallet.walletAmount.toString().parseCurrency()
                    : '0',
                maxLines: 1,
                style: AppTheme.headline1.white,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _homeScrollableSheet(UserEntity user) {
    return Positioned.fill(
      child: DraggableScrollableSheet(
        initialChildSize: 0.68,
        minChildSize: 0.68,
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
                  _listFeature(context),
                  SizedBox(height: Helper.normalPadding),
                  _fGoalList(context, user),
                  _transactionList(user),
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

  Widget _listFeature(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: Helper.normalPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FeatureItem(
            name: 'Top-up',
            assetName: Resources.icTopUp,
            onTap: () => Navigator.pushNamed(context, PagePath.topUp),
            isOpacity: true,
          ),
          SizedBox(width: 20),
          FeatureItem(
            name: 'Pay',
            assetName: Resources.icPay,
            onTap: () => Navigator.pushNamed(context, PagePath.pay),
          ),
          SizedBox(width: 20),
          FeatureItem(
            name: 'Receive',
            assetName: Resources.icReceive,
            onTap: () => Navigator.pushNamed(context, PagePath.receive),
            isOpacity: true,
          ),
          SizedBox(width: 20),
          FeatureItem(
            name: 'Barrier Cash',
            assetName: Resources.icBarrierCash,
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _fGoalList(BuildContext context, UserEntity user) {

    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Helper.normalPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('F-Goals Mendekati', style: AppTheme.headline3),
                SvgPicture.asset(Resources.next, height: 16),
              ],
            ),
          ),
          if (user.moneyPlanning.isNotEmpty)
            Container(
              height: MediaQuery.of(context).size.width * 0.48,
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: user.moneyPlanning.length,
                padding: EdgeInsets.symmetric(vertical: Helper.normalPadding),
                itemBuilder: (BuildContext context, int index) {
                  return _fGoalItem(context, index, user.moneyPlanning[index]);
                },
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.width * 0.48,
            child: state is HomeSuccess
                ? state.entity.moneyPlanning.isNotEmpty
                    ? ListView.builder(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: state.entity.moneyPlanning.length,
                        padding: EdgeInsets.symmetric(
                            vertical: Helper.normalPadding),
                        itemBuilder: (BuildContext context, int index) {
                          return _fGoalItem(context, index,
                              state.entity.moneyPlanning[index]);
                        },
                      )
                    : Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                              'F-Goals Kosong! \nTambah F-Goals',
                              style: AppTheme.text1.bold,
                            ),
                          SizedBox(width: Helper.normalPadding),
                          FeatureItem(
                            name: 'F-Goals',
                            assetName: Resources.icFGoals,
                            onTap: () {
                              Navigator.pushNamed(context, PagePath.fGoals);
                            },
                            showTitle: false,
                            isExpand: false,
                            size: MediaQuery.of(context).size.width * 0.18,
                          ),
                        ],
                      ),
                    )
                : state is HomeLoading
                    ? Center(
                        child: CircularLoading(),
                      )
                    : Container(),
          ),
        ],
      ),
    );
  }

  Widget _fGoalItem(BuildContext context, int index, MoneyPlanData data) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: Helper.getShadow(),
        color: AppTheme.white,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: EdgeInsets.all(20),
      margin: index == 0
          ? EdgeInsets.only(left: 20, right: 10)
          : index == 4
              ? EdgeInsets.only(left: 10, right: 20)
              : EdgeInsets.symmetric(horizontal: 10),
      width: MediaQuery.of(context).size.width * 0.8,
      child: AspectRatio(
        aspectRatio: 15 / 6,
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      AutoSizeText(
                        data.name,
                        style: AppTheme.headline2,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        minFontSize: 16,
                      ),
                      SizedBox(height: 4),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset(Resources.icTime, height: 12),
                          SizedBox(width: 4),
                          AutoSizeText(
                            data.deadline!.parseHourDateAndMonth(),
                            style: AppTheme.subText1,
                            maxLines: 1,
                            maxFontSize: 10,
                            minFontSize: 8,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ],
                  ),
                  AutoSizeText(
                    'Rp. ${data.totalAmount.toString().parseCurrency()}',
                    style: AppTheme.text1.bold,
                    maxLines: 1,
                  ),
                ],
              ),
            ),
            SizedBox(width: Helper.smallPadding),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircularPercentIndicator(
                  radius: MediaQuery.of(context).size.width * 0.2,
                  lineWidth: 16.0,
                  animation: true,
                  percent: data.percent / 100,
                  center: Text("${data.percent}%",
                      style: AppTheme.text2.darkPurple.bold),
                  circularStrokeCap: CircularStrokeCap.round,
                  progressColor: AppTheme.purple,
                  backgroundColor: AppTheme.purpleOpacity,
                ),
                AutoSizeText(
                  'Rp. ${data.amount.toString().parseCurrency()}',

                  style: AppTheme.text3.green,
                  maxLines: 1,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _transactionList(UserEntity user) {

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
          SizedBox(height: Helper.normalPadding),
          HistoryTab(
            isPay: isPayHistory == 0 ? true : false,
            payCallback: () {
              setState(() {
                isPayHistory = 0;
              });
            },
            receiveCallback: () {
              setState(() {
                isPayHistory = 1;
              });
            },
          ),
          SizedBox(height: Helper.smallPadding),
          IndexedStack(
            index: isPayHistory,
            children: [
              if (user.pay.isNotEmpty)
                ListView.builder(
                  itemCount: user.pay.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(vertical: 10),
                  itemBuilder: (context, index) {
                    return TransactionItem(
                      item: user.pay[index],
                      isPay: true,
                    );
                    // return SizedBox();
                  },
                ),
              if (user.receive.isNotEmpty)
                ListView.builder(
                  itemCount: user.receive.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(vertical: 10),
                  itemBuilder: (context, index) {
                    return TransactionItem(
                      item: user.receive[index],
                      isPay: false,
                    );

                    // return SizedBox();
                  },
                ),
            ],
          ),
        ],
      ),
    );
  }
}
