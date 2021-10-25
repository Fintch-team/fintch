import 'package:fintch/gen_export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  Widget _userCard(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.06),
          Expanded(
            child: Container(
              child: _buildBloc(),
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

  Widget _buildBloc() {
    return BlocConsumer<ReceiveBloc, HomeState>(
      listener: (context, state) {
        if (state is HomeFailure) {
          Helper.snackBar(context, message: state.message, isFailure: true);
        }
      },
      builder: (context, state) {
        if (state is HomeSuccess) {
          return _buildUserBarcode(context, state.entity);
        }
        return Center(child: CircularLoading());
      },
    );
  }

  Widget _buildUserBarcode(BuildContext context, UserEntity entity) {
    return Stack(
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
                Text(entity.name, style: AppTheme.headline3),
                SizedBox(height: 8),
                Text(entity.school.name, style: AppTheme.text3),
                SizedBox(height: 8),
                Text(entity.nickname.toString(), style: AppTheme.text3.purple),
                SizedBox(height: Helper.normalPadding),
                _buildBarcode(context, entity.nickname.toString()),
              ],
            ),
          ),
        ),
        Positioned(
          top: -MediaQuery.of(context).size.width * 0.12,
          child: CustomNetworkImage(
            imgUrl: entity.img,
            borderRadius: 64,
            width: MediaQuery.of(context).size.width * 0.24,
            height: MediaQuery.of(context).size.width * 0.24,
          ),
        ),
      ],
    );
  }

  Widget _buildBarcode(BuildContext context, String barcode) {
    // Text(name, style: AppTheme.headline3),
    // SizedBox(height: 8),
    return Container(
      padding: EdgeInsets.all(20),
      child: Center(
        child: PrettyQr(
          image: AssetImage(Resources.icFintchPointPng),
          size: MediaQuery.of(context).size.height * 0.3,
          data: barcode,
          errorCorrectLevel: QrErrorCorrectLevel.M,
          roundEdges: true,
        ),
      ),
    );
  }
}
