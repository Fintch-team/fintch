import 'package:fintch/gen_export.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TransactionItem extends StatelessWidget {
  final HistoryData item;
  final String name;
  final bool isPay;

  const TransactionItem({
    required this.item,
    required this.name,
    this.isPay: true,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  item.createdAt.parseHourDateAndMonth(),
                  style: AppTheme.text3,
                ),
                SizedBox(height: 8),
                Text(
                  'Dari $name',
                  style: AppTheme.text1,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          SizedBox(width: Helper.normalPadding),
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                (isPay ? '-' : '') + item.amount.parseCurrency(),
                style: isPay
                    ? AppTheme.headline2.red.bold
                    : AppTheme.headline2.green.bold,
              ),
              SizedBox(width: 8),
              SvgPicture.asset(
                Resources.icFintchPoint,
                height: 24,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
