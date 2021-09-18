class User {
  User({
    required this.nickname,
    required this.name,
  });

  String nickname;
  String name;

  factory User.fromJson(Map<String, dynamic> json) => User(
        nickname: json["nickname"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "nickname": nickname,
        "name": name,
      };
}
