

// To parse this JSON data, do
//
//     final commetsResponse = commetsResponseFromJson(jsonString);

import 'dart:convert';

List<CommetsResponse> commetsResponseFromJson(String str) => List<CommetsResponse>.from(json.decode(str).map((x) => CommetsResponse.fromJson(x)));

String commetsResponseToJson(List<CommetsResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CommetsResponse {
    final int postId;
    final int id;
    final String name;
    final String email;
    final String body;

    CommetsResponse({
        required this.postId,
        required this.id,
        required this.name,
        required this.email,
        required this.body,
    });

    factory CommetsResponse.fromJson(Map<String, dynamic> json) => CommetsResponse(
        postId: json["postId"],
        id: json["id"],
        name: json["name"],
        email: json["email"],
        body: json["body"],
    );

    Map<String, dynamic> toJson() => {
        "postId": postId,
        "id": id,
        "name": name,
        "email": email,
        "body": body,
    };
}
