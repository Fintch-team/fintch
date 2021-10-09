import 'package:fintch/gen_export.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TransactionItem extends StatelessWidget {
  final HistoryData item;
  final bool isPay;

  const TransactionItem({
    required this.item,
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
                  /*TODO: di history page, array pay sama receive nya masih belum ke split,
                     masih kegabung, tapi data didalemnya udah bener, ada user pay sama user receive
                     kalau yang di home page, array pay sama receive nya udah ke split,
                     tapi data didalemnya baru cuma user pay kalau di array pay, user receive kalau di array receive
                     kalau bisa dua duanya, untuk di nama soalnya
                  */
                  'Dari Adit untuk Galuh',
                  // 'Dari ${item.pay!.name} untuk ${item.receive!.name}',
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
