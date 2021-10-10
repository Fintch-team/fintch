import 'package:fintch/gen_export.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:provider/src/provider.dart';

import 'package:loader_overlay/loader_overlay.dart';

class ReceivePage extends StatefulWidget {
  const ReceivePage({Key? key}) : super(key: key);

  @override
  State<ReceivePage> createState() => _ReceivePageState();
}

class _ReceivePageState extends State<ReceivePage> {
  @override
  void initState() {
    super.initState();
    context.read<ReceiveBloc>().add(HomeInit());
  }

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      child: BlocConsumer<ReceiveBloc, HomeState>(
        listener: (context, state) {
          if (state is HomeLoading) {
            context.loaderOverlay.show();
          } else if (state is HomeFailure) {
            context.loaderOverlay.hide();
            Helper.snackBar(context, message: state.message, isFailure: true);
          } else if (state is HomeSuccess) {
            context.loaderOverlay.hide();
          }
        },
        builder: (context, state) {
          if (state is HomeSuccess) {
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
                        _userCard(context, state.entity),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Expanded _userCard(BuildContext context, UserEntity user) {
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
                        Text(user.name, style: AppTheme.headline3),
                        SizedBox(height: 8),
                        Text(user.school.name, style: AppTheme.text3),
                        SizedBox(height: 8),
                        Text(user.id.toString(), style: AppTheme.text3.purple),
                        SizedBox(height: Helper.normalPadding),
                        Expanded(
                          child: Center(
                            child: PrettyQr(
                              image: AssetImage(Resources.icFintchPointPng),
                              size: MediaQuery.of(context).size.height * 0.3,
                              data: user.id.toString(),
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
