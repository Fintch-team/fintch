import 'package:fintch/gen_export.dart';

class AuthPostEntity extends BaseEntity {
  final String nickname;
  final String password;

  AuthPostEntity({required this.nickname, required this.password});
}

class AuthEntity extends BaseEntity {
  final String accessToken;
  final String tokenType;
  final DateTime expiresIn;

  AuthEntity(
      {required this.accessToken,
      required this.tokenType,
      required this.expiresIn});
}

class AuthPinPostEntity extends BaseEntity {
  final String nickname;
  final String pin;

  AuthPinPostEntity({required this.nickname, required this.pin});
}

class UserEntity extends BaseEntity {
  final int id;
  final String name;
  final String nickname;
  final Wallet wallet;
  final Datum school;
  final List<MoneyPlanning> moneyPlanning;
  final List<Datum> receive;
  final List<Datum> pay;

  UserEntity(
      {required this.id,
      required this.name,
      required this.nickname,
      required this.wallet,
      required this.school,
      required this.moneyPlanning,
      required this.receive,
      required this.pay});
}
