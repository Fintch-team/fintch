import 'package:fintch/presentation/utils/utils.dart';
import 'package:fintch/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MerchantItem extends StatelessWidget {
  final VoidCallback onMerchantTap;
  const MerchantItem({
    Key? key, required this.onMerchantTap,
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
              imgUrl: Dummy.profileImg,
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
                    'Chatime',
                    style: AppTheme.headline3,
                  ),
                  SizedBox(height: 8),
                  Text(
                    'SMK Negeri 1 Majalengka',
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
