import 'package:fintch/gen_export.dart';

class ListSchoolModel {
  ListSchoolModel({
    required this.message,
    required this.details,
    required this.data,
    required this.meta,
  });

  String message;
  dynamic details;
  List<SchoolData> data;
  Meta meta;

  factory ListSchoolModel.fromJson(Map<String, dynamic> json) =>
      ListSchoolModel(
        message: json["message"],
        details: json["details"],
        data: List<SchoolData>.from(
            json["data"].map((x) => SchoolData.fromJson(x))),
        meta: Meta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "details": details,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "meta": meta.toJson(),
      };
}
