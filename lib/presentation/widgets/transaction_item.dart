
import 'package:fintch/presentation/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
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
                  '#1234053934',
                  style: AppTheme.subText1.purpleOpacity,
                ),
                SizedBox(height: 8),
                Text(
                  'Dari Adithya untuk PT. Dunia Akhirat',
                  style: AppTheme.text2.black,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 8),
                Text(
                  '15 Jul 2021 16:13',
                  style: AppTheme.subText2.black.bold,
                ),
              ],
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SvgPicture.asset(
                    Resources.icFintchPoint,
                    height: 20,
                  ),
                  SizedBox(width: 4),
                  Text(
                    '-20,000',
                    style: AppTheme.text1.red.bold,
                  ),
                ],
              ),
              SizedBox(height: 4),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    Resources.icFintchWallet,
                    height: 16,
                  ),
                  SizedBox(width: 4),
                  Text(
                    '156,000',
                    style: AppTheme.text2,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
