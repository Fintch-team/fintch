import 'dart:io';

import 'package:fintch/presentation/routes/routes.dart';
import 'package:fintch/presentation/utils/utils.dart';
import 'package:fintch/presentation/widgets/widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class PayPage extends StatefulWidget {
  const PayPage({Key? key}) : super(key: key);

  @override
  _PayPageState createState() => _PayPageState();
}

class _PayPageState extends State<PayPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() async {
    super.reassemble();
    if (Platform.isAndroid) {
      await controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
        child: Container(
          color: Colors.transparent,
          child: Stack(
            children: [
              _headerContent(context),
              SafeArea(
                bottom: false,
                child: Padding(
                  padding: EdgeInsets.all(Helper.normalPadding),
                  child: Row(
                    children: [
                      Expanded(child: CustomAppBar(title: 'Scan QR Code')),
                      SizedBox(width: Helper.normalPadding),
                      GestureDetector(
                        onTap: () {},
                        child: SvgPicture.asset(Resources.icAddImage),
                      ),
                      SizedBox(width: Helper.normalPadding),
                      FutureBuilder<bool?>(
                          future: controller?.getFlashStatus(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData || snapshot.data != null) {
                              return GestureDetector(
                                onTap: () async {
                                  await controller!.toggleFlash();
                                  setState(() {});
                                },
                                child: SvgPicture.asset(
                                  snapshot.data!
                                      ? Resources.icFlashOff
                                      : Resources.icFlashOn,
                                ),
                              );
                            }
                            return Container();
                          }),
                    ],
                  ),
                ),
              ),
              _payScrollableSheet(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _headerContent(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.64,
        child: QRView(
          key: qrKey,
          onQRViewCreated: _onQRViewCreated,
          overlay: QrScannerOverlayShape(
              borderColor: AppTheme.yellow,
              borderRadius: 12,
              borderLength: 20,
              borderWidth: 12,
              cutOutSize: MediaQuery.of(context).size.height * 0.3,
              cutOutBottomOffset: -MediaQuery.of(context).padding.top +
                  MediaQuery.of(context).size.height * 0.04),
        )
        /* Container()*/,
      ),
    );
  }

  Widget _payScrollableSheet() {
    return Positioned.fill(
      child: DraggableScrollableSheet(
        initialChildSize: 0.4,
        minChildSize: 0.4,
        maxChildSize: 0.84,
        expand: true,
        builder: (BuildContext context, ScrollController scrollController) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              color: AppTheme.scaffold,
            ),
            child: SingleChildScrollView(
              controller: scrollController,
              physics: BouncingScrollPhysics(),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _bottomSheetLine(context),
                  SizedBox(height: Helper.normalPadding),
                  _fintchWallet(),
                  SizedBox(height: Helper.smallPadding),
                  _barrierCash(),
                  SizedBox(height: Helper.normalPadding),
                  SizedBox(height: Helper.normalPadding),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: Helper.normalPadding),
                    alignment: Alignment.centerLeft,
                    child: Text('Daftar Merchant', style: AppTheme.headline3),
                  ),
                  SizedBox(height: Helper.normalPadding),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(
                      20,
                      (index) => MerchantItem(),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _fintchWallet() {
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: Helper.getShadow(),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Isi Fintch Wallet kamu',
                  style: AppTheme.text3,
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    SvgPicture.asset(
                      Resources.icFintchWallet,
                      height: 32,
                    ),
                    SizedBox(width: 8),
                    Text(
                      '156,000',
                      style: AppTheme.headline1,
                    ),
                  ],
                ),
              ],
            ),
          ),
          FeatureItem(
            name: 'Terima',
            assetName: Resources.icReceive,
            onTap: () => Navigator.pushNamed(context, PagePath.receive),
            isOpacity: true,
            showTitle: false,
          ),
        ],
      ),
    );
  }

  Widget _barrierCash() {
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: Helper.getShadow(),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Sisa Barrier Cash Kamu',
                  style: AppTheme.text3,
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    SvgPicture.asset(
                      Resources.icFintchPoint,
                      height: 32,
                    ),
                    SizedBox(width: 8),
                    Text(
                      '8,000',
                      style: AppTheme.headline1,
                    ),
                  ],
                ),
              ],
            ),
          ),
          FeatureItem(
            name: 'Barrier Cash',
            assetName: Resources.icBarrierCash,
            onTap: () {},
            showTitle: false,
          ),
        ],
      ),
    );
  }

  Widget _bottomSheetLine(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppTheme.purpleOpacity,
      ),
      margin: EdgeInsets.only(top: Helper.smallPadding),
      width: MediaQuery.of(context).size.width * 0.15,
      height: 4,
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      showDialog(
        context: context,
        builder: (context) => _logoutDialog(context),
      );
    });
  }

  Widget _logoutDialog(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      elevation: 2,
      insetPadding: EdgeInsets.all(20),
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Keluar dari Fintch', style: AppTheme.headline3),
              SizedBox(height: 16.0),
              Text('Apakah kamu ingin keluar?', style: AppTheme.text3),
              SizedBox(height: 16.0),
              Row(
                children: [
                  Flexible(
                    child: CustomButton(
                      onTap: () => Navigator.pop(context),
                      text: 'Tidak',
                      isOutline: true,
                    ),
                  ),
                  SizedBox(width: 20),
                  Flexible(
                    child: CustomButton(
                      onTap: () => Navigator.pushNamedAndRemoveUntil(
                          context, PagePath.login, (route) => false),
                      text: 'Keluar',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
