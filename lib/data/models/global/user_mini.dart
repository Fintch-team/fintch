class UserMini {
  UserMini({
    required this.id,
    required this.name,
    required this.nickname,
    required this.img,
  });

  int id;
  String name;
  String nickname;
  String img;

  factory UserMini.fromJson(Map<String, dynamic> json) => UserMini(
        id: json["id"],
        name: json["name"],
        nickname: json["nickname"],
        img: json["img"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "nickname": nickname,
        "img": img,
      };
}
