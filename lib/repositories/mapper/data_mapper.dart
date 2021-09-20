import 'package:fintch/gen_export.dart';

class DataMapper {

  static AuthEntity authMapper(TokenModel tokenModel) => AuthEntity(
      accessToken: tokenModel.data.accessToken,
      tokenType: tokenModel.data.tokenType,
      expiresIn: tokenModel.data.expiresIn);
}
