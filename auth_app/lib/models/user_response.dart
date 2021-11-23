// To parse this JSON data, do
//
//     final userResponse = userResponseFromJson(jsonString);

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
    ok: json["ok"] == null ? null : json["ok"],
    googleUser: json["googleUser"] == null ? null : GoogleUser.fromJson(json["googleUser"]),
  );

  Map<String, dynamic> toJson() => {
    "ok": ok == null ? null : ok,
    "googleUser": googleUser == null ? null : googleUser?.toJson(),
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
    name: json["name"] == null ? null : json["name"],
    picture: json["picture"] == null ? null : json["picture"],
    email: json["email"] == null ? null : json["email"],
  );

  Map<String, dynamic> toJson() => {
    "name": name == null ? null : name,
    "picture": picture == null ? null : picture,
    "email": email == null ? null : email,
  };
}
