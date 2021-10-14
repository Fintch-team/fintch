import 'package:fintch/gen_export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

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
          SizedBox(height: MediaQuery.of(context).size.height * 0.06),
          Expanded(
            child: Container(
              child: BlocConsumer<ReceiveBloc, HomeState>(
                listener: (context, state) {
                  if (state is HomeFailure) {
                    Helper.snackBar(context,
                        message: state.message, isFailure: true);
                  }
                },
                builder: (context, state) {
                  if (state is HomeSuccess) {
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
                                  height:
                                      MediaQuery.of(context).size.width * 0.12,
                                ),
                                Text(state.entity.name,
                                    style: AppTheme.headline3),
                                SizedBox(height: 8),
                                Text(state.entity.school.name,
                                    style: AppTheme.text3),
                                SizedBox(height: 8),
                                Text(state.entity.nickname.toString(),
                                    style: AppTheme.text3.purple),
                                SizedBox(height: Helper.normalPadding),
                                Expanded(
                                  child: Center(
                                    child: PrettyQr(
                                      image: AssetImage(
                                          Resources.icFintchPointPng),
                                      size: MediaQuery.of(context).size.height *
                                          0.3,
                                      data: state.entity.nickname.toString(),
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
                              imgUrl: state.entity.img,
                              borderRadius: 64,
                              width: MediaQuery.of(context).size.width * 0.24,
                              height: MediaQuery.of(context).size.width * 0.24,
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                  return Center(child: CircularLoading());
                },
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
            onTap: () => Navigator.of(context).pushNamed(PagePath.topUp),
            isUpper: false,
          ),
        ],
      ),
    );
  }
}
