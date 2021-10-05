
import 'package:fintch/gen_export.dart';
import 'package:flutter/material.dart';

class HistoryTab extends StatelessWidget {
  final VoidCallback payCallback;
  final VoidCallback receiveCallback;
  final bool isPay;

  const HistoryTab(
      {Key? key, required this.payCallback, required this.receiveCallback, this.isPay: true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.grey,
        borderRadius: BorderRadius.circular(24),
        boxShadow: Helper.getShadow(),
      ),
      width: MediaQuery.of(context).size.width * 0.6,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: GestureDetector(
              onTap: payCallback,
              child: Container(
                decoration: BoxDecoration(
                  color: isPay ? AppTheme.yellow : AppTheme.grey,
                  borderRadius: BorderRadius.circular(24),
                ),
                padding: EdgeInsets.all(12),
                child: Center(
                  child: Text(
                    'Pay',
                    style: isPay ? AppTheme.text1.bold : AppTheme.text1.blackOpacity.bold,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: receiveCallback,
              child: Container(
                decoration: BoxDecoration(
                  color: !isPay ? AppTheme.yellow : AppTheme.grey,
                  borderRadius: BorderRadius.circular(24),
                ),
                padding: EdgeInsets.all(12),
                child: Center(
                  child: Text(
                    'Receive',
                    style:
                    !isPay ? AppTheme.text1.bold : AppTheme.text1.blackOpacity.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
