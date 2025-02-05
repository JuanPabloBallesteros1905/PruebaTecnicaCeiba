



// To parse this JSON data, do
//
//     final userposts = userpostsFromJson(jsonString);

import 'dart:convert';

List<Userposts> userpostsFromJson(String str) => List<Userposts>.from(json.decode(str).map((x) => Userposts.fromJson(x)));

String userpostsToJson(List<Userposts> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Userposts {
    final int userId;
    final int id;
    final String title;
    final String body;

    Userposts({
        required this.userId,
        required this.id,
        required this.title,
        required this.body,
    });

    factory Userposts.fromJson(Map<String, dynamic> json) => Userposts(
        userId: json["userId"],
        id: json["id"],
        title: json["title"],
        body: json["body"],
    );

    Map<String, dynamic> toJson() => {
        "userId": userId,
        "id": id,
        "title": title,
        "body": body,
    };
}
