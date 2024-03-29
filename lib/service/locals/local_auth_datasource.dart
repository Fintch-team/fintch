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
    getStorage.write(KeyStorage.kToken, value.data.accessToken);
    getStorage.write(
        KeyStorage.kExpired, value.data.expiresIn.toIso8601String());
    getStorage.write(KeyStorage.kSetPass, value.data.user.isSetPass);
    getStorage.write(KeyStorage.kSetPin, value.data.user.isSetPin);
    getStorage.write(KeyStorage.kID, value.data.user.id);

    updateUserInformation(value.data.user);
  }

  Future<void> updateUserInformation(UserData user) async {
    getStorage.write(KeyStorage.kUserInformation, json.encode(user.toJson()));
  }

  Future<void> saveUserInfomation(UserData value) async {
    getStorage.write(KeyStorage.kUserInformation, json.encode(value.toJson()));
  }

  Future<void> saveBioLogin(
      {required String user, required String pass}) async {
    getStorage.write(KeyStorage.kUser, user);
    getStorage.write(KeyStorage.kPass, pass);
  }

  Future<void> clearBioLogin(
     ) async {
    getStorage.remove(KeyStorage.kUser);
    getStorage.remove(KeyStorage.kPass);
  }

  Future<void> clear() async {
    await getStorage.remove(KeyStorage.kToken);
    await getStorage.remove(KeyStorage.kExpired);
    await getStorage.remove(KeyStorage.kSetPass);
    await getStorage.remove(KeyStorage.kSetPin);
    await getStorage.remove(KeyStorage.kID);
    await getStorage.remove(KeyStorage.kUserInformation);
  }

  UserData? get currentUser {
    final String? userJson = getStorage.read(KeyStorage.kUserInformation);
    print(userJson);
    if (userJson != null) {
      return UserData.fromJson(json.decode(userJson));
    }

    return null;
  }

  String? get bioUser => getStorage.read(KeyStorage.kUser);
  String? get bioPass => getStorage.read(KeyStorage.kPass);
  
  bool? get isSetPass => getStorage.read(KeyStorage.kSetPass);
  bool? get isSetPin => getStorage.read(KeyStorage.kSetPin);
  int get userId => getStorage.read(KeyStorage.kID);

  String? get token => getStorage.read(KeyStorage.kToken);
  bool get isAccessTokenExpired =>
      accessTokenExpired == null ||
      accessTokenExpired != null &&
          accessTokenExpired!.isBefore(DateTime.now());

  DateTime? get accessTokenExpired => token == null
      ? null
      : DateTime.tryParse(getStorage.read(KeyStorage.kExpired));

  bool get isHasLoggedIn =>
      isSetPass != null &&
      isSetPin != null &&
      isSetPass! &&
      isSetPin! &&
      token != null &&
      accessTokenExpired != null &&
      isSetPass != null &&
      isSetPin != null &&
      accessTokenExpired!.isAfter(DateTime.now());
}
