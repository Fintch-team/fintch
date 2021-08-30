import 'package:fintch/presentation/utils/utils.dart';
import 'package:fintch/presentation/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LeaderboardPage extends StatelessWidget {
  const LeaderboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Stack(
        children: [
          _headerContent(context),
          _leaderboardScrollableSheet(),
        ],
      ),
    );
  }

  Widget _headerContent(BuildContext context) {
    return Positioned.fill(
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.38,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _rankItem(
                  context,
                  width: MediaQuery.of(context).size.width * 0.28,
                  paddingTop: MediaQuery.of(context).size.width * 0.1,
                  imgUrl: Dummy.profileImg,
                  name: 'Galuh Najla Fatimah Alfajri',
                  level: 34,
                  color: AppTheme.colorRank2,
                  medalAsset: Resources.icSecond,
                ),
                _rankItem(
                  context,
                  width: MediaQuery.of(context).size.width * 0.36,
                  paddingTop: MediaQuery.of(context).size.width * 0.05,
                  imgUrl: Dummy.profileImg,
                  name: 'Daliun Sastrodijoyo Umar Alfajri',
                  level: 35,
                  color: AppTheme.colorRank1,
                  medalAsset: Resources.icFirst,
                ),
                _rankItem(
                  context,
                  width: MediaQuery.of(context).size.width * 0.28,
                  paddingTop: MediaQuery.of(context).size.width * 0.15,
                  imgUrl: Dummy.profileImg,
                  name: 'Keisha Nareswari Atika Alfajri',
                  level: 33,
                  color: AppTheme.colorRank3,
                  medalAsset: Resources.icThird,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _rankItem(
    BuildContext context, {
    required double width,
    required double paddingTop,
    required String imgUrl,
    required String name,
    required int level,
    required Color color,
    required String medalAsset,
  }) {
    return Container(
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: paddingTop,
          ),
          Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomNetworkImage(
                  imgUrl: imgUrl,
                  borderRadius: 64,
                  width: MediaQuery.of(context).size.width * 0.16,
                  height: MediaQuery.of(context).size.width * 0.16,
                ),
                SizedBox(height: 8),
                Text(
                  name,
                  style: AppTheme.text3.bold.white,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(Resources.icExp),
                    SizedBox(width: 4),
                    Text(
                      'Level $level',
                      style: AppTheme.text3.white,
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 8),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              padding: EdgeInsets.all(Helper.normalPadding),
              child: Center(
                child: SvgPicture.asset(
                  medalAsset,
                  height: 56,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _leaderboardScrollableSheet() {
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
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              controller: scrollController,
              physics: BouncingScrollPhysics(),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _bottomSheetLine(context),
                  SizedBox(height: Helper.normalPadding),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(
                      20,
                      (index) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: _topUserItem(
                          position: index + 4,
                          name: 'Alora Tribuana Aisyah Alfajri',
                          nisn: '192470129312',
                          level: 20,
                          startExp: 300,
                          endExp: 400,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _topUserItem({
    String? medalAsset,
    int? position,
    required String name,
    required String nisn,
    required int level,
    required int startExp,
    required endExp,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 1,
          child: Container(
            child: medalAsset != null
                ? SvgPicture.asset(
                    medalAsset,
                    width: 28,
                  )
                : position != null
                    ? Container(
                        child: Center(
                          child: Text(
                            position.toString(),
                            style: AppTheme.headline3,
                          ),
                        ),
                      )
                    : Container(),
          ),
        ),
        SizedBox(width: 8),
        Expanded(
          flex: 6,
          child: Text(
            name,
            style: AppTheme.text2.bold,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        SizedBox(height: 8),
        Expanded(
          flex: 3,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SvgPicture.asset(Resources.icExp),
              SizedBox(width: 4),
              Text(
                'Level $level',
                style: AppTheme.text3,
              ),
            ],
          ),
        ),
      ],
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
