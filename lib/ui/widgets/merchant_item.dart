import 'package:fintch/gen_export.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MerchantItem extends StatelessWidget {
  final VoidCallback onMerchantTap;
  final UserData user;
  const MerchantItem({
    Key? key,
    required this.onMerchantTap,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onMerchantTap,
      child: Container(
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          color: AppTheme.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: Helper.getShadow(),
        ),
        child: Row(
          children: [
            CustomNetworkImage(
              imgUrl: user.img,
              borderRadius: 64,
              width: MediaQuery.of(context).size.width * 0.12,
              height: MediaQuery.of(context).size.width * 0.12,
            ),
            SizedBox(width: Helper.smallPadding),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    user.name,
                    style: AppTheme.headline3,
                  ),
                  SizedBox(height: 8),
                  Text(
                    user.school.name,
                    style: AppTheme.text3,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            SvgPicture.asset(Resources.next),
          ],
        ),
      ),
    );
  }
}
