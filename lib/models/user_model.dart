import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String? id;
  String? name;
  String? username;
  String? img;
  String? status;
  String? workflowState;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  String? erpSite;
  String? erpToken;

  UserModel({
    this.id,
    this.name,
    this.username,
    this.status,
    this.workflowState,
    this.createdAt,
    this.updatedAt,
    this.img,
    this.v,
    this.erpSite,
    this.erpToken,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["_id"],
        name: json["name"],
        username: json["username"],
        img: json["img"],
        status: json["status"],
        workflowState: json["workflowState"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        erpSite: json["ErpSite"],
        erpToken: json["ErpToken"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "img": img,
        "username": username,
        "status": status,
        "workflowState": workflowState,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "ErpSite": erpSite,
        "ErpToken": erpToken,
      };
}
