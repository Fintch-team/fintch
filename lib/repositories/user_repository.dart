import 'dart:io';

import 'package:fintch/gen_export.dart';

class UserRepository {
  final UserService userService;
  final LocalAuthService localAuthService;
  final BiometricAuthService biometricAuthService;

  UserRepository(
      {required this.userService,
      required this.localAuthService,
      required this.biometricAuthService});

  Future<AuthEntity> authWithNickname(
      {required AuthPostEntity authPostEntity}) async {
    TokenModel tokenModel = await userService.authWithNickname(
        user: authPostEntity.nickname, pass: authPostEntity.password);

    await localAuthService.saveUserSession(tokenModel);

    return DataMapper.authMapper(tokenModel);
  }

  Future<void> changePassword(
      {required PostChangePasswordEntity postChangePasswordEntity}) async {
    final PostChangePassword postChangePassword = PostChangePassword(
      nickname: postChangePasswordEntity.nickname,
      password: postChangePasswordEntity.password,
      passwordOld: postChangePasswordEntity.passwordOld,
    );

    UserModel res = await userService.changePassword(postChangePassword);

    await localAuthService.updateUserInformation(res.data);
    return;
  }

  Future<void> changePin(
      {required PostChangePinEntity postChangePinEntity}) async {
    final PostChangePin postChangePin = PostChangePin(
      nickname: postChangePinEntity.nickname,
      pin: postChangePinEntity.pin,
      password: postChangePinEntity.password,
    );
    UserModel res = await userService.changePin(postChangePin);

    await localAuthService.updateUserInformation(res.data);

    return;
  }

  Future<bool> authWithPin({required AuthPinPostEntity authPostEntity}) async {
    bool authPin = await userService.authWithPin(
      user: localAuthService.currentUser!.nickname,
      pin: authPostEntity.pin,
    );

    return authPin;
  }

  Future<bool> authLogout() async {
    bool logoutAuth = await userService.logoutAuth();

    return logoutAuth;
  }

  Future<AuthEntity> authRefresh() async {
    TokenModel tokenModel = await userService.refreshToken();

    await localAuthService.saveUserSession(tokenModel);

    return DataMapper.authMapper(tokenModel);
  }

  Future<UserEntity> authGet() async {
    UserModel userModel = await userService.authGet();

    await localAuthService.updateUserInformation(userModel.data);

    return DataMapper.userMapper(userModel);
  }

  Future<UserEntity> getByNickname({required String nickname}) async {
    UserModel userModel = await userService.getUserNickname(nickname: nickname);

    return DataMapper.userMapper(userModel);
  }

  Future<ListMerchantEntity> getMerchant() async {
    ListUserModel userModel = await userService.getMerchantAll();

    return DataMapper.listMerchantMapper(userModel);
  }

  Future<UserEntity> currentUser() async {
    try {
      return await authGet();
    } catch (e) {
      return DataMapper.localUserMapper(localAuthService.currentUser!);
    }
  }

  Future<bool> changeImgProfile({required File img}) async {
    return await userService.changeImgProfile(img: img);
  }

  Future<bool> hasBiometrics() async {
    return await biometricAuthService.hasBiometrics();
  }

  Future<bool> authBiometrics() async {
    return await biometricAuthService.authenticate();
  }

  Future<void> logout() {
    return localAuthService.clear();
  }

  bool get isHasLoggedIn => localAuthService.isHasLoggedIn;

  int get userID => localAuthService.userId;
}
