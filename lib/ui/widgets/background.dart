import 'package:fintch/gen_export.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Background extends StatelessWidget {
  final Widget child;
  final bool isWhite;

  const Background({
    Key? key,
    required this.child,
    this.isWhite: false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: SvgPicture.asset(
            isWhite? Resources.bgPatternWhite : Resources.bgPattern,
            fit: BoxFit.cover,
          ),
        ),
        Positioned.fill(
          child: child,
        ),
      ],
    );
  }
}
