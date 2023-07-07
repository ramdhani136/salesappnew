class TaskCallsheetModel {
  String id;
  String from;
  String name;
  String title;
  String notes;

  TaskCallsheetModel({
    required this.id,
    required this.from,
    required this.name,
    required this.title,
    required this.notes,
  });

  factory TaskCallsheetModel.fromJson(Map<String, dynamic> json) {
    return TaskCallsheetModel(
      id: json['_id'],
      from: json['from'],
      name: json['name'],
      title: json['title'],
      notes: json['notes'],
    );
  }

  static List<TaskCallsheetModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => TaskCallsheetModel.fromJson(json)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['from'] = this.from;
    data['name'] = this.name;
    data['title'] = this.title;
    data['notes'] = this.notes;
    return data;
  }
}
