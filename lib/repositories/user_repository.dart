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

  Future<bool> authWithPin({required AuthPinPostEntity authPostEntity}) async {
    bool authPin = await userService.authWithPin(
      user: authPostEntity.nickname,
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

    return DataMapper.userMapper(userModel);
  }
}
