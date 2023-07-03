// To parse this JSON data, do
//
//     final binModel = binModelFromJson(jsonString);

import 'dart:convert';

BinModel binModelFromJson(String str) => BinModel.fromJson(json.decode(str));

String binModelToJson(BinModel data) => json.encode(data.toJson());

class BinModel {
  String? name;
  String? itemCode;
  String? itemName;
  double? reservedQty;
  double? actualQty;
  num? orderedQty;
  num? indentedQty;
  num? plannedQty;
  num? projectedQty;

  BinModel({
    this.name,
    this.itemCode,
    this.itemName,
    this.reservedQty,
    this.actualQty,
    this.orderedQty,
    this.indentedQty,
    this.plannedQty,
    this.projectedQty,
  });

  factory BinModel.fromJson(Map<String, dynamic> json) => BinModel(
        name: json["name"],
        itemCode: json["item_code"],
        itemName: json["item_name"],
        reservedQty: json["reserved_qty"]?.toDouble(),
        actualQty: json["actual_qty"]?.toDouble(),
        orderedQty: json["ordered_qty"],
        indentedQty: json["indented_qty"],
        plannedQty: json["planned_qty"],
        projectedQty: json["projected_qty"],
      );

  static List<BinModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => BinModel.fromJson(json)).toList();
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "item_code": itemCode,
        "item_name": itemName,
        "reserved_qty": reservedQty,
        "actual_qty": actualQty,
        "ordered_qty": orderedQty,
        "indented_qty": indentedQty,
        "planned_qty": plannedQty,
        "projected_qty": projectedQty,
      };
}
