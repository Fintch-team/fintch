
import 'package:fintch/gen_export.dart';
import 'package:fintch/service/micro/user_service.dart';

class LocalAuthService extends Service {
  static LocalAuthService? _instance;
  factory LocalAuthService() {
    _instance ??= LocalAuthService._();

    return _instance!;
  }

  final userService = UserService();
  LocalAuthService._();

  // bool get isSkipped {
  //   final val = (sharedPreferences.getBool('is_skipped') ?? false);
  //   final x = !isHasLoggedIn;
  //   return val && x;
  // }

  // void skipAuth() async {
  //   await sharedPreferences.setBool('is_skipped', true);
  // }

  // Future<void> saveUserSession(SignInResponse value) async {
  //   await sharedPreferences.setString(kTokenAccess, value.tokens!.access!);
  //   await sharedPreferences.setString(
  //       kTokenAccessExp, value.tokens!.accessExp!);
  //   await sharedPreferences.setString(kTokenRefresh, value.tokens!.refresh!);
  //   await sharedPreferences.setString(
  //       kTokenRefreshExp, value.tokens!.refreshExp!);
  //   await updateUserInformation(value.user!);
  // }

  // Future<void> updateUserInformation(User user) async {
  //   await sharedPreferences.setString(
  //       kUserInformation, json.encode(user.toJson()));
  // }

  // Future<void> saveUserInfomation(User value) async {
  //   await sharedPreferences.setString(
  //       kUserInformation, json.encode(value.toJson()));
  // }

  // Future<void> clear() async {
  //   await sharedPreferences.remove('is_skipped');
  //   await sharedPreferences.remove(kTokenAccess);
  //   await sharedPreferences.remove(kTokenAccessExp);
  //   await sharedPreferences.remove(kTokenRefresh);
  //   await sharedPreferences.remove(kTokenRefreshExp);
  //   await sharedPreferences.remove(kUserInformation);
  // }

  // User? get currentUser {
  //   final String? userJson = sharedPreferences.getString(kUserInformation);
  //   if (userJson != null) {
  //     return User.fromJson(json.decode(userJson));
  //   }

  //   return null;
  // }

  // String? get accessToken => sharedPreferences.getString(kTokenAccess);
  // bool get isAccessTokenExpired =>
  //     accessTokenExpired == null ||
  //     accessTokenExpired != null &&
  //         accessTokenExpired!.isBefore(DateTime.now());

  // Future<void> refreshAccessToken() async {
  //   try {
  //     if (isRefreshTokenExpired) {
  //       //await authRepository.handleCurrentUser();
  //       return;
  //     }

  //     final data = await userService.tokenRefresh(
  //       refreshToken: refreshToken!,
  //     );

  //     final String refresh = data['refresh'];
  //     final String refreshExp = data['refresh_exp'];
  //     final String access = data['access'];
  //     final String accessExp = data['access_exp'];

  //     await sharedPreferences.setString(kTokenAccess, access);
  //     await sharedPreferences.setString(kTokenAccessExp, accessExp);
  //     await sharedPreferences.setString(kTokenRefresh, refresh);
  //     await sharedPreferences.setString(kTokenRefreshExp, refreshExp);
  //   } catch (e) {
  //     clear();
  //   }
  // }

  // DateTime? get accessTokenExpired => accessToken == null
  //     ? null
  //     : DateTime.tryParse(sharedPreferences.getString(kTokenAccessExp) ?? '');

  // String? get refreshToken => sharedPreferences.getString(kTokenRefresh);
  // DateTime? get refreshTokenExpired => refreshToken == null
  //     ? null
  //     : DateTime.tryParse(sharedPreferences.getString(kTokenRefreshExp) ?? '');

  // bool get isRefreshTokenExpired =>
  //     refreshTokenExpired != null &&
  //     refreshTokenExpired!.isBefore(DateTime.now());

  // bool get isHasLoggedIn =>
  //     accessToken != null &&
  //     accessTokenExpired != null &&
  //     refreshTokenExpired != null &&
  //     accessTokenExpired!.isAfter(DateTime.now()) &&
  //     refreshTokenExpired!.isAfter(DateTime.now());
}
