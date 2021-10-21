import 'package:fintch/gen_export.dart';

class AuthPostEntity extends BaseEntity {
  final String nickname;
  final String password;

  AuthPostEntity({required this.nickname, required this.password});
}

class PostChangePasswordEntity extends BaseEntity {
  final String nickname;
  final String password;
  final String passwordOld;

  PostChangePasswordEntity(
      {required this.nickname,
      required this.password,
      required this.passwordOld});
}

class PostChangePinEntity extends BaseEntity {
  final String nickname;
  final String pin;
  final String password;

  PostChangePinEntity(
      {required this.nickname, required this.password, required this.pin});
}

class AuthEntity extends BaseEntity {
  final String accessToken;
  final String tokenType;
  final DateTime expiresIn;
  final bool isSetPass;
  final bool isSetPin;

  AuthEntity(
      {required this.accessToken,
      required this.tokenType,
      required this.isSetPass,
      required this.isSetPin,
      required this.expiresIn});
}

class AuthPinPostEntity extends BaseEntity {
  // final String nickname;
  final String pin;

  AuthPinPostEntity({
    // required this.nickname,
    required this.pin,
  });
}

class UserEntity extends BaseEntity {
  final int id;
  final String name;
  final String nickname;
  final String level;
  final String img;
  final WalletData wallet;
  final SchoolData school;
  final List<BarcodeData> barcode;
  final List<MoneyPlanData> moneyPlanning;
  final List<MoneyManageData> moneyManage;
  final List<HistoryData> receive;
  final List<HistoryData> pay;

  UserEntity(
      {required this.id,
      required this.name,
      required this.nickname,
      required this.level,
      required this.img,
      required this.wallet,
      required this.school,
      required this.barcode,
      required this.moneyManage,
      required this.moneyPlanning,
      required this.receive,
      required this.pay});
}

class ListMerchantEntity extends BaseEntity {
  final List<UserData> data;

  ListMerchantEntity({
    required this.data,
  });
}
