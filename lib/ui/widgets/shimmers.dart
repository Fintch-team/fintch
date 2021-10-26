import 'package:auto_size_text/auto_size_text.dart';
import 'package:fintch/gen_export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shimmer/shimmer.dart';

class Shimmers extends StatelessWidget {
  final Widget child;

  const Shimmers({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      child: child,
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
    );
  }
}

class HistoryItemShimmer extends StatelessWidget {
  const HistoryItemShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 7,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(vertical: 10),
      itemBuilder: (context, index) {
        return Shimmers(
          child: Container(
            padding: EdgeInsets.all(20),
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            decoration: BoxDecoration(
              color: AppTheme.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: Helper.getShadow(),
            ),
            height: MediaQuery.of(context).size.height * 0.12,
          ),
        );
      },
    );
  }
}

class FGoalItemShimmer extends StatelessWidget {
  const FGoalItemShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      itemCount: 5,
      padding: EdgeInsets.symmetric(vertical: Helper.normalPadding),
      itemBuilder: (BuildContext context, int index) {
        return Shimmers(
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
              child: Container(),
            ),
          ),
        );
      },
    );
  }
}

class FGoalPageItemShimmer extends StatelessWidget {
  const FGoalPageItemShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 5,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(vertical: 0),
      itemBuilder: (BuildContext context, int index) {
        return Shimmers(
          child: Container(
            decoration: BoxDecoration(
              boxShadow: Helper.getShadow(),
              color: AppTheme.white,
              borderRadius: BorderRadius.circular(20),
            ),
            padding: EdgeInsets.all(20),
            margin: EdgeInsets.symmetric(vertical: 10),
            width: MediaQuery.of(context).size.width,
            child: AspectRatio(
              aspectRatio: 17 / 6,
              child: Container(),
            ),
          ),
        );
      },
    );
  }
}

class HomeHeaderShimmer extends StatelessWidget {
  const HomeHeaderShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmers(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(64),
                  boxShadow: Helper.getShadow(),
                  color: AppTheme.grey,
                ),
                width: MediaQuery.of(context).size.width * 0.16,
                height: MediaQuery.of(context).size.width * 0.16,
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: AppTheme.grey,
                      ),
                      height: 20,
                      width: 60,
                    ),
                    SizedBox(height: Helper.normalPadding),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: AppTheme.grey,
                      ),
                      height: 20,
                      width: 80,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: Helper.normalPadding),
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
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: AppTheme.grey,
                  ),
                  height: 20,
                  width: 80,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class FWalletHeaderShimmer extends StatelessWidget {
  const FWalletHeaderShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmers(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: AppTheme.grey,
            ),
            height: 20,
            width: 80,
          ),
          SizedBox(height: Helper.normalPadding),
          Container(
            height: MediaQuery.of(context).size.height * 0.24,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color: AppTheme.whiteOpacity,
            ),
            padding: EdgeInsets.fromLTRB(12, 32, 0, 12),
          ),
        ],
      ),
    );
  }
}

class IncomeOutcomeShimmer extends StatelessWidget {
  const IncomeOutcomeShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Helper.smallPadding),
      margin: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: Helper.getShadow(),
        color: AppTheme.white,
      ),
      child: Row(
        children: [
          Expanded(
            child: Shimmers(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FittedBox(
                    child: Icon(
                      Icons.trending_up_rounded,
                      size: 28,
                      color: AppTheme.green,
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: AppTheme.grey,
                          ),
                          height: 20,
                          width: 40,
                        ),
                        SizedBox(height: 4),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: AppTheme.grey,
                          ),
                          height: 20,
                          width: 80,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 12),
          Container(
            width: 4,
            height: 36,
            decoration: BoxDecoration(
              color: AppTheme.purple,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Shimmers(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FittedBox(
                    child: Icon(
                      Icons.trending_up_rounded,
                      size: 28,
                      color: AppTheme.green,
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: AppTheme.grey,
                          ),
                          height: 20,
                          width: 40,
                        ),
                        SizedBox(height: 4),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: AppTheme.grey,
                          ),
                          height: 20,
                          width: 80,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CardsShimmer extends StatelessWidget {
  const CardsShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.width * 0.28,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        padding: EdgeInsets.symmetric(vertical: Helper.normalPadding),
        itemBuilder: (BuildContext context, int index) {
          return Shimmers(
            child: Container(
              decoration: BoxDecoration(
                boxShadow: Helper.getShadow(),
                color: AppTheme.white,
                borderRadius: BorderRadius.circular(20),
              ),
              padding: EdgeInsets.all(12),
              margin: index == 0
                  ? EdgeInsets.only(left: 20, right: 10)
                  : index == 4
                      ? EdgeInsets.only(left: 10, right: 20)
                      : EdgeInsets.symmetric(horizontal: 10),
              height: MediaQuery.of(context).size.width * 0.2,
              width: MediaQuery.of(context).size.width * 0.4,
            ),
          );
        },
      ),
    );
  }
}

class ActivitiesShimmer extends StatelessWidget {
  const ActivitiesShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 5,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(vertical: 0),
      itemBuilder: (BuildContext context, int index) {
        return Shimmers(
          child: Container(
            padding: EdgeInsets.all(20),
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            decoration: BoxDecoration(
              color: AppTheme.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: Helper.getShadow(),
            ),
            height: MediaQuery.of(context).size.height * 0.12,
          ),
        );
      },
    );
  }
}

class ProfileShimmer extends StatelessWidget {
  const ProfileShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmers(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(64),
              boxShadow: Helper.getShadow(),
              color: AppTheme.grey,
            ),
            width: MediaQuery.of(context).size.width * 0.3,
            height: MediaQuery.of(context).size.width * 0.3,
          ),
          SizedBox(height: Helper.normalPadding),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: AppTheme.grey,
            ),
            height: 20,
            width: 60,
          ),
          SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: AppTheme.grey,
            ),
            height: 12,
            width: 40,
          ),
          SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: AppTheme.grey,
            ),
            height: 12,
            width: 40,
          ),
        ],
      ),
    );
  }
}

class ProfileWalletShimmer extends StatelessWidget {
  const ProfileWalletShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmers(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.36,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              Resources.icFintchWallet,
              height: 28,
            ),
            SizedBox(width: 8),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: AppTheme.grey,
              ),
              height: 20,
              width: 60,
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileBalanceShimmer extends StatelessWidget {
  const ProfileBalanceShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmers(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.36,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              Resources.fWalletPurple,
              height: 28,
            ),
            SizedBox(width: 8),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: AppTheme.grey,
              ),
              height: 20,
              width: 60,
            ),
          ],
        ),
      ),
    );
  }
}

class MerchantsShimmer extends StatelessWidget {
  const MerchantsShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmers(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(
          6,
          (index) => Container(
            padding: EdgeInsets.all(16),
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            decoration: BoxDecoration(
              color: AppTheme.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: Helper.getShadow(),
            ),
            height: MediaQuery.of(context).size.height * 0.12,
          ),
        ),
      ),
    );
  }
}

class PayWalletShimmer extends StatelessWidget {
  const PayWalletShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmers(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.all(16),
            margin: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: AppTheme.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: Helper.getShadow(),
            ),
            height: MediaQuery.of(context).size.height * 0.12,
          ),
          SizedBox(height: Helper.smallPadding),
          Container(
            padding: EdgeInsets.all(16),
            margin: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: AppTheme.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: Helper.getShadow(),
            ),
            height: MediaQuery.of(context).size.height * 0.12,
          ),
        ],
      ),
    );
  }
}

class BarrierCashShimmer extends StatelessWidget {
  const BarrierCashShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmers(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: AppTheme.grey,
            ),
            height: 20,
            width: 80,
          ),
          SizedBox(height: Helper.bigPadding),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: AppTheme.grey,
            ),
            height: 20,
            width: 40,
          ),
          SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: AppTheme.grey,
            ),
            height: 40,
            width: MediaQuery.of(context).size.width,
          ),
          SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: AppTheme.grey,
            ),
            height: 20,
            width: 60,
          ),
          SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: AppTheme.grey,
            ),
            height: 40,
            width: MediaQuery.of(context).size.width,
          ),
          SizedBox(height: Helper.bigPadding),
          SizedBox(height: Helper.bigPadding),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: AppTheme.grey,
            ),
            height: 40,
            width: MediaQuery.of(context).size.width,
          ),
          SizedBox(height: MediaQuery.of(context).padding.bottom),
        ],
      ),
    );
  }
}

class ReceiveSheetShimmer extends StatelessWidget {
  const ReceiveSheetShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmers(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(64),
              boxShadow: Helper.getShadow(),
              color: AppTheme.grey,
            ),
            width: MediaQuery.of(context).size.width * 0.3,
            height: MediaQuery.of(context).size.width * 0.3,
          ),
          SizedBox(height: Helper.normalPadding),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: AppTheme.grey,
            ),
            height: 20,
            width: 60,
          ),
          SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: AppTheme.grey,
            ),
            height: 12,
            width: 40,
          ),
          SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: AppTheme.grey,
            ),
            height: 12,
            width: 40,
          ),
          SizedBox(height: Helper.bigPadding),
          SizedBox(height: Helper.normalPadding),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: AppTheme.grey,
            ),
            height: 20,
            width: 60,
          ),
          SizedBox(height: Helper.normalPadding),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(64),
              color: AppTheme.grey,
            ),
            height: 40,
            width: MediaQuery.of(context).size.width,
          ),
          SizedBox(height: Helper.normalPadding),
          SizedBox(height: Helper.normalPadding),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: AppTheme.grey,
            ),
            height: 20,
            width: 60,
          ),
          SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: AppTheme.grey,
            ),
            height: 40,
            width: MediaQuery.of(context).size.width,
          ),
          SizedBox(height: Helper.bigPadding),
          SizedBox(height: Helper.bigPadding),
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: AppTheme.grey,
                ),
                height: 20,
                width: 40,
              ),
              SizedBox(width: Helper.normalPadding),
              Expanded(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SvgPicture.asset(
                      Resources.icFintchPoint,
                    ),
                    SizedBox(width: 8),
                    Flexible(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: AppTheme.grey,
                        ),
                        height: 20,
                        width: 60,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: Helper.normalPadding),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: AppTheme.grey,
            ),
            height: 40,
            width: MediaQuery.of(context).size.width,
          ),
          SizedBox(height: Helper.normalPadding),
        ],
      ),
    );
  }
}

class ReceiveShimmer extends StatelessWidget {
  const ReceiveShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              boxShadow: Helper.getShadowPurpleBold(),
              borderRadius: BorderRadius.circular(32),
              color: AppTheme.scaffold,
            ),
            padding: EdgeInsets.all(20),
            child: Shimmers(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.width * 0.12,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: AppTheme.grey,
                    ),
                    height: 20,
                    width: 60,
                  ),
                  SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: AppTheme.grey,
                    ),
                    height: 12,
                    width: 40,
                  ),
                  SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: AppTheme.grey,
                    ),
                    height: 12,
                    width: 40,
                  ),
                  SizedBox(height: Helper.normalPadding),
                  Expanded(
                    child: Center(
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: AppTheme.grey,
                          ),
                          height: MediaQuery.of(context).size.height * 0.3,
                          width: 40,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: -MediaQuery.of(context).size.width * 0.12,
          child: Shimmers(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(64),
                color: AppTheme.grey,
              ),
              width: MediaQuery.of(context).size.width * 0.24,
              height: MediaQuery.of(context).size.width * 0.24,
            ),
          ),
        ),
      ],
    );
  }
}
