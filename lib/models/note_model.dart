import 'dart:convert';

NoteModel noteModelFromJson(String str) => NoteModel.fromJson(json.decode(str));

String noteModelToJson(NoteModel data) => json.encode(data.toJson());

class NoteModel {
  String? id;
  String? task;
  Doc? doc;
  Branch? customer;
  Branch? topic;
  List<Branch>? tags;
  String? result;
  Branch? createdBy;
  DateTime? createdAt;
  DateTime? updatedAt;
  Branch? customerGroup;
  Branch? branch;

  NoteModel({
    this.id,
    this.task,
    this.doc,
    this.customer,
    this.topic,
    this.tags,
    this.result,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
    this.customerGroup,
    this.branch,
  });

  factory NoteModel.fromJson(Map<String, dynamic> json) => NoteModel(
        id: json["_id"],
        task: json["task"],
        doc: json["doc"] == null ? null : Doc.fromJson(json["doc"]),
        customer:
            json["customer"] == null ? null : Branch.fromJson(json["customer"]),
        topic: json["topic"] == null ? null : Branch.fromJson(json["topic"]),
        tags: json["tags"] == null
            ? []
            : List<Branch>.from(json["tags"]!.map((x) => Branch.fromJson(x))),
        result: json["result"],
        createdBy: json["createdBy"] == null
            ? null
            : Branch.fromJson(json["createdBy"]),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        customerGroup: json["customerGroup"] == null
            ? null
            : Branch.fromJson(json["customerGroup"]),
        branch: json["branch"] == null ? null : Branch.fromJson(json["branch"]),
      );

  static List<NoteModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) {
      return NoteModel.fromJson(json);
    }).toList();
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "task": task,
        "doc": doc?.toJson(),
        "customer": customer?.toJson(),
        "topic": topic?.toJson(),
        "tags": tags == null
            ? []
            : List<dynamic>.from(tags!.map((x) => x.toJson())),
        "result": result,
        "createdBy": createdBy?.toJson(),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "customerGroup": customerGroup?.toJson(),
        "branch": branch?.toJson(),
      };
}

class Branch {
  String? id;
  String? name;

  Branch({
    this.id,
    this.name,
  });

  factory Branch.fromJson(Map<String, dynamic> json) => Branch(
        id: json["_id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
      };
}

class Doc {
  String? type;
  String? id;
  String? name;

  Doc({
    this.type,
    this.id,
    this.name,
  });

  factory Doc.fromJson(Map<String, dynamic> json) => Doc(
        type: json["type"],
        id: json["_id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "_id": id,
        "name": name,
      };
}
