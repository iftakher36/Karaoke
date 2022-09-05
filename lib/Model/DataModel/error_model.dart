// To parse this JSON data, do
//
//     final errorModel = errorModelFromJson(jsonString);

import 'dart:convert';

ErrorModel errorModelFromJson(dynamic str) => ErrorModel.fromJson(str);

String errorModelToJson(ErrorModel data) => json.encode(data.toJson());

class ErrorModel {
  ErrorModel({
    required this.message,
    required this.errors,
  });

  String message;
  String errors;

  factory ErrorModel.fromJson(Map<String, dynamic> json) => ErrorModel(
        message: json["message"],
        errors: json["errors"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "errors": errors,
      };
}
