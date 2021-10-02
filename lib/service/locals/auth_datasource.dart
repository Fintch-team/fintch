import 'dart:convert';

import 'package:fintch/gen_export.dart';
import 'package:fintch/service/micro/user_service.dart';
import 'package:fintch/utils/utils.exports.dart';

class LocalAuthService extends Service {
  static LocalAuthService? _instance;
  factory LocalAuthService() {
    _instance ??= LocalAuthService._();

    return _instance!;
  }

  final userService = UserService();
  LocalAuthService._();

  Future<void> saveUserSession(TokenModel value) async {
    getStorage.write(KeyStorage.kToken, value.data!.accessToken);
    getStorage.write(
        KeyStorage.kExpired, value.data!.expiresIn.toIso8601String());

    updateUserInformation(value.data!.user);
  }

  Future<void> updateUserInformation(DataUser user) async {
    getStorage.write(KeyStorage.kUserInformation, json.encode(user.toJson()));
  }

  Future<void> saveUserInfomation(DataUser value) async {
    getStorage.write(KeyStorage.kUserInformation, json.encode(value.toJson()));
  }

  Future<void> clear() async {
    getStorage.remove(KeyStorage.kToken);
    getStorage.remove(KeyStorage.kExpired);
  }

  DataUser? get currentUser {
    final String? userJson = getStorage.read(KeyStorage.kUserInformation);
    if (userJson != null) {
      return DataUser.fromJson(json.decode(userJson));
    }

    return null;
  }

  String? get token => getStorage.read(KeyStorage.kToken);
  bool get isAccessTokenExpired =>
      accessTokenExpired == null ||
      accessTokenExpired != null &&
          accessTokenExpired!.isBefore(DateTime.now());

  DateTime? get accessTokenExpired => token == null
      ? null
      : DateTime.tryParse(getStorage.read(KeyStorage.kExpired));

  bool get isHasLoggedIn =>
      token != null &&
      accessTokenExpired != null &&
      accessTokenExpired!.isAfter(DateTime.now());
}
