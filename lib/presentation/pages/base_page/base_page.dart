import 'package:fintch/presentation/pages/pages.dart';
import 'package:fintch/presentation/utils/utils.dart';
import 'package:fintch/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BasePage extends StatefulWidget {
  const BasePage({Key? key}) : super(key: key);

  @override
  _BasePageState createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 3,
      child: Scaffold(
        body: Background(
          child: SafeArea(
            child: Container(
              child: Column(
                children: [
                  SizedBox(height: 20),
                  ShiftingTabBar(
                    bgColor: Colors.transparent,
                    tabs: <ShiftingTab>[
                      ShiftingTab(
                        icon: SvgPicture.asset(Resources.rank),
                        inactiveIcon: SvgPicture.asset(Resources.rankInactive),
                        text: 'Rank',
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
                  ),
                  SizedBox(height: 20),
                  Expanded(
                    child: TabBarView(
                      children: [
                        RankPage(),
                        HomePage(),
                        HistoryPage(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
