import 'package:fintch/gen_export.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:screenshot/screenshot.dart';

class ReceivePage extends StatefulWidget {
  const ReceivePage({Key? key}) : super(key: key);

  @override
  State<ReceivePage> createState() => _ReceivePageState();
}

class _ReceivePageState extends State<ReceivePage> {
  late ScreenshotController _screenshotController;
  UserEntity? userEntity;

  @override
  void initState() {
    super.initState();
    _screenshotController = ScreenshotController();
    context.read<ReceiveBloc>().add(HomeInit());
  }

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      child: Scaffold(
        body: Background(
          child: SafeArea(
            child: Container(
              padding: EdgeInsets.all(Helper.normalPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: CustomAppBar(
                          title: 'QR Code Saya',
                        ),
                      ),
                      userEntity != null
                          ? Row(
                              children: [
                                SizedBox(width: Helper.smallPadding),
                                GestureDetector(
                                  onTap: () async {
                                    context.loaderOverlay.show();

                                    final image = await _screenshotController
                                        .captureFromWidget(
                                      QrCodeFile(
                                        context,
                                        title: userEntity!.name,
                                        subtitle1: userEntity!.school.name,
                                        subtitle2: userEntity!.nickname,
                                        data: userEntity!.nickname,
                                      ),
                                    );
                                    await Helper.shareImage(image);
                                    context.loaderOverlay.hide();
                                  },
                                  child: Icon(
                                    Icons.share_rounded,
                                    color: AppTheme.white,
                                  ),
                                ),
                                SizedBox(width: Helper.smallPadding),
                                GestureDetector(
                                  onTap: () async {
                                    context.loaderOverlay.show();
                                    final image = await _screenshotController
                                        .captureFromWidget(
                                      QrCodeFile(
                                        context,
                                        title: userEntity!.name,
                                        subtitle1: userEntity!.school.name,
                                        subtitle2: userEntity!.nickname,
                                        data: userEntity!.nickname,
                                      ),
                                    );
                                    await Helper.saveImage(
                                        image, userEntity!.nickname);
                                    context.loaderOverlay.hide();
                                  },
                                  child: Icon(
                                    Icons.download_rounded,
                                    color: AppTheme.white,
                                  ),
                                ),
                              ],
                            )
                          : Container(),
                    ],
                  ),
                  SizedBox(height: 20),
                  _userCard(context),
                ],
              ),
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
                  if (state is HomeSuccess) {
                    WidgetsBinding.instance!.addPostFrameCallback((_) {
                      setState(() {
                        userEntity = state.entity;
                      });
                    });
                  } else if (state is HomeFailure) {
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
                              boxShadow: Helper.getShadowPurpleBold(),
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
                              shadow: Helper.getShadowBold(),
                            ),
                          ),
                        ),
                      ],
                    );
                  } else if (state is HomeLoading) {
                    return ReceiveShimmer();
                  } else if (state is HomeFailure) {
                    return Container(
                      decoration: BoxDecoration(
                        boxShadow: Helper.getShadowPurpleBold(),
                        borderRadius: BorderRadius.circular(32),
                        color: AppTheme.scaffold,
                      ),
                      padding: EdgeInsets.all(20),
                      child:
                          FailureStateWidget(message: 'QR-Code Gagal di Load'),
                    );
                  }
                  return Container();
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
