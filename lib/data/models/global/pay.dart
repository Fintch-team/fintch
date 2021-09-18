class Pay {
  Pay({
    required this.nickname,
    required this.name,
    required this.idSchool,
    required this.idWallet,
  });

  String nickname;
  String name;
  int idSchool;
  int idWallet;

  factory Pay.fromJson(Map<String, dynamic> json) => Pay(
        nickname: json["nickname"],
        name: json["name"],
        idSchool: json["id_school"],
        idWallet: json["id_wallet"],
      );

  Map<String, dynamic> toJson() => {
        "nickname": nickname,
        "name": name,
        "id_school": idSchool,
        "id_wallet": idWallet,
      };
}
