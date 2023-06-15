import 'dart:convert';

Memo memoFromJson(String str) => Memo.fromJson(json.decode(str));

String memoToJson(Memo data) => json.encode(data.toJson());

class Memo {
  String id;
  String name;
  List<String> display;
  String title;
  String notes;
  String status;
  String workflowState;
  DateTime activeDate;
  DateTime closingDate;
  List<dynamic> branch;
  List<dynamic> customerGroup;
  List<dynamic> userGroup;
  CreatedBy createdBy;
  DateTime createdAt;
  DateTime updatedAt;

  Memo({
    required this.id,
    required this.name,
    required this.display,
    required this.title,
    required this.notes,
    required this.status,
    required this.workflowState,
    required this.activeDate,
    required this.closingDate,
    required this.branch,
    required this.customerGroup,
    required this.userGroup,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Memo.fromJson(Map<String, dynamic> json) => Memo(
        id: json["_id"],
        name: json["name"],
        display: List<String>.from(json["display"].map((x) => x)),
        title: json["title"],
        notes: json["notes"],
        status: json["status"],
        workflowState: json["workflowState"],
        activeDate: DateTime.parse(json["activeDate"]),
        closingDate: DateTime.parse(json["closingDate"]),
        branch: List<dynamic>.from(json["branch"].map((x) => x)),
        customerGroup: List<dynamic>.from(json["customerGroup"].map((x) => x)),
        userGroup: List<dynamic>.from(json["userGroup"].map((x) => x)),
        createdBy: CreatedBy.fromJson(json["createdBy"]),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "display": List<dynamic>.from(display.map((x) => x)),
        "title": title,
        "notes": notes,
        "status": status,
        "workflowState": workflowState,
        "activeDate": activeDate.toIso8601String(),
        "closingDate": closingDate.toIso8601String(),
        "branch": List<dynamic>.from(branch.map((x) => x)),
        "customerGroup": List<dynamic>.from(customerGroup.map((x) => x)),
        "userGroup": List<dynamic>.from(userGroup.map((x) => x)),
        "createdBy": createdBy.toJson(),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}

class CreatedBy {
  String id;
  String name;

  CreatedBy({
    required this.id,
    required this.name,
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
