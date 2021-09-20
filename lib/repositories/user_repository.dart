import 'package:fintch/gen_export.dart';
import 'package:fintch/repositories/data_mapper.dart';

class UserRepository {
  final UserService userService;

  UserRepository({required this.userService});

  Future<AuthEntity> authWithNickname(
      {required AuthPostEntity authPostEntity}) async {
    TokenModel tokenModel = await userService.authWithNickname(
        user: authPostEntity.nickname, pass: authPostEntity.password);
    return DataMapper.authMapper(tokenModel);
  }
}
