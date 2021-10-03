import 'package:dio/dio.dart';
import 'package:fintch/gen_export.dart';

class UserService extends ApiService {
  UserService() : super('$kUrl/');

  Future<TokenModel> authWithNickname({
    required String user,
    required String pass,
  }) async {
    try {
      final res =
          await dio.post('auth', data: {'nickname': user, 'password': pass});
      // print(res.data['data']['user']);

      TokenModel result = TokenModel.fromJson(res.data);

      return result;
    } on DioError catch (e) {
      // print("error $e");
      throw e.type;
    }
  }

  Future<UserModel> changePassword(
      PostChangePassword postChangePassword) async {
    try {
      final res = await dio.post('/users/change-pass',
          data: postChangePassword.toJson());

      UserModel result = UserModel.fromJson(res.data);

      return result;
    } on DioError catch (e) {
      // print("error $e");
      throw e.type;
    }
  }

  Future<UserModel> changePin(PostChangePin postChangePin) async {
    try {
      final res =
          await dio.post('/users/change-pin', data: postChangePin.toJson());

      UserModel result = UserModel.fromJson(res.data);

      return result;
    } on DioError catch (e) {
      // print("error $e");
      throw e.type;
    }
  }

  Future<bool> authWithPin({required String user, required String pin}) async {
    try {
      final res =
          await dio.post('auth-pin', data: {'nickname': user, 'pin': pin});

      return res.statusCode == 200;
    } on DioError catch (e) {
      // print("error $e");
      throw e.type;
    }
  }

  Future<bool> logoutAuth() async {
    try {
      final res = await dio.delete('auth');

      return res.statusCode == 204;
    } on DioError catch (e) {
      // print("error $e");
      throw e.type;
    }
  }

  Future<TokenModel> refreshToken() async {
    try {
      final res = await dio.put('auth');

      return TokenModel.fromJson(res.data);
    } on DioError catch (e) {
      // print("error $e");
      throw e.type;
    }
  }

  Future<UserModel> authGet() async {
    try {
      final res = await dio.get('auth');

      return UserModel.fromJson(res.data);
    } on DioError catch (e) {
      // print("error $e");
      throw e.type;
    }
  }

  Future<UserModel> getUserId({
    required String id,
  }) async {
    try {
      final res = await dio.get(
        'users/$id',
      );

      return UserModel.fromJson(res.data);
    } on DioError catch (e) {
      // print("error $e");
      throw e.type;
    }
  }

  Future<ListUserModel> getUserAll() async {
    final res = await dio.get(
      'users',
    );

    return ListUserModel.fromJson(res.data);
  }

  Future<bool> postUser({
    required String nickname,
    required String password,
    required String name,
    required String idSchool,
    required String idWallet,
    required String level,
    required String pin,
  }) async {
    final res = await dio.post(
      'users',
      data: {
        'nickname': nickname,
        'password': password,
        'name': name,
        'id_school': idSchool,
        'id_wallet': idWallet,
        'level': level,
        'pin': pin,
      },
      queryParameters: {"with_wallet": "true"},
    );

    return res.statusCode == 201;
  }

  Future<bool> putUser({
    required String idUser,
    required String nickname,
    required String password,
    required String name,
    required String idSchool,
    required String idWallet,
    required String level,
    required String pin,
  }) async {
    final res = await dio.put(
      'users/$idUser',
      data: {
        'nickname': nickname,
        'password': password,
        'name': name,
        'id_school': idSchool,
        'id_wallet': idWallet,
        'level': level,
        'pin': pin,
      },
    );

    return res.statusCode == 200;
  }

  Future<bool> deleteUser({
    required String idUser,
  }) async {
    final res = await dio.delete(
      'users/$idUser',
    );

    return res.statusCode == 204;
  }
}
