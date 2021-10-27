import 'package:auto_size_text/auto_size_text.dart';
import 'package:fintch/gen_export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

class QrCodeFile extends StatelessWidget {
  final BuildContext parentContext;
  final String title;
  final String subtitle1;
  final String subtitle2;
  final String data;

  const QrCodeFile(
    this.parentContext, {
    Key? key,
    required this.title,
    required this.subtitle1,
    required this.subtitle2,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        width: MediaQuery.of(parentContext).size.width,
        child: AspectRatio(
          aspectRatio: 1 / 1.41,
          child: Container(
            width: MediaQuery.of(parentContext).size.width,
            child: Background(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: Helper.bigPadding),
                  SvgPicture.asset(
                    Resources.textLogo,
                    fit: BoxFit.fitWidth,
                    width: MediaQuery.of(parentContext).size.width * 0.32,
                  ),
                  SizedBox(height: Helper.normalPadding),
                  AutoSizeText(
                    title,
                    style: AppTheme.headline1.white,
                    maxLines: 1,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8),
                  AutoSizeText(
                    subtitle1,
                    style: AppTheme.text1.white,
                    maxLines: 1,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8),
                  AutoSizeText(
                    subtitle2,
                    style: AppTheme.text1.yellow,
                    maxLines: 1,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: Helper.normalPadding),
                  Expanded(
                    child: FittedBox(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: AppTheme.white,
                        ),
                        padding: EdgeInsets.all(20),
                        child: PrettyQr(
                          image: AssetImage(Resources.icFintchPointPng),
                          data: data,
                          errorCorrectLevel: QrErrorCorrectLevel.M,
                          roundEdges: true,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: Helper.normalPadding),
                  AutoSizeText(
                    'Scan QR-Code di atas melalui aplikasi Fintch.',
                    maxLines: 1,
                    style: AppTheme.text1.white.bold,
                  ),
                  SizedBox(height: Helper.normalPadding),
                  FittedBox(
                    child: SvgPicture.asset(
                      Resources.footerQrCode,
                      fit: BoxFit.fitWidth,
                      clipBehavior: Clip.hardEdge,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
