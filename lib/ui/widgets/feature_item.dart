
import 'package:auto_size_text/auto_size_text.dart';
import 'package:fintch/gen_export.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FeatureItem extends StatelessWidget {
  final bool isOpacity;
  final String name;
  final String assetName;
  final VoidCallback onTap;
  final bool showTitle;
  final bool isExpand;
  final double? size;
  const FeatureItem({
    Key? key,
    this.isOpacity: false,
    required this.name,
    required this.assetName,
    required this.onTap,
    this.isExpand : true,
    this.showTitle: true,
    this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isExpand ? Expanded(
      child: _item(),
    ) : _item();
  }

  GestureDetector _item() {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: size,
            width: size,
            child: AspectRatio(
              aspectRatio: 1,
              child: Container(
                decoration: BoxDecoration(
                  color: isOpacity ? AppTheme.purpleOpacity : AppTheme.purple,
                  image: DecorationImage(
                    image: AssetImage(Resources.bgPatternPng),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: Helper.getShadow(),
                ),
                padding: EdgeInsets.all(20),
                child: SvgPicture.asset(assetName),
              ),
            ),
          ),
          SizedBox(height: showTitle ? 8 : 0),
          showTitle ? AutoSizeText(
            name,
            style: AppTheme.text3.black.bold,
            textAlign: TextAlign.center,
          ) : Container(),
        ],
      ),
    );
  }
}
