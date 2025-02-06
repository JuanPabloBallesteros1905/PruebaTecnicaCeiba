// To parse this JSON data, do
//
//     final userModelResponse = userModelResponseFromJson(jsonString);

import 'dart:convert';

List<UserModelResponse> userModelResponseFromJson(String str) =>
    List<UserModelResponse>.from(
        json.decode(str).map((x) => UserModelResponse.fromJson(x)));

class UserModelResponse {
  final int id;
  final String name;

  final String email;

  final String phone;

  UserModelResponse({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
  });

  factory UserModelResponse.fromJson(Map<String, dynamic> json) =>
      UserModelResponse(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
      );
}
