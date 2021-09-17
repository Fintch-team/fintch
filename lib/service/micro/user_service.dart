import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fintch/gen_export.dart';
import 'package:flutter/foundation.dart';

class UserService extends ApiService {
  UserService() : super('$kUrl/');

  Future<TokenModel> signWithNickname({
    required String user,
    required String pass,
  }) async {
    final res = await dio.post('auth',data: {
      'nickname': user,
      'password': pass
    });

    return TokenModel.fromJson(res.data);
  }
}
