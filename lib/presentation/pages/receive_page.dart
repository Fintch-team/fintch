import 'package:cached_network_image/cached_network_image.dart';
import 'package:fintch/presentation/utils/utils.dart';
import 'package:fintch/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

class ReceivePage extends StatelessWidget {
  const ReceivePage({Key? key}) : super(key: key);

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
                _appBar(context),
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
          Container(
            height: MediaQuery.of(context).size.height * 0.6,
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
                        Text('Adithya Firmansyah Putra',
                            style: AppTheme.headline3),
                        SizedBox(height: 8),
                        Text('SMK Negeri 1 Majalengka', style: AppTheme.text3),
                        SizedBox(height: 8),
                        Text('19042138210', style: AppTheme.text3.purple),
                        SizedBox(height: 20),
                        Expanded(
                          child: Center(
                            child: PrettyQr(
                              image: AssetImage(Resources.icFintchPointPng),
                              size: MediaQuery.of(context).size.height * 0.3,
                              data: '19042138210-1420193',
                              errorCorrectLevel: QrErrorCorrectLevel.M,
                              roundEdges: true,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: -MediaQuery.of(context).size.width * 0.12,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.24,
                    height: MediaQuery.of(context).size.width * 0.24,
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
                ),
              ],
            ),
          ),
          SizedBox(height: 40),
          CustomButton(
            text: 'Scan QR Code',
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _appBar(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: SvgPicture.asset(Resources.back),
        ),
        SizedBox(width: 20),
        Text('QR Code Saya', style: AppTheme.text1.white.bold),
      ],
    );
  }
}
