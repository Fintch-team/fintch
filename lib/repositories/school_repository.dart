import 'package:fintch/gen_export.dart';

class SchoolRepository {
  final SchoolService schoolService;

  SchoolRepository({
    required this.schoolService,
  });

  Future<SchoolEntity> getPaySchool({required String id}) async {
    SchoolModel schoolModel = await schoolService.getSchoolId(id: id);

    return DataMapper.schoolMapper(schoolModel);
  }

  Future<bool> postSchool({required SchoolPostEntity postEntity}) async {
    bool res = await schoolService.postSchool(name: postEntity.name);

    return res;
  }

  Future<bool> editSchool({required SchoolPutEntity putEntity}) async {
    bool res = await schoolService.putSchool(
        idSchool: putEntity.idSchool, name: putEntity.name);

    return res;
  }

  Future<bool> deleteSchool({required String idSchool}) async {
    bool res = await schoolService.deleteSchool(idSchool: idSchool);

    return res;
  }
}
