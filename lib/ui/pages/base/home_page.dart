import 'package:fintch/gen_export.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loader_overlay/loader_overlay.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    _initHome();
  }

  void _initHome() async {
    context.read<HomeBloc>().add(GetUser());
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
                  _headerContent(context, user: state.entity),
                  _homeScrollableSheet(user: state.entity),
                ],
              ),
            );
          }
          return Container(
            color: Colors.transparent,
            child: Stack(
              children: [
                _headerContent(context),
                _homeScrollableSheet(),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _headerContent(BuildContext context, {UserEntity? user}) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.24,
        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(
                  Icons.payments_rounded,
                  color: AppTheme.white,
                ),
                SizedBox(width: Helper.smallPadding),
                Icon(
                  Icons.notifications_rounded,
                  color: AppTheme.white,
                ),
                SizedBox(width: Helper.smallPadding),
                GestureDetector(
                  onTap: () => Navigator.pushNamed(context, PagePath.profile),
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
                      onTap: () => Navigator.pushNamed(context, PagePath.profile),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _userInfo(context, user: user),
                          SizedBox(height: Helper.normalPadding),
                          _fintchWallet(user: user),
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
            width: MediaQuery.of(context).size.width * 0.2,
            height: MediaQuery.of(context).size.width * 0.2,
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user != null ? 'Halo\n${user.name}!' : ' ',
                style: AppTheme.headline1.white,
                maxLines: 3,
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
        Text('Isi Fintch Point kamu', style: AppTheme.text2.white),
        SizedBox(height: 4),
        Row(
          children: [
            SvgPicture.asset(
              Resources.icFintchWallet,
              height: 32,
            ),
            SizedBox(width: 8),
            Text(
              user != null
                  ? user.wallet.walletAmount.toString().parseCurrency()
                  : '0',
              style: AppTheme.headline1.white,
            ),
          ],
        ),
      ],
    );
  }

  Widget _homeScrollableSheet({UserEntity? user}) {
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
                  _articleList(context),
                  _transactionList(user: user),
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
          SizedBox(width: 20),
          FeatureItem(
            name: 'F-Goals',
            assetName: Resources.icFGoals,
            onTap: () {},
            isOpacity: true,
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
          : index == 4
              ? EdgeInsets.only(left: 10, right: 20)
              : EdgeInsets.symmetric(horizontal: 10),
      child: AspectRatio(
        aspectRatio: 16 / 11,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: CustomNetworkImage(
                imgUrl: Dummy.articleImg,
                borderRadius: 20,
                width: double.infinity,
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

  Widget _transactionList({UserEntity? user}) {
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
            itemCount: user != null ? user.pay.length : 0,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(vertical: 10),
            itemBuilder: (context, index) => TransactionItem(
              item: user!.pay[index],
            ),
          ),
        ],
      ),
    );
  }
}
