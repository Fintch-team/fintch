import 'package:auto_size_text/auto_size_text.dart';
import 'package:fintch/gen_export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_files_and_screenshot_widgets/share_files_and_screenshot_widgets.dart';

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
    GlobalKey previewContainer = GlobalKey();

    final qrFutureBuilder = FutureBuilder<ui.Image>(
      future: _loadOverlayImage(),
      builder: (ctx, snapshot) {
        final size = 280.0;
        if (!snapshot.hasData) {
          return Container(width: size, height: size);
        }
        return CustomPaint(
          size: Size.square(size),
          painter: QrPainter(
            data: data,
            version: QrVersions.auto,
            eyeStyle: const QrEyeStyle(
              eyeShape: QrEyeShape.square,
              color: Colors.black87,
            ),
            dataModuleStyle: const QrDataModuleStyle(
              dataModuleShape: QrDataModuleShape.circle,
              color: Colors.black,
            ),
            // size: 320.0,
            embeddedImage: snapshot.data,
            embeddedImageStyle: QrEmbeddedImageStyle(
              size: Size.square(60),
            ),
          ),
        );
      },
    );

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
                        child: RepaintBoundary(
                          key: previewContainer,
                          child: Center(
                            child: Container(
                              width: 280,
                              child: qrFutureBuilder,
                            ),
                          ),
                        ),
                        // child: PrettyQr(
                        //   image: AssetImage(Resources.icFintchPointPng),
                        //   data: data,
                        //   errorCorrectLevel: QrErrorCorrectLevel.M,
                        //   roundEdges: true,
                        // ),
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

  Future<ui.Image> _loadOverlayImage() async {
    final completer = Completer<ui.Image>();
    final byteData = await rootBundle.load(Resources.icFintchPointPng);
    ui.decodeImageFromList(byteData.buffer.asUint8List(), completer.complete);
    return completer.future;
  }
}
