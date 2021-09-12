import 'package:fintch/presentation/routes/routes.dart';
import 'package:fintch/presentation/utils/utils.dart';
import 'package:fintch/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                _profileHeader(context),
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
    );
  }

  Widget _profileHeader(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
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
        SizedBox(height: Helper.normalPadding),
        Text('Adithya Firmansyah Putra', style: AppTheme.headline3),
        SizedBox(height: 8),
        Text('SMK Negeri 1 Majalengka', style: AppTheme.text3),
        SizedBox(height: 8),
        Text('19042138210', style: AppTheme.text3.purple),
      ],
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
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(Resources.icExp),
                SizedBox(width: 4),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Level 35',
                      style: AppTheme.text1.bold,
                    ),
                    SizedBox(height: 4),
                    Text(
                      '314/444 EXP',
                      style: AppTheme.text3.purpleOpacity,
                    ),
                  ],
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
                  height: 32,
                ),
                SizedBox(width: 8),
                Text(
                  '156,000',
                  style: AppTheme.text1.bold,
                ),
              ],
            ),
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