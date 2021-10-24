import 'package:fintch/gen_export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  void initState() {
    super.initState();

    context.read<SettingsBloc>().add(SettingsInit());
    context.read<BiometricBloc>().add(BiometricInit());
    context.read<WalletBloc>().add(GetWallet());
    context.read<InComeBloc>().add(GetIncomeMoneyManage());
  }

  @override
  Widget build(BuildContext context) {
    Helper.setDarkAppBar();
    return LoadingOverlay(
      child: Scaffold(
        body: Background(
          isWhite: true,
          child: SafeArea(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Container(
                padding: EdgeInsets.all(Helper.normalPadding),
                child: Column(
                  children: [
                    CustomAppBar(
                      title: 'Profile Saya',
                      isBlack: true,
                    ),
                    SizedBox(height: Helper.normalPadding),
                    _profileHeader(
                      context,
                    ),
                    SizedBox(height: Helper.normalPadding),
                    _statusUser(),
                    SizedBox(height: Helper.normalPadding),
                    _settings(),
                    SizedBox(height: Helper.normalPadding),
                    _supports(),
                    SizedBox(height: 56),
                    CustomButton(
                      text: 'Keluar',
                      onTap: () => showDialog(
                        context: context,
                        builder: (context) => _logoutDialog(context),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _profileHeader(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, state) {
        if (state is SettingsSuccess) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(64),
                  boxShadow: Helper.getShadow(),
                ),
                child: _ProfileImage(
                  img: state.entity.img,
                  loadingContext: context,
                ),
              ),
              SizedBox(height: Helper.normalPadding),
              Text(state.entity.name, style: AppTheme.headline3),
              SizedBox(height: 8),
              Text(state.entity.school.name, style: AppTheme.text3),
              SizedBox(height: 8),
              Text(state.entity.nickname, style: AppTheme.text3.purple),
            ],
          );
        } else if (state is SettingsLoading) {
          return ProfileShimmer();
        } else if (state is SettingsFailure) {
          return FailureStateWidget(message: 'Profile Gagal di Load!');
        }
        return Container();
      },
    );
  }

  Widget _statusUser() {
    return Container(
      padding: EdgeInsets.all(Helper.smallPadding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: Helper.getShadow(),
        color: AppTheme.white,
      ),
      child: Row(
        children: [
          BlocBuilder<WalletBloc, WalletState>(
            builder: (context, state) {
              if (state is WalletResponseSuccess) {
                return Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        Resources.icFintchWallet,
                        height: 28,
                      ),
                      SizedBox(width: 8),
                      Text(
                        state.entity.walletAmount.toString().parseCurrency(),
                        style: AppTheme.text1.bold,
                      ),
                    ],
                  ),
                );
              } else if (state is WalletLoading) {
                return ProfileWalletShimmer();
              } else if (state is WalletFailure) {
                return Text('Fintch Point Gagal di Load!',
                    style: AppTheme.text1.bold);
              }
              return Container();
            },
          ),
          SizedBox(width: 8),
          Container(
            width: 4,
            height: 24,
            decoration: BoxDecoration(
              color: AppTheme.purple,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          SizedBox(width: 8),
          BlocBuilder<InComeBloc, MoneyManageState>(
            builder: (context, state) {
              if (state is MoneyManageIncomeSuccess) {
                // TODO: harus ada nilai jumlah manage amount unutk d bawah
                int amount = state.entity.income - state.entity.outcome;
                return Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        Resources.fWalletPurple,
                        height: 28,
                      ),
                      SizedBox(width: 8),
                      Text(
                        amount.toString().parseCurrency(),
                        style: AppTheme.text1.bold,
                      ),
                    ],
                  ),
                );
              } else if (state is MoneyManageLoading) {
                return ProfileBalanceShimmer();
              } else if (state is MoneyManageFailure) {
                return FailureStateWidget(message: 'F-Wallet Gagal di Load!');
              }
              return Container();
            },
          ),
        ],
      ),
    );
  }

  Widget _settings() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Pengaturan', style: AppTheme.headline3),
        SizedBox(height: Helper.smallPadding),
        // GestureDetector(
        //   onTap: () => Navigator.pushReplacementNamed(
        //           context,
        //           PagePath.barcode,
        //         ),
        //   child: _optionItems('F-Barcode'),
        // ),
        GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) => InputPinDialog(
                whenSuccess: () => Navigator.pushNamed(
                  context,
                  PagePath.changePassword,
                ),
              ),
            );
          },
          child: _optionItems('Ganti Kata Sandi'),
        ),
        GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) => InputPinDialog(
                whenSuccess: () => Navigator.pushNamed(
                  context,
                  PagePath.changePin,
                ),
              ),
            );
          },
          child: _optionItems('Ganti Kata Pin'),
        ),
        BlocBuilder<BiometricBloc, SettingsState>(
          builder: (context, state) {
            if (state is SettingsBoolSuccess) {
              if (state.entity) {
                return GestureDetector(
                    onTap: () {
                      context.read<BiometricBloc>().add(BiometricAuth());
                    },
                    child: _optionItems('Biometric Auth'));
              }
              return SizedBox();
            } else if (state is SettingsFailure) {
              return SizedBox();
            }
            return SizedBox();
          },
        ),
        // _optionItems('Bahasa'),
      ],
    );
  }

  Widget _supports() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Dukungan', style: AppTheme.headline3),
        SizedBox(height: Helper.smallPadding),
        _optionItems('Tentang App'),
        _optionItems('Bantuan'),
        _optionItems('Kebijakan Privasi'),
        _optionItems('Syarat & Ketentuan'),
        _optionItems('Masukan & Saran'),
      ],
    );
  }

  Widget _optionItems(String optionTitle) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: Text(optionTitle, style: AppTheme.text2),
            ),
            SizedBox(width: 8),
            SvgPicture.asset(Resources.next),
          ],
        ),
        SizedBox(height: 16),
        Container(
          color: AppTheme.purpleOpacity,
          height: 0.8,
        ),
      ],
    );
  }

  Widget _logoutDialog(BuildContext context) {
    return CustomDialog(
      title: 'Keluar dari Fintch',
      content: Text('Yakin mau keluar?', style: AppTheme.text3),
      buttons: Row(
        children: [
          Flexible(
            child: CustomButton(
              onTap: () => Navigator.pop(context),
              text: 'Tidak',
            ),
          ),
          SizedBox(width: 20),
          Flexible(
            child: CustomButton(
              onTap: () {
                context.read<AuthBloc>().add(Logout());
                Navigator.pushNamedAndRemoveUntil(
                    context, PagePath.login, (route) => false);
              },
              text: 'Keluar',
              isOutline: true,
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileImage extends StatefulWidget {
  final String img;
  final BuildContext loadingContext;

  const _ProfileImage(
      {Key? key, required this.img, required this.loadingContext})
      : super(key: key);

  @override
  __ProfileImageState createState() => __ProfileImageState();
}

class __ProfileImageState extends State<_ProfileImage> {
  bool _isUploading = false;
  double? progress;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _isUploading
            ? CircularLoading()
            : CustomNetworkImage(
                imgUrl: widget.img,
                borderRadius: 64,
                height: MediaQuery.of(context).size.width * 0.28,
                width: MediaQuery.of(context).size.width * 0.28,
                shadow: Helper.getShadow(),
              ),
        Positioned(
          bottom: 0,
          right: 8,
          child: GestureDetector(
            onTap: () async {
              final file = await getImage(context: widget.loadingContext);
              if (file == null) return;
              setState(() {
                _isUploading = true;
              });

              context.read<SettingsBloc>().add(ChangeImgProfile(entity: file));

              // try {
              //   repository.updateUserImage(
              //     file: file,
              //     onSendProgress: (sent, total) {
              //       if (mounted) {
              //         setState(() {
              //           progress = sent.toDouble() / total.toDouble();
              //         });
              //       }
              //     },
              //   );
              // } finally {
              //   if (mounted) {
              //     setState(() {
              //       _isUploading = false;
              //     });
              //   }
              // }
            },
            child: ClipOval(
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.all(8),
                child: Icon(
                  Icons.camera_alt,
                  color: AppTheme.black,
                  size: 24,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
