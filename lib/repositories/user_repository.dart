import 'package:fintch/gen_export.dart';
import 'package:fintch/repositories/mapper/data_mapper.dart';

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
}
