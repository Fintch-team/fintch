import 'package:fintch/presentation/utils/utils.dart';
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
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.35,
        padding: EdgeInsets.fromLTRB(20, 32, 20, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Fintch\nLeaderboard',
                        style: AppTheme.headline1.white,
                      ),
                      SizedBox(height: 8),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SvgPicture.asset(Resources.icSchool),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'SMK Negeri 1 Majalengka',
                              style: AppTheme.text3.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(width: Helper.normalPadding),
                _homeIllustration(context),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _homeIllustration(BuildContext context) {
    return SvgPicture.asset(
      Resources.homeIllustration,
      width: MediaQuery.of(context).size.width * 0.3,
      fit: BoxFit.fitWidth,
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
                  _topUserItem(
                    medalAsset: Resources.icFirst,
                    name: 'Adithya Firmansyah Putra',
                    nisn: '912038123213',
                    level: 35,
                    startExp: 300,
                    endExp: 400,
                  ),
                  SizedBox(height: 8),
                  _topUserItem(
                    medalAsset: Resources.icSecond,
                    name: 'Gema Akbar',
                    nisn: '21948021812',
                    level: 32,
                    startExp: 300,
                    endExp: 400,
                  ),
                  SizedBox(height: 8),
                  _topUserItem(
                    medalAsset: Resources.icThird,
                    name: 'Putri Shafa Nurani',
                    nisn: '02142193812',
                    level: 31,
                    startExp: 300,
                    endExp: 400,
                  ),
                  SizedBox(height: 12),
                  Container(
                    alignment: Alignment.topCenter,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: AppTheme.purpleOpacity,
                    ),
                    margin: EdgeInsets.only(top: Helper.smallPadding),
                    height: 4,
                  ),
                  SizedBox(height: 12),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(
                      20,
                      (index) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: _topUserItem(
                          position: index + 4,
                          name: 'Anjayani Nurani',
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
                ? SvgPicture.asset(medalAsset, width: 28,)
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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: AppTheme.text2.bold,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 8),
              Text(
                nisn,
                style: AppTheme.text3.purple,
              ),
            ],
          ),
        ),
        SizedBox(height: 8),
        Expanded(
          flex: 3,
          child: Row(
            children: [
              SvgPicture.asset(Resources.icExp),
              SizedBox(width: 4),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Level $level',
                    style: AppTheme.text3,
                  ),
                  SizedBox(height: 4),
                  Text(
                    '$startExp/$endExp EXP',
                    style: AppTheme.subText1.purpleOpacity,
                  ),
                ],
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
