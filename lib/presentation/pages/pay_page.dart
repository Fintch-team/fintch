import 'dart:async';
import 'dart:io';

import 'package:fintch/presentation/routes/routes.dart';
import 'package:fintch/presentation/utils/utils.dart';
import 'package:fintch/presentation/widgets/widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:slide_to_confirm/slide_to_confirm.dart';

class PayPage extends StatefulWidget {
  const PayPage({Key? key}) : super(key: key);

  @override
  _PayPageState createState() => _PayPageState();
}

class _PayPageState extends State<PayPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  bool isShowSheet = false;
  bool canShowQRScanner = false;

  @override
  void initState() {
    // getCameraPermission();
    super.initState();
  }

  @override
  void reassemble() async {
    super.reassemble();
    if (!isShowSheet) {
      if (Platform.isAndroid) {
        await controller!.pauseCamera();
      }
      controller!.resumeCamera();
    }
  }

  void getCameraPermission() async {
    print(await Permission.camera.status);
    var status = await Permission.camera.status;
    if (!status.isGranted) {
      final result = await Permission.camera.request();
      if (result.isGranted) {
        setState(() {
          canShowQRScanner = true;
        });
      } else {
        Helper.snackBar(
          context,
          message:
              'Tolong izinin kami untuk akses kamera kamu agar bisa menggunakan fitur ini yaa :)',
        );
        Navigator.of(context).pop();
      }
    } else {
      setState(() {
        canShowQRScanner = true;
      });
    }
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
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: SafeArea(
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
                        FutureBuilder<bool?>(
                            future: controller?.getFlashStatus(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData || snapshot.data != null) {
                                return GestureDetector(
                                  onTap: () async {
                                    await controller!.toggleFlash();
                                    setState(() {});
                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SizedBox(width: Helper.normalPadding),
                                      SvgPicture.asset(
                                        snapshot.data!
                                            ? Resources.icFlashOff
                                            : Resources.icFlashOn,
                                      ),
                                    ],
                                  ),
                                );
                              }
                              return Container();
                            }),
                      ],
                    ),
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
    return canShowQRScanner
        ? Positioned(
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
          )
        : Container();
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
                      (index) => MerchantItem(
                        onMerchantTap: () => _showPaymentBottomSheet(
                          onClose: () {
                            Navigator.pop(context);
                            isShowSheet = false;
                            controller!.resumeCamera();
                          },
                          id: '01401921312',
                        ),
                      ),
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
      if (!isShowSheet) {
        isShowSheet = true;
        this.controller!.pauseCamera();
        _showPaymentBottomSheet(
          onClose: () {
            Navigator.pop(context);
            isShowSheet = false;
            controller.resumeCamera();
          },
          id: scanData.code,
        );
      }
    });
  }

  _showPaymentBottomSheet({required VoidCallback onClose, required String id}) {
    showCupertinoModalBottomSheet(
      expand: false,
      context: context,
      enableDrag: false,
      isDismissible: false,
      topRadius: Radius.circular(20),
      backgroundColor: AppTheme.white,
      barrierColor: AppTheme.black.withOpacity(0.2),
      builder: (context) => PaymentSheet(
        onClose: onClose,
        id: id,
      ),
    );
  }
}

class PaymentSheet extends StatefulWidget {
  final String id;
  final VoidCallback onClose;

  const PaymentSheet({Key? key, required this.onClose, required this.id})
      : super(key: key);

  @override
  _PaymentSheetState createState() => _PaymentSheetState();
}

class _PaymentSheetState extends State<PaymentSheet> {
  double value = 5000;
  double sliderValue = 5000;
  final _formKey = GlobalKey<FormState>();
  final textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        padding: MediaQuery.of(context).viewInsets,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            color: AppTheme.scaffold,
          ),
          padding: EdgeInsets.all(20),
          child: Stack(
            children: [
              SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(64),
                        boxShadow: Helper.getShadow(),
                      ),
                      child: CustomNetworkImage(
                        imgUrl: Dummy.profileImg,
                        borderRadius: 64,
                        width: MediaQuery.of(context).size.width * 0.3,
                        height: MediaQuery.of(context).size.width * 0.3,
                      ),
                    ),
                    SizedBox(height: Helper.normalPadding),
                    Text('Chatime', style: AppTheme.headline3),
                    SizedBox(height: 8),
                    Text('SMK Negeri 1 Majalengka', style: AppTheme.text3),
                    SizedBox(height: 8),
                    Text(widget.id, style: AppTheme.text3.purple),
                    SizedBox(height: Helper.bigPadding),
                    SizedBox(height: Helper.normalPadding),
                    Align(
                      alignment: Alignment.centerLeft,
                      child:
                          Text('Mau Bayar Berapa?', style: AppTheme.headline3),
                    ),
                    SizedBox(height: Helper.normalPadding),
                    _slider(),
                    SizedBox(height: Helper.normalPadding),
                    SizedBox(height: Helper.normalPadding),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Jumlah Lainnya',
                          style: AppTheme.text3.purple.bold),
                    ),
                    SizedBox(height: 8),
                    _otherAmount(),
                    SizedBox(height: Helper.bigPadding),
                    SizedBox(height: Helper.bigPadding),
                    _totalAmount(),
                    SizedBox(height: Helper.normalPadding),
                    ConfirmationSlider(
                      text: 'Geser Untuk Bayar',
                      textStyle: AppTheme.text1.bold,
                      backgroundShape: BorderRadius.circular(12),
                      backgroundColor: AppTheme.yellow,
                      foregroundShape: BorderRadius.circular(12),
                      foregroundColor: AppTheme.purple,
                      width: MediaQuery.of(context).size.width - 40,
                      height: 56,
                      shadow: Helper.getShadow()[0],
                      onConfirmation: () {
                        showDialog(
                          context: context,
                          builder: (context) => InputPinDialog(),
                        );
                      },
                    ),
                    SizedBox(height: Helper.normalPadding),
                  ],
                ),
              ),
              Positioned(
                right: 0,
                top: 0,
                child: GestureDetector(
                  onTap: widget.onClose,
                  child: SvgPicture.asset(Resources.icClose),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _totalAmount() {
    return Row(
      children: [
        Expanded(
          child: Text('Total', style: AppTheme.text1),
        ),
        SizedBox(width: Helper.normalPadding),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              Resources.icFintchPoint,
            ),
            SizedBox(width: 8),
            Text(
              value.toStringAsFixed(0).parseCurrency(),
              style: AppTheme.text1,
            ),
          ],
        ),
      ],
    );
  }

  Widget _otherAmount() {
    return Form(
      key: _formKey,
      child: TextFormField(
        controller: textFieldController,
        style: AppTheme.text3.purple,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Harap masukan jumlah bayar';
          }
          final n = num.tryParse(value);
          if (n == null) {
            return '"$value" bukan bilangan!';
          } else if (double.parse(value) < 500) {
            return 'Input harus lebih dari 500';
          }
          return null;
        },
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        decoration: InputDecoration(
          hintStyle: AppTheme.text3.purpleOpacity,
          hintText: 'Masukin jumlah Fintch Point yang mau kamu transfer',
          focusedBorder: AppTheme.focusedBorder.copyWith(
            borderSide: BorderSide(color: AppTheme.purple),
          ),
          enabledBorder: AppTheme.enabledBorder.copyWith(
            borderSide: BorderSide(color: AppTheme.purpleOpacity),
          ),
        ),
        keyboardType: TextInputType.number,
        onChanged: (String text) {
          if (_formKey.currentState!.validate()) {
            setState(() {
              value = double.parse(text);
            });
          }
        },
      ),
    );
  }

  Widget _slider() {
    return FlutterSlider(
      values: [sliderValue],
      max: 20000,
      min: 500,
      maximumDistance: 20000,
      minimumDistance: 500,
      handlerAnimation: FlutterSliderHandlerAnimation(
          curve: Curves.elasticOut,
          reverseCurve: null,
          duration: Duration(milliseconds: 700),
          scale: 1.2),
      step: FlutterSliderStep(step: 500),
      decoration: BoxDecoration(
        color: AppTheme.purple,
        borderRadius: BorderRadius.circular(64),
        boxShadow: Helper.getShadow(),
      ),
      selectByTap: false,
      handler: FlutterSliderHandler(
        child: Container(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(Resources.icFintchPoint, height: 24),
              SizedBox(width: Helper.smallPadding),
              Text(
                (sliderValue / 1000).toStringAsFixed(1) + 'K',
                style: AppTheme.text1,
              ),
            ],
          ),
        ),
      ),
      handlerWidth: 100,
      handlerHeight: 40,
      trackBar: FlutterSliderTrackBar(
        activeDisabledTrackBarColor: AppTheme.white,
        inactiveDisabledTrackBarColor: AppTheme.white,
        activeTrackBar: BoxDecoration(
          color: AppTheme.yellow,
          borderRadius: BorderRadius.circular(4),
        ),
        inactiveTrackBar: BoxDecoration(
          color: AppTheme.darkYellow,
          borderRadius: BorderRadius.circular(4),
        ),
      ),
      tooltip: FlutterSliderTooltip(
        textStyle: AppTheme.headline3,
        boxStyle: FlutterSliderTooltipBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: Helper.getShadow(),
            color: AppTheme.white,
          ),
        ),
        positionOffset: FlutterSliderTooltipPositionOffset(top: -8),
        direction: FlutterSliderTooltipDirection.top,
      ),
      onDragging: (handlerIndex, lowerValue, upperValue) {
        setState(() {
          sliderValue = lowerValue;
          value = sliderValue;
          textFieldController.text = value.toStringAsFixed(0);
        });
      },
    );
  }
}

class InputPinDialog extends StatefulWidget {
  const InputPinDialog({Key? key}) : super(key: key);

  @override
  _InputPinDialogState createState() => _InputPinDialogState();
}

class _InputPinDialogState extends State<InputPinDialog> {
  TextEditingController inputPinController = TextEditingController();
  StreamController<ErrorAnimationType>? errorController;
  FocusNode? inputFocusNode;

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    inputFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    errorController?.close();
    inputFocusNode!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      title: 'Masukin PIN Kamu',
      content: CustomPinCode(
        pinController: inputPinController,
        errorController: errorController,
        focusNode: inputFocusNode,
        isDialog: true,
        isObscure: true,
        isAutoFocus: true,
        onChanged: (value) {},
        onCompleted: (value) {
          if (inputPinController.text.length < 6) {
            errorController!.add(ErrorAnimationType.shake);
            inputFocusNode?.requestFocus();
            Helper.snackBar(
              context,
              message: 'PIN harus 6 Digit!',
            );
            return;
          } else if (inputPinController.text != '111111') {
            inputPinController.clear();
            inputFocusNode?.requestFocus();
            errorController!.add(ErrorAnimationType.shake);
            Helper.snackBar(
              context,
              message: 'PIN tidak cocok!',
            );
            return;
          }
          Helper.unfocus();
          Navigator.of(context).pop();
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => SuccessPaymentDialog(),
          );
        },
      ),
    );
  }
}

class SuccessPaymentDialog extends StatefulWidget {
  const SuccessPaymentDialog({
    Key? key,
  }) : super(key: key);

  @override
  _SuccessPaymentDialogState createState() => _SuccessPaymentDialogState();
}

class _SuccessPaymentDialogState extends State<SuccessPaymentDialog> {
  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 4000)).then((_) {
      Navigator.of(context)
          .pushNamedAndRemoveUntil(PagePath.base, (route) => false);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      elevation: 2,
      insetPadding: EdgeInsets.all(Helper.normalPadding),
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
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Pembayaran Berhasil!!',
                style: AppTheme.headline3,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: Helper.normalPadding),
              LottieBuilder.asset(Resources.paymentSuccessful,
                  height: MediaQuery.of(context).size.height * 0.3),
              SizedBox(height: Helper.normalPadding),
              Row(
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          Resources.icFintchPoint,
                          height: 32,
                        ),
                        SizedBox(width: 8),
                        Text(
                          '- 8,000',
                          style: AppTheme.headline3.red,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          Resources.icFintchWallet,
                          height: 32,
                        ),
                        SizedBox(width: 8),
                        Text(
                          '56,000',
                          style: AppTheme.headline3,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: Helper.smallPadding),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    Resources.icExp,
                    height: 32,
                  ),
                  SizedBox(width: 8),
                  Text(
                    '+ 20',
                    style: AppTheme.headline3.green,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
