import 'package:fintch/gen_export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final bool isBlack;

  const CustomAppBar({Key? key, required this.title, this.isBlack: false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            decoration: BoxDecoration(
              boxShadow: isBlack ? Helper.getShadow() : null,
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset(
                isBlack ? Resources.backBlack : Resources.back),
          ),
        ),
        SizedBox(width: 20),
        Expanded(
          child: Text(title,
              style: isBlack ? AppTheme.text1.bold : AppTheme.text1.white.bold),
        ),
      ],
    );
  }
}
