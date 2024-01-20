// ignore_for_file: prefer_if_null_operators

import 'dart:convert';

Visitmodel visitmodelFromJson(String str) =>
    Visitmodel.fromJson(json.decode(str));

String visitmodelToJson(Visitmodel data) => json.encode(data.toJson());

class Visitmodel {
  String? id;
  String? name;
  String? img;
  String? type;
  Customer? customer;
  Contact? contact;
  Check? checkIn;
  int? rate;
  Branch? createdBy;
  String? status;
  String? signature;
  String? workflowState;
  DateTime? updatedAt;
  Check? checkOut;
  Branch? customerGroup;
  Branch? branch;
  List<dynamic>? schedulelist;

  Visitmodel({
    this.id,
    this.name,
    this.type,
    this.customer,
    this.contact,
    this.checkIn,
    this.rate,
    this.createdBy,
    this.status,
    this.workflowState,
    this.updatedAt,
    this.checkOut,
    this.customerGroup,
    this.branch,
    this.schedulelist,
    this.signature,
    this.img,
  });

  factory Visitmodel.fromJson(Map<String, dynamic> json) {
    return Visitmodel(
      id: json["_id"],
      name: json["name"],
      img: json["img"] != null ? json["img"] : null,
      type: json["type"],
      customer: Customer.fromJson(json["customer"]),
      contact:
          json["contact"] != null ? Contact.fromJson(json["contact"]) : null,
      checkIn: Check.fromJson(json["checkIn"]),
      rate: json["rate"],
      createdBy: Branch.fromJson(json["createdBy"]),
      status: json["status"],
      signature: json["signature"] != null ? json["signature"] : null,
      workflowState: json["workflowState"],
      updatedAt: DateTime.parse(json["updatedAt"]),
      checkOut:
          json["checkOut"] != null ? Check.fromJson(json["checkOut"]) : null,
      customerGroup: Branch.fromJson(json["customerGroup"]),
      branch: Branch.fromJson(json["branch"]),
      schedulelist: json["schedulelist"] == null
          ? null
          : List<dynamic>.from(json["schedulelist"].map((x) => x)),
    );
  }

  static List<Visitmodel> fromJsonList(List<dynamic> data) {
    try {
      if (data.isEmpty) return [];

      return data.map((e) => Visitmodel.fromJson(e)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "img": img,
        "type": type,
        "customer": customer!.toJson(),
        "contact": contact?.toJson(),
        "checkIn": checkIn!.toJson(),
        "rate": rate,
        "createdBy": createdBy!.toJson(),
        "status": status,
        "signature": signature,
        "workflowState": workflowState,
        "updatedAt": updatedAt!.toIso8601String(),
        "checkOut": checkOut?.toJson(),
        "customerGroup": customerGroup!.toJson(),
        "branch": branch!.toJson(),
        "schedulelist": schedulelist != null
            ? List<dynamic>.from(schedulelist!.map((x) => x))
            : null,
      };
}

class Branch {
  String id;
  String name;

  Branch({
    required this.id,
    required this.name,
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
  String id;
  String name;
  String? erpId;

  Customer({
    required this.id,
    required this.name,
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

class Check {
  DateTime? createdAt;
  double? lat;
  double? lng;
  String? address;

  Check({
    this.createdAt,
    this.lat,
    this.lng,
    this.address,
  });

  factory Check.fromJson(Map<String, dynamic> json) => Check(
        createdAt: DateTime.parse(json["createdAt"]),
        lat: json["lat"]?.toDouble(),
        lng: json["lng"]?.toDouble(),
        address: json["address"],
      );

  Map<String, dynamic> toJson() => {
        "createdAt": createdAt?.toIso8601String(),
        "lat": lat,
        "lng": lng,
        "address": address,
      };
}

class Contact {
  String id;
  String name;
  int phone;
  String position;

  Contact({
    required this.id,
    required this.name,
    required this.phone,
    required this.position,
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
