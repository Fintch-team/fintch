import 'package:fintch/gen_export.dart';

class UserRepository {
  final UserService userService;
  final LocalAuthService localAuthService;

  UserRepository({required this.userService, required this.localAuthService});

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
    await userService.changePassword(postChangePassword);
    return;
  }

  Future<void> changePin(
      {required PostChangePinEntity postChangePinEntity}) async {
    final PostChangePin postChangePin = PostChangePin(
      nickname: postChangePinEntity.nickname,
      pin: postChangePinEntity.pin,
      password: postChangePinEntity.password,
    );
    await userService.changePin(postChangePin);
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

  Future<UserEntity> currentUser() async {
    try {
      return await authGet();
    } catch (e) {
      return DataMapper.localUserMapper(localAuthService.currentUser!);
    }
  }

  bool get isHasLoggedIn => localAuthService.isHasLoggedIn;

  int get userID => localAuthService.userId;
}
