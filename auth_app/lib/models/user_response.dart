import 'dart:convert';

UserResponse userResponseFromJson(String str) => UserResponse.fromJson(json.decode(str));

String userResponseToJson(UserResponse data) => json.encode(data.toJson());

class UserResponse {
  UserResponse({
    this.ok,
    this.googleUser,
  });

  bool? ok;
  GoogleUser? googleUser;

  factory UserResponse.fromJson(Map<String, dynamic> json) => UserResponse(
    ok: json["ok"],
    googleUser: json["googleUser"] == null ? null : GoogleUser.fromJson(json["googleUser"]),
  );

  Map<String, dynamic> toJson() => {
    "ok": ok,
    "googleUser": googleUser?.toJson(),
  };
}

class GoogleUser {
  GoogleUser({
    this.name,
    this.picture,
    this.email,
  });

  String? name;
  String? picture;
  String? email;

  factory GoogleUser.fromJson(Map<String, dynamic> json) => GoogleUser(
    name: json["name"],
    picture: json["picture"],
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "picture": picture,
    "email": email,
  };
}
