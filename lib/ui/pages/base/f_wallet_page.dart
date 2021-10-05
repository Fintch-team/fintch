import 'package:fintch/gen_export.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fl_chart/fl_chart.dart';

class _LineChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LineChart(
      sampleData1,
      swapAnimationDuration: const Duration(milliseconds: 250),
      swapAnimationCurve: Curves.easeInOut,
    );
  }

  LineChartData get sampleData1 => LineChartData(
        lineTouchData: lineTouchData1,
        gridData: gridData,
        titlesData: titlesData1,
        borderData: borderData,
        lineBarsData: lineBarsData1,
        minX: 0,
        maxX: 8,
        maxY: 20,
        minY: 0,
      );

  LineTouchData get lineTouchData1 => LineTouchData(
        handleBuiltInTouches: true,
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: AppTheme.white,
          tooltipRoundedRadius: 16,
        ),
      );

  FlTitlesData get titlesData1 => FlTitlesData(
        bottomTitles: bottomTitles,
        rightTitles: SideTitles(showTitles: false),
        topTitles: SideTitles(showTitles: false),
        leftTitles: leftTitles(
          getTitles: (value) {
            switch (value.toInt()) {
              case 5:
                return '5';
              case 10:
                return '10';
              case 15:
                return '15';
              case 20:
                return '20';
            }
            return '';
          },
        ),
      );

  List<LineChartBarData> get lineBarsData1 => [
        lineChartBarData1_1,
        lineChartBarData1_2,
      ];

  SideTitles leftTitles({required GetTitleFunction getTitles}) => SideTitles(
        getTitles: getTitles,
        showTitles: true,
        margin: 0,
        getTextStyles: (context, value) => AppTheme.text1.darkPurple.bold,
      );

  SideTitles get bottomTitles => SideTitles(
        showTitles: true,
        interval: 1,
        margin: 8,
        getTextStyles: (context, value) {
          if (value == DateTime.now().toLocal().weekday) {
            return AppTheme.text1.bold;
          }
          return AppTheme.text1.darkPurple.bold;
        },
        getTitles: (value) {
          switch (value.toInt()) {
            case 1:
              return 'M';
            case 2:
              return 'T';
            case 3:
              return 'W';
            case 4:
              return 'T';
            case 5:
              return 'F';
            case 6:
              return 'S';
            case 7:
              return 'S';
          }
          return '';
        },
      );

  FlGridData get gridData => FlGridData(show: false);

  FlBorderData get borderData => FlBorderData(
        show: false,
      );

  LineChartBarData get lineChartBarData1_1 => LineChartBarData(
        isCurved: true,
        colors: [AppTheme.red],
        barWidth: 8,
        isStrokeCapRound: true,
        dotData: FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
        spots: [
          FlSpot(1, 5),
          FlSpot(2, 7),
          FlSpot(3, 10),
          FlSpot(4, 2),
          FlSpot(5, 15),
          FlSpot(6, 20),
          FlSpot(7, 16),
        ],
      );

  LineChartBarData get lineChartBarData1_2 => LineChartBarData(
        isCurved: true,
        colors: [AppTheme.green],
        barWidth: 8,
        isStrokeCapRound: true,
        dotData: FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
        spots: [
          FlSpot(1, 10),
          FlSpot(2, 8),
          FlSpot(3, 4),
          FlSpot(4, 16),
          FlSpot(5, 12),
          FlSpot(6, 10),
          FlSpot(7, 4),
        ],
      );
}

class FWalletPage extends StatefulWidget {
  const FWalletPage({Key? key}) : super(key: key);

  @override
  State<FWalletPage> createState() => _FWalletPageState();
}

class _FWalletPageState extends State<FWalletPage> {
  bool isShowingMainData = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          _headerContent(context),
          _fWalletScrollableSheet(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppTheme.purple,
        onPressed: () {},
        child: Icon(
          Icons.add_rounded,
          size: 32,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }

  Widget _headerContent(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.32,
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Rp.1,700,000',
              style: AppTheme.headline1.white,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: Helper.normalPadding),
            Container(
              height: MediaQuery.of(context).size.height * 0.24,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: AppTheme.whiteOpacity,
                ),
                padding: EdgeInsets.fromLTRB(12, 32, 0, 12),
                child: _LineChart(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _fWalletScrollableSheet() {
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
                  _cashFlows(),
                  SizedBox(height: Helper.normalPadding),
                  _cards(),
                  _activities(),
                  SizedBox(height: Helper.normalPadding),
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

  Widget _cashFlows() {
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FittedBox(
                  child: Icon(
                    Icons.trending_down_rounded,
                    size: 28,
                    color: AppTheme.red,
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Outcomes', style: AppTheme.text3),
                      SizedBox(height: 4),
                      Text(
                        'Rp.200,000',
                        style: AppTheme.headline3,
                      ),
                    ],
                  ),
                ),
              ],
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
                      Text('Incomes', style: AppTheme.text3),
                      SizedBox(height: 4),
                      Text(
                        'Rp.156,000',
                        style: AppTheme.headline3,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _cards() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Helper.normalPadding),
            child: Text('Cards', style: AppTheme.headline3),
          ),
          Container(
            height: MediaQuery.of(context).size.width * 0.28,
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              padding: EdgeInsets.symmetric(vertical: Helper.normalPadding),
              itemBuilder: (BuildContext context, int index) {
                return _cardItem(context, index);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _cardItem(BuildContext context, int index) {
    return Container(
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
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 8,
            width: 8,
            decoration: BoxDecoration(
              color: AppTheme.purple,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: Helper.smallPadding),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Needs', style: AppTheme.text3),
              SizedBox(height: 4),
              Text('Rp. 17.000.000', style: AppTheme.headline3.darkPurple),
            ],
          ),
        ],
      ),
    );
  }

  Widget _activities() {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Helper.normalPadding),
            child: Text('Activities', style: AppTheme.headline3),
          ),
          SizedBox(height: 12),
          ListView.builder(
            shrinkWrap: true,
            itemCount: 5,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(vertical: 0),
            itemBuilder: (BuildContext context, int index) {
              return _activityItem();
            },
          ),
        ],
      ),
    );
  }

  Widget _activityItem() {
    return Container(
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: Helper.getShadow(),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Chatime',
                  style: AppTheme.headline3,
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(
                      1,
                      (index) => Container(
                            decoration: BoxDecoration(
                              color: AppTheme.yellow,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: EdgeInsets.all(4),
                            child: Text('Wants'),
                          )).toList(),
                ),
              ],
            ),
          ),
          SizedBox(width: Helper.normalPadding),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '-Rp.17,000',
                style: AppTheme.headline2.red.bold,
              ),
              SizedBox(height: 4),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(Resources.icTime, height: 12),
                  SizedBox(width: 4),
                  Text('30 September 2021', style: AppTheme.subText1),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
