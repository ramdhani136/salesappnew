// To parse this JSON data, do
//
//     final groupModel = groupModelFromJson(jsonString);

import 'dart:convert';

GroupModel groupModelFromJson(String str) =>
    GroupModel.fromJson(json.decode(str));

String groupModelToJson(GroupModel data) => json.encode(data.toJson());

class GroupModel {
  String? id;
  String? name;
  CreatedBy? parent;
  List<CreatedBy>? branch;
  CreatedBy? createdBy;
  String? status;
  String? workflowState;
  List<Child>? childs;

  GroupModel({
    this.id,
    this.name,
    this.parent,
    this.branch,
    this.createdBy,
    this.status,
    this.workflowState,
    this.childs,
  });

  factory GroupModel.fromJson(Map<String, dynamic> json) => GroupModel(
        id: json["_id"],
        name: json["name"],
        parent:
            json["parent"] == null ? null : CreatedBy.fromJson(json["parent"]),
        branch: json["branch"] == null
            ? []
            : List<CreatedBy>.from(
                json["branch"]!.map((x) => CreatedBy.fromJson(x))),
        createdBy: json["createdBy"] == null
            ? null
            : CreatedBy.fromJson(json["createdBy"]),
        status: json["status"],
        workflowState: json["workflowState"],
        childs: json["childs"] == null
            ? []
            : List<Child>.from(json["childs"]!.map((x) => Child.fromJson(x))),
      );

  static List<GroupModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => GroupModel.fromJson(json)).toList();
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "parent": parent?.toJson(),
        "branch": branch == null
            ? []
            : List<dynamic>.from(branch!.map((x) => x.toJson())),
        "createdBy": createdBy?.toJson(),
        "status": status,
        "workflowState": workflowState,
        "childs": childs == null
            ? []
            : List<dynamic>.from(childs!.map((x) => x.toJson())),
      };
}

class CreatedBy {
  String? id;
  String? name;

  CreatedBy({
    this.id,
    this.name,
  });

  factory CreatedBy.fromJson(Map<String, dynamic> json) => CreatedBy(
        id: json["_id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
      };
}

class Child {
  String? id;
  String? name;
  List<String>? branch;

  Child({
    this.id,
    this.name,
    this.branch,
  });

  factory Child.fromJson(Map<String, dynamic> json) => Child(
        id: json["_id"],
        name: json["name"],
        branch: json["branch"] == null
            ? []
            : List<String>.from(json["branch"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "branch":
            branch == null ? [] : List<dynamic>.from(branch!.map((x) => x)),
      };
}
