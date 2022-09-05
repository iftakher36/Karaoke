// To parse this JSON data, do
//
//     final userInfo = userInfoFromJson(jsonString);

import 'dart:convert';

class UserInfo {
  UserInfo({
    required this.accessToken,
    required this.user,
    required this.tokenType,
  });

  String accessToken;
  User user;
  String tokenType;

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
        accessToken: json["access_token"],
        user: User.fromJson(json["user"]),
        tokenType: json["token_type"],
      );

  Map<String, dynamic> toJson() => {
        "access_token": accessToken,
        "user": user.toJson(),
        "token_type": tokenType,
      };
}

class User {
  User({
    required this.id,
    required this.name,
    required this.email,
    required this.emailVerifiedAt,
    required this.mobile,
    required this.address,
    required this.remarks,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String name;
  String email;
  dynamic emailVerifiedAt;
  String mobile;
  dynamic address;
  dynamic remarks;
  String status;
  DateTime createdAt;
  DateTime updatedAt;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        mobile: json["mobile"],
        address: json["address"],
        remarks: json["remarks"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "mobile": mobile,
        "address": address,
        "remarks": remarks,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
