import 'package:fintch/gen_export.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BasePage extends StatefulWidget {
  const BasePage({Key? key}) : super(key: key);

  @override
  _BasePageState createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  final int _tabBarLength = 3;
  final int _initialIndex = 1;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: _initialIndex,
      length: _tabBarLength,
      child: Scaffold(
        body: Background(
          child: Container(
            child: Column(
              children: [
                _tabBar(),
                SizedBox(height: Helper.normalPadding),
                _tabBarView(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _tabBar() {
    return ShiftingTabBar(
      bgColor: AppTheme.darkPurple,
      labelFlex: 2,
      labelStyle: AppTheme.text1.bold.white.copyWith(letterSpacing: 2),
      tabs: <ShiftingTab>[
        ShiftingTab(
          icon: SvgPicture.asset(Resources.fWallet),
          inactiveIcon: SvgPicture.asset(Resources.fWalletInactive),
          text: 'F-Wallet',
        ),
        ShiftingTab(
          icon: SvgPicture.asset(Resources.home),
          inactiveIcon: SvgPicture.asset(Resources.homeInactive),
          text: 'Home',
        ),
        ShiftingTab(
          icon: SvgPicture.asset(Resources.history),
          inactiveIcon: SvgPicture.asset(Resources.historyInactive),
          text: 'History',
        ),
      ],
    );
  }

  Widget _tabBarView() {
    return Expanded(
      child: TabBarView(
        children: [
          LeaderboardPage(),
          HomePage(),
          HistoryPage(),
        ],
      ),
    );
  }
}
