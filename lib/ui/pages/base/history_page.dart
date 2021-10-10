import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:fintch/gen_export.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  int isPayHistory = 0;
  int historyTotal = 0;

  @override
  void initState() {
    super.initState();

    _initHistory();
  }

  void _initHistory() {
    context.read<HistoryBloc>().add(GetHistory());
  }

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      child: BlocConsumer<HistoryBloc, HistoryState>(
        listener: (context, state) {
          if (state is HistoryResponseSuccess) {
            WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
              setState(() {
                historyTotal =
                    state.history.pay.length + state.history.receive.length;
              });
            });
          } else if (state is HistoryFailure) {
            Helper.snackBar(context, message: state.message, isFailure: true);
          }
        },
        builder: (context, state) {
          return Container(
            color: Colors.transparent,
            child: Stack(
              children: [
                _headerContent(context),
                _historyScrollableSheet(state),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _headerContent(BuildContext context) {
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
                        '$historyTotal x Transaction',
                        style: AppTheme.text3.white,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: Helper.normalPadding),
                _historyIllustration(context),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _historyIllustration(BuildContext context) {
    return SvgPicture.asset(
      Resources.homeIllustration,
      width: MediaQuery.of(context).size.width * 0.3,
      fit: BoxFit.fitWidth,
    );
  }

  Widget _historyScrollableSheet(HistoryState state) {
    //TODO: sort history data harus latest
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
                  SizedBox(height: Helper.normalPadding),
                  state is HistoryResponseSuccess
                      ? IndexedStack(
                          index: isPayHistory,
                          children: [
                            state.history.pay.isNotEmpty
                                ? ListView.builder(
                                    itemCount: state.history.pay.length,
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    itemBuilder: (context, index) {
                                      return TransactionItem(
                                        item: state.history.pay[index],
                                        isPay: isPayHistory == 0 ? true : false,
                                      );
                                      // return SizedBox();
                                    },
                                  )
                                : Text(
                                    'History Pay Kosong!',
                                    style: AppTheme.text1.bold,
                                  ),
                            state.history.receive.isNotEmpty
                                ? ListView.builder(
                                    itemCount: state.history.receive.length,
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    itemBuilder: (context, index) {
                                      return TransactionItem(
                                        item: state.history.receive[index],
                                        isPay: isPayHistory == 0 ? true : false,
                                      );
                                    },
                                  )
                                : Text(
                                    'History Receive Kosong!',
                                    style: AppTheme.text1.bold,
                                  ),
                          ],
                        )
                      : state is HistoryLoading
                          ? Container(
                              height: MediaQuery.of(context).size.width * 0.48,
                              child: Center(
                                child: CircularLoading(),
                              ),
                            )
                          : Container(),
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
