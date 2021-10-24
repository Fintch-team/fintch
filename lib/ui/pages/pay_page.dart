import 'dart:async';
import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:fintch/gen_export.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:pattern_formatter/pattern_formatter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:slide_to_confirm/slide_to_confirm.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

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

    context.read<WalletBloc>().add(GetWallet());
    context.read<MerchantBloc>().add(GetMerchants());
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
              ) /* Container()*/,
            ),
          )
        : Container();
  }

  Widget _payScrollableSheet() {
    return Positioned.fill(
      child: SlidingUpPanel(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        color: AppTheme.scaffold,
        minHeight: MediaQuery.of(context).size.height * 0.44,
        maxHeight: MediaQuery.of(context).size.height * 0.88,
        onPanelOpened: () async {
          await controller?.pauseCamera();
        },
        onPanelSlide: (position) async {
          await controller?.pauseCamera();
        },
        onPanelClosed: () async {
          await controller?.resumeCamera();
        },
        panelBuilder: (scrollController) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              color: AppTheme.scaffold,
            ),
            child: SingleChildScrollView(
              controller: scrollController,
              physics: AlwaysScrollableScrollPhysics(),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _bottomSheetLine(context),
                  SizedBox(height: Helper.normalPadding),
                  _fintchPointAndBarrierCash(),
                  SizedBox(height: Helper.normalPadding),
                  SizedBox(height: Helper.normalPadding),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: Helper.normalPadding),
                    alignment: Alignment.centerLeft,
                    child: Text('Daftar Merchant', style: AppTheme.headline3),
                  ),
                  SizedBox(height: Helper.normalPadding),
                  BlocBuilder<MerchantBloc, MerchantState>(
                    builder: (context, state) {
                      if (state is MerchantSuccess) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: List.generate(
                            state.entity.data.length,
                            (index) => MerchantItem(
                              user: state.entity.data[index],
                              onMerchantTap: () => _showPaymentBottomSheet(
                                onClose: () {
                                  Navigator.pop(context);
                                  isShowSheet = false;
                                  controller!.resumeCamera();
                                },
                                nickname: state.entity.data[index].nickname,
                              ),
                            ),
                          ),
                        );
                      } else if (state is MerchantLoading) {
                        return MerchantsShimmer();
                      } else if (state is MerchantFailure) {
                        return FailureStateWidget(
                            message: 'Merchant List Gagal di Load!');
                      }
                      return Container();
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _fintchPointAndBarrierCash() {
    return BlocBuilder<WalletBloc, WalletState>(
      builder: (context, state) {
        if (state is WalletResponseSuccess) {
          int valueDiff = state.entity.barrierAmount - state.entity.payAmount;
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _fintchPoint(state.entity.walletAmount.toString()),
              SizedBox(height: Helper.smallPadding),
              _barrierCash(valueDiff.toString(), state.entity.barrierExpired),
            ],
          );
        } else if (state is WalletLoading) {
          return PayWalletShimmer();
        } else if (state is WalletFailure) {
          return FailureStateWidget(message: 'Wallet Gagal di Load!');
        }
        return Container();
      },
    );
  }

  Widget _fintchPoint(String amount) {
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
                  'Isi Fintch Point kamu',
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
                      amount.parseCurrency(),
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

  Widget _barrierCash(String barrierCash, DateTime? barrierExpired) {
    bool isBarrierExpired = false;
    if (barrierExpired != null) {
      if (barrierExpired.isAfter(DateTime.now())) {
        isBarrierExpired = true;
      }
    }

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
                    Expanded(
                      child: AutoSizeText(
                        isBarrierExpired
                            ? barrierCash.parseCurrency()
                            : 'Barrier cash tidak aktif',
                        style: AppTheme.headline1,
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(width: Helper.normalPadding),
          FeatureItem(
            name: 'Barrier Cash',
            assetName: Resources.icBarrierCash,
            onTap: () {
              showCupertinoModalBottomSheet(
                expand: false,
                context: context,
                enableDrag: true,
                isDismissible: true,
                topRadius: Radius.circular(20),
                backgroundColor: AppTheme.white,
                barrierColor: AppTheme.black.withOpacity(0.2),
                builder: (context) => BarrierCashSheet(),
              );
            },
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
          nickname: scanData.code,
        );
      }
    });
  }

  _showPaymentBottomSheet(
      {required VoidCallback onClose, required String nickname}) {
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
        nickname: nickname,
      ),
    );
  }
}

class PaymentSheet extends StatefulWidget {
  final String nickname;
  final VoidCallback onClose;

  const PaymentSheet({Key? key, required this.onClose, required this.nickname})
      : super(key: key);

  @override
  _PaymentSheetState createState() => _PaymentSheetState();
}

class _PaymentSheetState extends State<PaymentSheet> {
  double value = 5000;
  double sliderValue = 5000;
  final _formKey = GlobalKey<FormState>();
  late TextEditingController textFieldController;

  @override
  void initState() {
    super.initState();
    textFieldController = TextEditingController();
    textFieldController.text = value.doubleToThousand();
    context
        .read<ProfilePayBloc>()
        .add(GetReceiveByNickname(nickname: widget.nickname));
  }

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
              BlocConsumer<ProfilePayBloc, ProfilePayState>(
                listener: (context, state) async {
                  if (state is ProfilePayFailure) {
                    Helper.snackBar(context,
                        message: state.message, isFailure: true);
                  }
                },
                builder: (context, state) {
                  if (state is ProfilePaySuccess) {
                    return SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomNetworkImage(
                            imgUrl: state.entity.img,
                            borderRadius: 64,
                            width: MediaQuery.of(context).size.width * 0.3,
                            height: MediaQuery.of(context).size.width * 0.3,
                          ),
                          SizedBox(height: Helper.normalPadding),
                          Text(state.entity.name, style: AppTheme.headline3),
                          SizedBox(height: 8),
                          Text(state.entity.school.name, style: AppTheme.text3),
                          SizedBox(height: 8),
                          Text(state.entity.nickname,
                              style: AppTheme.text3.purple),
                          SizedBox(height: Helper.bigPadding),
                          SizedBox(height: Helper.normalPadding),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text('Mau Bayar Berapa?',
                                style: AppTheme.headline3),
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
                                builder: (context) => InputPinDialog(
                                  whenSuccess: () {
                                    context.read<PayBloc>().add(PostPay(
                                            entity: TransactionPostEntity(
                                          amount: textFieldController.text
                                              .thousandToDouble()
                                              .toString(),
                                          idReceive: widget.nickname,
                                        )));
                                  },
                                ),
                              );
                            },
                          ),
                          SizedBox(height: Helper.normalPadding),
                        ],
                      ),
                    );
                  } else if (state is ProfilePayLoading) {
                    return ReceiveSheetShimmer();
                  } else if (state is ProfilePayFailure) {
                    return FailureStateWidget(
                        message: 'Profile Pay Receive  Gagal di Load');
                  } else if (state is ProfilePayNotFound) {
                    return EmptyStateWidget(
                        message: 'User / Merchant tidak ditemukan :(');
                  }
                  return Container();
                },
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
        Text('Total', style: AppTheme.text1),
        SizedBox(width: Helper.normalPadding),
        Expanded(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SvgPicture.asset(
                Resources.icFintchPoint,
              ),
              SizedBox(width: 8),
              Flexible(
                child: AutoSizeText(
                  value.toStringAsFixed(0).parseCurrency(),
                  style: AppTheme.text1,
                  maxLines: 1,
                ),
              ),
            ],
          ),
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
          Validator.number(value);
          final n = value!.thousandToDouble();
          if (n == null) {
            return '"$value" bukan bilangan!';
          } else if (n < 500) {
            return 'Input harus lebih dari 500';
          }
          return null;
        },
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          ThousandsFormatter(),
        ],
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
              value = text.thousandToDouble() ?? 0;
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
          textFieldController.text = value.doubleToThousand();
        });
      },
    );
  }
}

class SuccessPaymentDialog extends StatefulWidget {
  final String fintchPoint;
  final String fintchWallet;

  const SuccessPaymentDialog({
    Key? key,
    required this.fintchPoint,
    required this.fintchWallet,
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
                          '-${widget.fintchPoint}',
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
                          widget.fintchWallet,
                          style: AppTheme.headline3,
                        ),
                      ],
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
}

class FailedPaymentDialog extends StatefulWidget {
  final String message;
  const FailedPaymentDialog({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  _FailedPaymentDialogState createState() => _FailedPaymentDialogState();
}

class _FailedPaymentDialogState extends State<FailedPaymentDialog> {
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
                'Pembayaran Gagal!!',
                style: AppTheme.headline3,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: Helper.normalPadding),
              LottieBuilder.asset(Resources.paymentFailed,
                  height: MediaQuery.of(context).size.height * 0.3),
              SizedBox(height: Helper.normalPadding),
              Text(
                widget.message,
                style: AppTheme.headline3,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
