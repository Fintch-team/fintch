import 'package:dio/dio.dart';
import 'package:fintch/gen_export.dart';

class SchoolService extends ApiService {
  SchoolService() : super('$kUrl/');

  Future<SchoolModel> getSchoolId({
    required String id,
  }) async {
    final res = await dio.get(
      'school/$id',
    );

    return SchoolModel.fromJson(res.data);
  }

  Future<ListSchoolModel> getSchoolAll() async {
    final res = await dio.get(
      'school',
    );

    return ListSchoolModel.fromJson(res.data);
  }

  Future<bool> postSchool({
    required String name,
  }) async {
    final res = await dio.post(
      'school',
      data: {
        'name': name,
      },
    );

    return res.statusCode == 201;
  }

  Future<bool> putSchool({
    required String idSchool,
    required String name,
  }) async {
    final res = await dio.put(
      'school/$idSchool',
      data: {
        'name': name,
      },
    );

    return res.statusCode == 200;
  }

  Future<bool> deleteSchool({
    required String idSchool,
  }) async {
    final res = await dio.delete(
      'school/$idSchool',
    );

    return res.statusCode == 204;
  }
}
