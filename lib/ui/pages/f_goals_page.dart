import 'package:fintch/gen_export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:percent_indicator/percent_indicator.dart';

class FGoalsPage extends StatelessWidget {
  const FGoalsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Helper.setDarkAppBar();
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
                    itemCount: 10,
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(vertical: 0),
                    itemBuilder: (context, index) {
                      return _fGoalItem(context, index);
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


  Widget _fGoalItem(BuildContext context, int index) {
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
        aspectRatio: 17/ 6,
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
                      Text(
                        'Beli Laptop Asus',
                        style: AppTheme.headline2,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
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
                  Text('Rp. 17.000.000', style: AppTheme.text1.bold),
                ],
              ),
            ),
            SizedBox(width: Helper.smallPadding),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularPercentIndicator(
                  radius: 88.0,
                  lineWidth: 16.0,
                  animation: true,
                  percent: 0.7,
                  center: Text("70%", style: AppTheme.text2.darkPurple.bold),
                  circularStrokeCap: CircularStrokeCap.round,
                  progressColor: AppTheme.purple,
                  backgroundColor: AppTheme.purpleOpacity,
                ),
                SizedBox(height: Helper.smallPadding),
                Text('Rp. 17.000.000', style: AppTheme.text3.green),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
