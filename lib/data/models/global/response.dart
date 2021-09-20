class ResponseGlobal {
  ResponseGlobal({
    required this.message,
    required this.status,
  });

  String message;
  int status;

  factory ResponseGlobal.fromJson(Map<String, dynamic> json) => ResponseGlobal(
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
      };
}
