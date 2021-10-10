import 'package:fintch/gen_export.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  void initState() {
    super.initState();

    context.read<SettingsBloc>().add(SettingsInit());
    context.read<WalletBloc>().add(GetWallet());
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
                child: CustomNetworkImage(
                  imgUrl: state.entity.img,
                  borderRadius: 64,
                  width: MediaQuery.of(context).size.width * 0.3,
                  height: MediaQuery.of(context).size.width * 0.3,
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
        }

        // TODO: state yg lain belum di implementasi
        return SizedBox();
      },
    );
  }

  Widget _statusUser() {
    return BlocBuilder<WalletBloc, WalletState>(
      builder: (context, state) {
        if (state is WalletResponseSuccess) {
          // TODO: get wallet tidak perlu list
          return Container(
            padding: EdgeInsets.all(Helper.smallPadding),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: Helper.getShadow(),
              color: AppTheme.white,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        Resources.fWalletPurple,
                        height: 28,
                      ),
                      SizedBox(width: 8),
                      Text(
                        state.entity.data.first.walletAmount
                            .toString()
                            .parseCurrency(),
                        style: AppTheme.text1.bold,
                      ),
                    ],
                  ),
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
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        Resources.icFintchWallet,
                        height: 28,
                      ),
                      SizedBox(width: 8),
                      Text(
                        state.entity.data.first.barrierAmount
                            .toString()
                            .parseCurrency(),
                        style: AppTheme.text1.bold,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }

        // TODO: state yg lain belum di implementasi
        return SizedBox();
      },
    );
  }

  Widget _settings() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Pengaturan', style: AppTheme.headline3),
        SizedBox(height: Helper.smallPadding),
        _optionItems('Notifikasi'),
        _optionItems('Ganti Kata Sandi'),
        _optionItems('Bahasa'),
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
              onTap: () => Navigator.pushNamedAndRemoveUntil(
                  context, PagePath.login, (route) => false),
              text: 'Keluar',
              isOutline: true,
            ),
          ),
        ],
      ),
    );
  }
}
