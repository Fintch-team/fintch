import 'package:auto_size_text/auto_size_text.dart';
import 'package:fintch/gen_export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/src/provider.dart';

class FGoalsPage extends StatefulWidget {
  const FGoalsPage({Key? key}) : super(key: key);

  @override
  State<FGoalsPage> createState() => _FGoalsPageState();
}

class _FGoalsPageState extends State<FGoalsPage> {
  @override
  void initState() {
    super.initState();
    context.read<MoneyPlanBloc>().add(GetMoneyPlan());
  }

  @override
  Widget build(BuildContext context) {
    Helper.setDarkAppBar();
    return BlocConsumer<MoneyPlanBloc, MoneyPlanState>(
      listener: (context, state) {
        if (state is MoneyPlanLoading) {
          context.loaderOverlay.show();
        } else if (state is MoneyPlanFailure) {
          context.loaderOverlay.hide();
          Helper.snackBar(context, message: state.message, isFailure: true);
        } else if (state is MoneyPlanResponseSuccess) {
          context.loaderOverlay.hide();
        }
      },
      builder: (context, state) {
        if (state is MoneyPlanResponseSuccess) {
          return Scaffold(
            body: Background(
              isWhite: true,
              child: SafeArea(
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Container(
                    padding: EdgeInsets.all(Helper.normalPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomAppBar(
                          title: '',
                          isBlack: true,
                        ),
                        SizedBox(height: Helper.bigPadding),
                        Text('F-Goals', style: AppTheme.headline1),
                        SizedBox(height: Helper.bigPadding),
                        Text(
                          'Di F-Goals ini kamu bisa merencanakan barang atau sesuatu apa yang kamu mau beli dan inginkan atau capai, jika waktu tenggat sudah dekat, sistem pasti memberitahu kamu kok!',
                          style: AppTheme.text1,
                        ),
                        SizedBox(height: Helper.bigPadding),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: state.entity.data.length,
                          physics: NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.symmetric(vertical: 0),
                          itemBuilder: (context, index) {
                            return _fGoalItem(
                                context, index, state.entity.data[index]);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _fGoalItem(BuildContext context, int index, MoneyPlanData data) {

    return Container(
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
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      AutoSizeText(
                        data.name,
                        style: AppTheme.headline2,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        minFontSize: 16,
                      ),
                      SizedBox(height: 4),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset(Resources.icTime, height: 12),
                          SizedBox(width: 4),
                          AutoSizeText(
                            data.deadline!.parseHourDateAndMonth(),
                            style: AppTheme.subText1,
                            maxLines: 1,
                            maxFontSize: 10,
                            minFontSize: 8,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ],
                  ),
                  AutoSizeText(
                    'Rp. ${data.totalAmount.toString().parseCurrency()}',
                    style: AppTheme.text1.bold,
                    maxLines: 1,
                  ),
                ],
              ),
            ),
            SizedBox(width: Helper.smallPadding),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularPercentIndicator(
                  radius: MediaQuery.of(context).size.width * 0.2,
                  lineWidth: 16.0,
                  animation: true,
                  percent: 0.7,
                  center: Text("${data.percent}%",
                      style: AppTheme.text2.darkPurple.bold),
                  circularStrokeCap: CircularStrokeCap.round,
                  progressColor: AppTheme.purple,
                  backgroundColor: AppTheme.purpleOpacity,
                ),
                SizedBox(height: Helper.smallPadding),
                AutoSizeText(
                  'Rp. ${data.amount.toString().parseCurrency()}',
                  style: AppTheme.text3.green,
                  maxLines: 1,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
