import 'package:auto_size_text/auto_size_text.dart';
import 'package:fintch/gen_export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TopUpItem extends StatelessWidget {
  final TopUpData item;

  const TopUpItem({
    required this.item,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.symmetric(
        vertical: 10,
      ),
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AutoSizeText(
                  item.createdAt.parseHourDateAndMonth(),
                  style: AppTheme.text3,
                ),
                SizedBox(height: 12),
                AutoSizeText(
                  item.number,
                  style: AppTheme.text1,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          SizedBox(width: Helper.normalPadding),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AutoSizeText(
                  item.paymentStatus,
                  style: AppTheme.headline2.red.bold,
                ),
                SizedBox(width: 12),
                AutoSizeText(
                  item.totalPrice.parseCurrency(),
                  style: AppTheme.text1,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
