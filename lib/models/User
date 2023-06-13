

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
    String id;
    String name;
    String username;
    String status;
    String workflowState;
    String? email;
    String? img;
    int? phone;
    DateTime createdAt;
    DateTime updatedAt;
    String? erpSite;
    String? erpToken;

    User({
        required this.id,
        required this.name,
        required this.username,
        required this.status,
        required this.workflowState,
        required this.email,
        required this.phone,
        required this.img,
        required this.createdAt,
        required this.updatedAt,
        required this.erpSite,
        required this.erpToken,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"],
        name: json["name"],
        username: json["username"],
        status: json["status"],
        workflowState: json["workflowState"],
        img: json["img"],
        phone: json["phone"],
        email: json["email"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        erpSite: json["ErpSite"],
        erpToken: json["ErpToken"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "username": username,
        "status": status,
        "workflowState": workflowState,
        "img": img,
        "phone": phone,
        "email": email,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "ErpSite": erpSite,
        "ErpToken": erpToken,
    };
}
