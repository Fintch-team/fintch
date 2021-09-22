class Pay {
  Pay({
    required this.nickname,
    required this.name,
  });

  String nickname;
  String name;

  factory Pay.fromJson(Map<String, dynamic> json) => Pay(
        nickname: json["nickname"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "nickname": nickname,
        "name": name,
      };
}
