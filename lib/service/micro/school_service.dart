import 'package:dio/dio.dart';
import 'package:fintch/gen_export.dart';
import 'package:flutter/foundation.dart';

class SchoolService extends ApiService {
  SchoolService() : super('$kUrl/');

  Future<SchoolModel> getSchoolId({
    required String id,
  }) async {
    try {
      final res = await dio.get(
        'school/$id',
      );

      return SchoolModel.fromJson(res.data);
    } on DioError catch (e) {
      debugPrint("error $e");
      throw e.error;
    }
  }

  Future<ListSchoolModel> getSchoolAll() async {
    try {
      final res = await dio.get(
        'school',
      );

      return ListSchoolModel.fromJson(res.data);
    } on DioError catch (e) {
      debugPrint("error $e");
      throw e.error;
    }
  }

  Future<bool> postSchool({
    required String name,
  }) async {
    try {
      final res = await dio.post(
        'school',
        data: {
          'name': name,
        },
      );

      return res.statusCode == 201;
    } on DioError catch (e) {
      debugPrint("error $e");
      throw e.error;
    }
  }

  Future<bool> putSchool({
    required String idSchool,
    required String name,
  }) async {
    try {
      final res = await dio.put(
        'school/$idSchool',
        data: {
          'name': name,
        },
      );

      return res.statusCode == 200;
    } on DioError catch (e) {
      debugPrint("error $e");
      throw e.error;
    }
  }

  Future<bool> deleteSchool({
    required String idSchool,
  }) async {
    try {
      final res = await dio.delete(
        'school/$idSchool',
      );

      return res.statusCode == 204;
    } on DioError catch (e) {
      debugPrint("error $e");
      throw e.error;
    }
  }
}
