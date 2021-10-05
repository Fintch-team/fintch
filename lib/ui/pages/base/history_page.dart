import 'package:fintch/gen_export.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  bool isPayHistory = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Stack(
        children: [
          _headerContent(context),
          _historyScrollableSheet(),
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
                        'Fintch History',
                        style: AppTheme.headline1.white,
                      ),
                      SizedBox(height: 8),
                      Text(
                        '20x Transaction',
                        style: AppTheme.text3.white,
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

  Widget _historyScrollableSheet() {
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
                  HistoryTab(
                    isPay: isPayHistory,
                    payCallback: () {
                      setState(() {
                        isPayHistory = true;
                      });
                    },
                    receiveCallback: () {
                      setState(() {
                        isPayHistory = false;
                      });
                    },
                  ),
                  SizedBox(height: Helper.normalPadding),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(
                      20,
                      (index) => TransactionItem(
                        isPay: isPayHistory,
                        item: Datum(
                          id: 1,
                          amount: '20000',
                          createdAt: DateTime.now(),
                          updatedAt: DateTime.now(),
                          name: 'Dari Adit untuk Galuh',
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
