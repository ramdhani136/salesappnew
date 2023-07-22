import 'dart:convert';

CallsheetModel callsheetModelFromJson(String str) =>
    CallsheetModel.fromJson(json.decode(str));

String callsheetModelToJson(CallsheetModel data) => json.encode(data.toJson());

class CallsheetModel {
  String? id;
  String? name;
  String? type;
  Customer? customer;
  Contact? contact;
  num? rate;
  Branch? createdBy;
  String? status;
  String? workflowState;
  DateTime? createdAt;
  DateTime? updatedAt;
  Branch? customerGroup;
  Branch? branch;
  List<dynamic>? schedulelist;

  CallsheetModel({
    this.id,
    this.name,
    this.type,
    this.customer,
    this.contact,
    this.rate,
    this.createdBy,
    this.status,
    this.workflowState,
    this.createdAt,
    this.updatedAt,
    this.customerGroup,
    this.branch,
    this.schedulelist,
  });

  factory CallsheetModel.fromJson(Map<String, dynamic> json) => CallsheetModel(
        id: json["_id"],
        name: json["name"],
        type: json["type"],
        customer: json["customer"] == null
            ? null
            : Customer.fromJson(json["customer"]),
        contact:
            json["contact"] == null ? null : Contact.fromJson(json["contact"]),
        rate: json["rate"],
        createdBy: json["createdBy"] == null
            ? null
            : Branch.fromJson(json["createdBy"]),
        status: json["status"],
        workflowState: json["workflowState"],
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
        schedulelist: json["schedulelist"] == null
            ? []
            : List<dynamic>.from(json["schedulelist"]!.map((x) => x)),
      );

  static List<CallsheetModel> fromJsonList(List<dynamic> data) {
    try {
      if (data.isEmpty) return [];

      return data.map((e) => CallsheetModel.fromJson(e)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "type": type,
        "customer": customer?.toJson(),
        "contact": contact?.toJson(),
        "rate": rate,
        "createdBy": createdBy?.toJson(),
        "status": status,
        "workflowState": workflowState,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "customerGroup": customerGroup?.toJson(),
        "branch": branch?.toJson(),
        "schedulelist": schedulelist == null
            ? []
            : List<dynamic>.from(schedulelist!.map((x) => x)),
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

class Customer {
  String? id;
  String? name;
  String? erpId;

  Customer({
    this.id,
    this.name,
    this.erpId,
  });

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        id: json["_id"],
        name: json["name"],
        erpId: json["erpId"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "erpId": erpId,
      };
}

class Contact {
  String? id;
  String? name;
  String? position;
  num? phone;

  Contact({
    this.id,
    this.name,
    this.phone,
    this.position,
  });

  factory Contact.fromJson(Map<String, dynamic> json) => Contact(
        id: json["_id"],
        name: json["name"],
        phone: json["phone"],
        position: json["position"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "phone": phone,
        "position": position,
      };
}
