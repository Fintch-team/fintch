import 'package:fintch/gen_export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmptyStateWidget extends StatelessWidget {
  final String message;

  const EmptyStateWidget({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      padding: EdgeInsets.all(Helper.normalPadding),
      child: Column(
        children: [
          Expanded(
            child: SvgPicture.asset(Resources.empty),
          ),
          SizedBox(height: Helper.normalPadding),
          Text(
            message,
            style: AppTheme.text1.bold,
          ),
        ],
      ),
    );
  }
}

class FailureStateWidget extends StatelessWidget {
  final String message;

  const FailureStateWidget({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      padding: EdgeInsets.all(Helper.normalPadding),
      child: Column(
        children: [
          Expanded(
            child: SvgPicture.asset(Resources.failure),
          ),
          SizedBox(height: Helper.normalPadding),
          Text(
            message,
            style: AppTheme.text1.bold,
          ),
        ],
      ),
    );
  }
}
