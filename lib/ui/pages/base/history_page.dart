import 'package:fintch/gen_export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  bool isPayHistory = true;
  int historyTotal = 0;

  @override
  void initState() {
    _initHistory();
    super.initState();
  }

  Future<void> _onRefresh() async {
    _initHistory();
  }

  void _initHistory() {
    context.read<HistoryBloc>().add(GetHistory());
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
    return BlocConsumer<HistoryBloc, HistoryState>(
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
                        _headerContent(context),
                        _historyScrollableSheet(state),
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
      child: SlidingUpPanel(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        color: AppTheme.scaffold,
        minHeight: MediaQuery.of(context).size.height * 0.60,
        maxHeight: MediaQuery.of(context).size.height * 0.90,
        panelBuilder: (scrollController) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              color: AppTheme.scaffold,
            ),
            child: SingleChildScrollView(
              controller: scrollController,
              physics: AlwaysScrollableScrollPhysics(),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _bottomSheetLine(context),
                  SizedBox(height: Helper.normalPadding),
                  HistoryTab(
                    isPay: isPayHistory,
                    payCallback: payCallback,
                    receiveCallback: receiveCallback,
                  ),
                  SizedBox(height: Helper.normalPadding),
                  _historyList(state),
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

  Widget _historyList(HistoryState state) {
    if (state is HistoryResponseSuccess) {
      if (isPayHistory) {
        if (state.history.pay.isNotEmpty) {
          return ListView.builder(
            itemCount: state.history.pay.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(vertical: 10),
            itemBuilder: (context, index) {
              return TransactionItem(
                item: state.history.pay[index],
                isPay: isPayHistory,
              );
              // return SizedBox();
            },
          );
        }
        return EmptyStateWidget(message: 'History Pay Kosong!');
      } else {
        if (state.history.receive.isNotEmpty) {
          return ListView.builder(
            itemCount: state.history.receive.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(vertical: 10),
            itemBuilder: (context, index) {
              return TransactionItem(
                item: state.history.receive[index],
                isPay: isPayHistory,
              );
            },
          );
        }
        return EmptyStateWidget(message: 'History Receive Kosong!');
      }
    } else if (state is HistoryLoading) {
      return Container(
        height: MediaQuery.of(context).size.width * 0.48,
        child: Center(
          child: CircularLoading(),
        ),
      );
    } else if (state is HistoryFailure) {
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
