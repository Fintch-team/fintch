import 'package:fintch/gen_export.dart';

class SchoolPostEntity extends BaseEntity {
  final String name;

  SchoolPostEntity({required this.name});
}

class SchoolPutEntity extends BaseEntity {
  final String idSchool;
  final String name;

  SchoolPutEntity({required this.idSchool, required this.name});
}

class SchoolEntity extends BaseEntity {
  final int id;
  final String name;

  SchoolEntity({required this.id, required this.name});
}

class ListSchoolEntity extends BaseEntity {
  final List<SchoolData> data;

  ListSchoolEntity({
    required this.data,
  });
}
