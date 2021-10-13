import 'package:auto_size_text/auto_size_text.dart';
import 'package:fintch/gen_export.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:permission_handler/permission_handler.dart';

class FWalletPage extends StatefulWidget {
  const FWalletPage({Key? key}) : super(key: key);

  @override
  State<FWalletPage> createState() => _FWalletPageState();
}

class _FWalletPageState extends State<FWalletPage> {
  @override
  void initState() {
    requestFWallet();
    super.initState();
  }

  Future<void> _onRefresh() async {
    requestFWallet();
  }

  void requestFWallet() {
    context.read<WalletBloc>().add(GetWallet());
    context.read<MoneyManageBloc>().add(GetMoneyManage());
    context.read<MoneyManageItemBloc>().add(GetMoneyManageItem());
  }

  @override
  Widget build(BuildContext context) {
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
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Column(
              children: [
                SizedBox(height: Helper.normalPadding),
                Expanded(
                  child: Stack(
                    children: [
                      _headerContent(context),
                      _fWalletScrollableSheet(),
                    ],
                  ),
                ),
              ],
            ),
            floatingActionButton: CustomFab(),
            // floatingActionButton: Container(
            //   margin: EdgeInsets.only(bottom: Helper.normalPadding),
            //   child: FloatingActionButton(
            //     backgroundColor: AppTheme.purple,
            //     onPressed: () {},
            //     child: Icon(
            //       Icons.add_rounded,
            //       size: MediaQuery.of(context).size.width * 0.1,
            //     ),
            //   ),
            // ),
            // floatingActionButtonLocation:
            //     FloatingActionButtonLocation.endDocked,
          ),
        ),
      ),
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
        child: BlocBuilder<WalletBloc, WalletState>(
          builder: (context, state) {
            if (state is WalletResponseSuccess) {
              // TODO: harus ada nilai jumlah manage amount unutk d bawah

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AutoSizeText(
                    'Rp.${state.entity.walletAmount.toString().parseCurrency()}',
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
              );
            } else if (state is WalletLoading) {
              return Center(
                child: CircularLoading(),
              );
            } else if (state is WalletFailure) {
              return Center(
                child: Text('Gagal Load F-Wallet'),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }

  //TODO: Refactor DraggableScrollableSheet
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
    // TODO: EP untuk get nilai income dan outcome
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
                      AutoSizeText(
                        'Outcomes',
                        style: AppTheme.text3,
                        maxLines: 1,
                      ),
                      SizedBox(height: 4),
                      AutoSizeText(
                        'Rp.200,000',
                        style: AppTheme.headline3,
                        maxLines: 1,
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
                      AutoSizeText(
                        'Incomes',
                        style: AppTheme.text3,
                        maxLines: 1,
                      ),
                      SizedBox(height: 4),
                      AutoSizeText(
                        'Rp.156,000',
                        maxLines: 1,
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
    // TODO: implementasi money manage item
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
            child: BlocConsumer<MoneyManageItemBloc, MoneyManageItemState>(
              listener: (context, state) {
                if (state is MoneyManageItemFailure) {
                  print("gagal");
                  Helper.snackBar(context,
                      message: state.message, isFailure: true);
                }
              },
              builder: (context, state) {
                if (state is MoneyManageItemResponseSuccess) {
                  if (state.entity.data.isNotEmpty) {
                    return ListView.builder(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: state.entity.data.length,
                      padding:
                          EdgeInsets.symmetric(vertical: Helper.normalPadding),
                      itemBuilder: (BuildContext context, int index) {
                        return _cardItem(
                            context, index, state.entity.data[index]);
                      },
                    );
                  }
                  return Center(
                    child: Text(
                      'Cards Kosong!',
                      style: AppTheme.text1.bold,
                    ),
                  );
                } else if (state is MoneyManageItemLoading) {
                  return Center(
                    child: CircularLoading(),
                  );
                } else if (state is MoneyManageItemFailure) {
                  return Center(
                    child: Text(
                      'Data gagal di load',
                      style: AppTheme.headline3.white,
                      textAlign: TextAlign.center,
                    ),
                  );
                }
                return Container();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _cardItem(BuildContext context, int index, MoneyManageItemData data) {
    return GestureDetector(
      onTap: () {
        showCupertinoModalBottomSheet(
          expand: false,
          context: context,
          enableDrag: true,
          isDismissible: true,
          topRadius: Radius.circular(20),
          backgroundColor: AppTheme.white,
          barrierColor: AppTheme.black.withOpacity(0.2),
          builder: (context) => MoneyManageItemSheet(data: data),
        );
      },
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
                Text(data.name, style: AppTheme.text3),
                SizedBox(height: 4),
                AutoSizeText(
                  'Rp. ${data.amount.toString().parseCurrency()}',
                  style: AppTheme.headline3.darkPurple,
                  maxLines: 1,
                ),
              ],
            ),
          ],
        ),
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
          SizedBox(height: Helper.smallPadding),
          BlocConsumer<MoneyManageBloc, MoneyManageState>(
            listener: (context, state) {
              if (state is MoneyManageFailure) {
                Helper.snackBar(context,
                    message: state.message, isFailure: true);
              }
            },
            builder: (context, state) {
              if (state is MoneyManageResponseSuccess) {
                if (state.entity.data.isNotEmpty) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.entity.data.length,
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(vertical: 0),
                    itemBuilder: (BuildContext context, int index) {
                      return _activityItem(state.entity.data[index]);
                    },
                  );
                }
                return Center(
                  child: Text(
                    'Activities Kosong!',
                    style: AppTheme.text1.bold,
                  ),
                );
              } else if (state is MoneyManageLoading) {
                return Center(
                  child: CircularLoading(),
                );
              } else if (state is MoneyManageFailure) {
                return Center(
                  child: Text(
                    'Data gagal di load',
                    style: AppTheme.headline3.white,
                    textAlign: TextAlign.center,
                  ),
                );
              }
              return Container();
            },
          ),
        ],
      ),
    );
  }

  Widget _activityItem(MoneyManageData data) {
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
            flex: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AutoSizeText(
                  data.name,
                  style: AppTheme.headline3,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  minFontSize: 16,
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
                            child: Text(data.item.name),
                          )).toList(),
                ),
              ],
            ),
          ),
          SizedBox(width: Helper.normalPadding),
          Expanded(
            flex: 3,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                AutoSizeText(
                  data.isIncome
                      ? 'Rp.${data.amount.toString().parseCurrency()}'
                      : '-Rp.${data.amount.toString().parseCurrency()}',
                  style: data.isIncome
                      ? AppTheme.headline2.green.bold
                      : AppTheme.headline2.red.bold,
                  maxLines: 1,
                ),
                SizedBox(height: 4),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(Resources.icTime, height: 12),
                    SizedBox(width: 4),
                    AutoSizeText(
                      '30 September 2021',
                      style: AppTheme.subText1,
                      maxLines: 1,
                      maxFontSize: 8,
                      minFontSize: 8,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MoneyManageItemSheet extends StatefulWidget {
  final MoneyManageItemData? data;

  const MoneyManageItemSheet({Key? key, this.data}) : super(key: key);

  @override
  State<MoneyManageItemSheet> createState() => _MoneyManageItemSheetState();
}

class _MoneyManageItemSheetState extends State<MoneyManageItemSheet> {
  late TextEditingController titleController;
  late TextEditingController percentController;
  final _formKey = GlobalKey<FormState>();
  DateTime datePicked = DateTime.now();
  DateTime now = DateTime.now();

  @override
  void initState() {
    titleController = TextEditingController();
    percentController = TextEditingController();
    if (widget.data != null) {
      titleController.text = widget.data!.name;
      percentController.text = widget.data!.percent.toString();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: GestureDetector(
        onTap: () => Helper.unfocus(),
        child: Container(
          padding: MediaQuery.of(context).viewInsets,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              color: AppTheme.white,
            ),
            padding: EdgeInsets.all(20),
            child: Stack(
              children: [
                SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          widget.data != null ? 'Update Card' : 'Add Card',
                          style: AppTheme.headline3,
                        ),
                        SizedBox(height: Helper.bigPadding),
                        Text('Judul', style: AppTheme.text3.bold),
                        SizedBox(height: 8),
                        TextFormField(
                          controller: titleController,
                          style: AppTheme.text3,
                          decoration: InputDecoration(
                            hintText: 'Masukan judul Card',
                            enabledBorder: AppTheme.enabledBlackBorder,
                            hintStyle: AppTheme.text3.blackOpacity,
                          ),
                          validator: Validator.notEmpty,
                        ),
                        SizedBox(height: 16),
                        Text('Persen card', style: AppTheme.text3.bold),
                        SizedBox(height: 8),
                        TextFormField(
                          controller: percentController,
                          style: AppTheme.text3,
                          decoration: InputDecoration(
                            hintText: 'Masukan persen',
                            enabledBorder: AppTheme.enabledBlackBorder,
                            hintStyle: AppTheme.text3.blackOpacity,
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          validator: (value) {
                            Validator.notEmpty(value);
                            Validator.number(value);
                            final n = num.tryParse(value!);
                            if (n == 0) {
                              return "Harga tidak boleh nol";
                            }
                            if (n == null) {
                              return '"$value" bukan bilangan!';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.number,
                        ),

                        SizedBox(height: Helper.bigPadding),
                        SizedBox(height: Helper.bigPadding),
                        //TODO: Add Validator
                        CustomButton(
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              if (widget.data != null) {
                                context.read<MoneyManageItemBloc>().add(
                                      EditMoneyManageItem(
                                        entity: MoneyManageItemPutEntity(
                                          idMoneyManageItem:
                                              widget.data!.id.toString(),
                                          amount: 0,
                                          percent: percentController.text,
                                          name: titleController.text,
                                        ),
                                      ),
                                    );
                              } else {
                                context.read<MoneyManageItemBloc>().add(
                                      PostMoneyManageItem(
                                        entity: MoneyManageItemPostEntity(
                                          amount: 0,
                                          percent: percentController.text,
                                          name: titleController.text,
                                        ),
                                      ),
                                    );
                              }

                              context
                                  .read<MoneyManageItemBloc>()
                                  .add(GetMoneyManageItem());
                              Navigator.pop(context);
                            }
                          },
                          text: 'Simpan',
                          isUpper: false,
                        ),
                        SizedBox(height: MediaQuery.of(context).padding.bottom),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  top: 0,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: SvgPicture.asset(Resources.icClose),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

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
        lineChartOutcomes,
        lineChartIncomes,
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

  LineChartBarData get lineChartOutcomes => LineChartBarData(
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

  LineChartBarData get lineChartIncomes => LineChartBarData(
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

class CustomFab extends StatefulWidget {
  @override
  _CustomFabState createState() => _CustomFabState();
}

class _CustomFabState extends State<CustomFab>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _translateAnimation;
  late Animation<double> _rotationAnimation;

  late Animation<double> _iconRotation;

  bool _isExpanded = false;

  void animate() {
    if (!_isExpanded) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }

    _isExpanded = !_isExpanded;
  }

  Widget fab1() {
    return Container(
      height: 60,
      width: 60,
      child: FittedBox(
        child: FloatingActionButton(
          tooltip: "Activities",
          child: Transform.rotate(
            angle: _iconRotation.value,
            child: Icon(Icons.add),
          ),
          backgroundColor: AppTheme.darkPurple,
          elevation: 0,
          onPressed: () {
            print("pressed");
          },
        ),
      ),
    );
  }

  Widget fab2() {
    return Container(
      height: 60,
      width: 60,
      child: FittedBox(
        child: FloatingActionButton(
          tooltip: "Card",
          child: Transform.rotate(
            angle: _iconRotation.value,
            child: Icon(Icons.add),
          ),
          elevation: _isExpanded ? 5 : 0,
          backgroundColor: AppTheme.darkPurple,
          onPressed: () {
            showCupertinoModalBottomSheet(
              expand: false,
              context: context,
              enableDrag: true,
              isDismissible: true,
              topRadius: Radius.circular(20),
              backgroundColor: AppTheme.white,
              barrierColor: AppTheme.black.withOpacity(0.2),
              builder: (context) => MoneyManageItemSheet(),
            );
          },
        ),
      ),
    );
  }

  Widget fab3() {
    return Container(
      height: 60,
      width: 60,
      child: FittedBox(
        child: FloatingActionButton(
          tooltip: "btn5",
          child: Transform.rotate(
            angle: _rotationAnimation.value,
            child: Icon(Icons.add),
          ),
          backgroundColor: AppTheme.purple,
          onPressed: () async {
            animate();
          },
        ),
      ),
    );
  }

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400))
          ..addListener(() {
            setState(() {});
          });
    _translateAnimation = Tween<double>(begin: 0, end: 80)
        .chain(
          CurveTween(
            curve: _isExpanded ? Curves.fastOutSlowIn : Curves.bounceOut,
          ),
        )
        .animate(_animationController);

    _iconRotation = Tween<double>(begin: 3.14 / 2, end: 0)
        .chain(
          CurveTween(curve: Curves.bounceInOut),
        )
        .animate(_animationController);
    _rotationAnimation = Tween<double>(begin: 0, end: 3 * 3.14 / 4)
        .chain(
          CurveTween(
            curve: Curves.bounceInOut,
          ),
        )
        .animate(_animationController);
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          bottom: _translateAnimation.value + _translateAnimation.value,
          right: 0,
          child: fab1(),
        ),
        Positioned(
          bottom: _translateAnimation.value,
          right: 0,
          child: fab2(),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: fab3(),
        ),
      ],
    );
  }
}
