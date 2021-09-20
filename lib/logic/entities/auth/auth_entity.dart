import 'package:fintch/gen_export.dart';

class AuthPostEntity extends BaseEntity {
  final String nickname;
  final String password;

  AuthPostEntity({required this.nickname,required this.password});
}

class AuthEntity extends BaseEntity {
  final String accessToken;
  final String tokenType;
  final int expiresIn;

  AuthEntity({required this.accessToken, required this.tokenType, required this.expiresIn});
}
