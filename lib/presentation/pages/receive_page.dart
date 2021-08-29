import 'package:fintch/presentation/utils/utils.dart';
import 'package:fintch/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
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
                CustomAppBar(
                  title: 'QR Code Saya',
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
                        SizedBox(height: Helper.normalPadding),
                        Expanded(
                          child: Center(
                            child: PrettyQr(
                              image: AssetImage(Resources.icFintchPointPng),
                              size: MediaQuery.of(context).size.height * 0.3,
                              data: '19042138210',
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
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(64),
                      boxShadow: Helper.getShadow(),
                    ),
                    child: CustomNetworkImage(
                      imgUrl: Dummy.profileImg,
                      borderRadius: 64,
                      width: MediaQuery.of(context).size.width * 0.24,
                      height: MediaQuery.of(context).size.width * 0.24,
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
}
