import 'package:fintch/gen_export.dart';
import 'package:flutter/material.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

class BarcodeReceivePage extends StatefulWidget {
  final ArgumentBundle? bundle;

  const BarcodeReceivePage({Key? key, this.bundle}) : super(key: key);

  @override
  State<BarcodeReceivePage> createState() => _BarcodeReceivePageState();
}

class _BarcodeReceivePageState extends State<BarcodeReceivePage> {
  late BarcodeData barcode;

  @override
  void initState() {
    super.initState();
    // context.read<ReceiveBloc>().add(HomeInit());

    if (widget.bundle != null) {
      barcode = widget.bundle!.extras['barcode'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.all(Helper.normalPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CustomAppBar(
                  title: 'Transaksi Barcode ${barcode.name}',
                ),
                SizedBox(height: 20),
                _userCard(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Expanded _userCard(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.06),
          Expanded(
            child: Container(
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: Helper.getShadowBold(),
                        borderRadius: BorderRadius.circular(32),
                        color: AppTheme.scaffold,
                      ),
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.width * 0.12,
                          ),
                          Text(barcode.name, style: AppTheme.headline3),
                          SizedBox(height: 8),
                          Text('Rp' + barcode.amount.toString().parseCurrency(),
                              style: AppTheme.text1.purple),
                          SizedBox(height: 8),
                          Text(barcode.createdAt.parseHourDateAndMonth(),
                              style: AppTheme.text3),
                          SizedBox(height: Helper.normalPadding),
                          Expanded(
                            child: Center(
                              child: PrettyQr(
                                image: AssetImage(Resources.icFintchPointPng),
                                size: MediaQuery.of(context).size.height * 0.3,
                                data: barcode.id.toString(),
                                errorCorrectLevel: QrErrorCorrectLevel.M,
                                roundEdges: true,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 40),
          CustomButton(
            text: 'Scan QR Code',
            onTap: () => Navigator.of(context).pushNamed(PagePath.pay),
            isUpper: false,
          ),
          SizedBox(height: Helper.normalPadding),
          CustomButton(
            text: 'Top Up',
            onTap: () => Navigator.of(context)
                .pushNamed(PagePath.topUp)
                .setLightAppBar(),
            isUpper: false,
          ),
        ],
      ),
    );
  }
}
