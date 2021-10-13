import 'package:auto_size_text/auto_size_text.dart';
import 'package:fintch/gen_export.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:percent_indicator/percent_indicator.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isPayHistory = true;

  @override
  void initState() {
    _initHome();
    super.initState();
  }

  Future<void> _onRefresh() async {
    _initHome();
  }

  void _initHome() {
    context.read<HomeBloc>().add(HomeInit());
  }

  void payCallback() {
    setState(() {
      isPayHistory = true;
    });
  }

  void receiveCallback() {
    setState(() {
      isPayHistory = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state is HomeSuccess) {}
        if (state is HomeFailure) {
          Helper.snackBar(context, message: state.message, isFailure: true);
        }
      },
      builder: (context, state) {
        return LiquidPullToRefresh(
          color: AppTheme.darkPurpleOpacity,
          backgroundColor: AppTheme.yellow,
          showChildOpacityTransition: false,
          onRefresh: _onRefresh,
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Container(
              height: MediaQuery.of(context).size.height -
                  MediaQuery.of(context).padding.top -
                  52,
              color: Colors.transparent,
              child: Column(
                children: [
                  SizedBox(height: Helper.normalPadding),
                  Expanded(
                    child: Stack(
                      children: [
                        _headerContent(context, state),
                        _homeScrollableSheet(state),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _headerContent(BuildContext context, HomeState state) {
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
                    child: _headerLeft(state),
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

  Widget _headerLeft(HomeState state) {
    if (state is HomeSuccess) {
      return GestureDetector(
        onTap: () => Navigator.pushNamed(context, PagePath.profile),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _userInfo(context, user: state.entity),
            SizedBox(height: Helper.normalPadding),
            _fintchWallet(user: state.entity),
          ],
        ),
      );
    } else if (state is HomeLoading) {
      return Center(
        child: CircularLoading(),
      );
    } else if (state is HomeFailure) {
      return Center(
        child: Text(
          'Data gagal di load',
          style: AppTheme.headline3.white,
          textAlign: TextAlign.center,
        ),
      );
    }
    return Container();
  }

  Widget _userInfo(BuildContext context, {UserEntity? user}) {
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

  Widget _fintchWallet({UserEntity? user}) {
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

  //TODO: Refactor DraggableScrollableSheet
  Widget _homeScrollableSheet(HomeState state) {
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
                  _fGoals(context, state),
                  _transactionList(state),
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
            onTap: () {
              showCupertinoModalBottomSheet(
                expand: false,
                context: context,
                enableDrag: true,
                isDismissible: true,
                topRadius: Radius.circular(20),
                backgroundColor: AppTheme.white,
                barrierColor: AppTheme.black.withOpacity(0.2),
                builder: (context) => BarrierCashSheet(),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _fGoals(BuildContext context, HomeState state) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Helper.normalPadding),
            child: GestureDetector(
              onTap: () => Navigator.pushNamed(context, PagePath.fGoals),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('F-Goals Mendekati', style: AppTheme.headline3),
                  SvgPicture.asset(Resources.next, height: 16),
                ],
              ),
            ),
          ),
          Container(
              height: MediaQuery.of(context).size.width * 0.48,
              child: _fGoalList(state)),
        ],
      ),
    );
  }

  Widget _fGoalList(HomeState state) {
    if (state is HomeSuccess) {
      if (state.entity.moneyPlanning.isNotEmpty) {
        return ListView.builder(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: state.entity.moneyPlanning.length < 5
              ? state.entity.moneyPlanning.length
              : 5,
          padding: EdgeInsets.symmetric(vertical: Helper.normalPadding),
          itemBuilder: (BuildContext context, int index) {
            return _fGoalItem(
                context, index, state.entity.moneyPlanning[index]);
          },
        );
      } else {
        return Center(
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
        );
      }
    } else if (state is HomeLoading) {
      return Center(
        child: CircularLoading(),
      );
    } else if (state is HomeFailure) {
      return Center(
        child: Text(
          'Data gagal di load',
          style: AppTheme.headline3.white,
          textAlign: TextAlign.center,
        ),
      );
    }
    return Container();
  }

  Widget _fGoalItem(BuildContext context, int index, MoneyPlanData data) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, PagePath.fGoals),
      child: Container(
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
        child: AspectRatio(
          aspectRatio: 15 / 7,
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
                              data.deadline!
                                  .parseHourDateAndMonth()
                                  .substring(0, 17),
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
                      'Rp. ' + data.totalAmount.toString().parseCurrency(),
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
                    center: Text("${data.percent} %",
                        style: AppTheme.text2.darkPurple.bold),
                    circularStrokeCap: CircularStrokeCap.round,
                    progressColor: AppTheme.purple,
                    backgroundColor: AppTheme.purpleOpacity,
                  ),
                  // SizedBox(height: Helper.smallPadding),
                  AutoSizeText(
                    'Rp. ' + data.amount.toString().parseCurrency(),
                    style: AppTheme.text3.green,
                    maxLines: 1,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _transactionList(HomeState state) {
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
            isPay: isPayHistory,
            payCallback: payCallback,
            receiveCallback: receiveCallback,
          ),
          SizedBox(height: Helper.smallPadding),
          _historyList(state)
        ],
      ),
    );
  }

  Widget _historyList(HomeState state) {
    if (state is HomeSuccess) {
      if (isPayHistory) {
        if (state.entity.pay.isNotEmpty) {
          return ListView.builder(
            itemCount: state.entity.pay.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(vertical: 10),
            itemBuilder: (context, index) {
              return TransactionItem(
                item: state.entity.pay[index],
                isPay: isPayHistory,
              );
              // return SizedBox();
            },
          );
        } else {
          return Text(
            'History Pay Kosong!',
            style: AppTheme.text1.bold,
          );
        }
      } else {
        if (state.entity.receive.isNotEmpty) {
          return ListView.builder(
            itemCount: state.entity.receive.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(vertical: 10),
            itemBuilder: (context, index) {
              return TransactionItem(
                item: state.entity.receive[index],
                isPay: isPayHistory,
              );
            },
          );
        } else {
          return Text(
            'History Receive Kosong!',
            style: AppTheme.text1.bold,
          );
        }
      }
    } else if (state is HomeLoading) {
      return Container(
        height: MediaQuery.of(context).size.width * 0.48,
        child: Center(
          child: CircularLoading(),
        ),
      );
    } else if (state is HomeFailure) {
      return Center(
        child: Text(
          'Data gagal di load',
          style: AppTheme.headline3.white,
          textAlign: TextAlign.center,
        ),
      );
    }
    return Container();
  }
}
