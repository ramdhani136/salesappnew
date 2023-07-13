class TaskVisitModel {
  String id;
  String from;
  String name;
  String title;
  String notes;

  TaskVisitModel({
    required this.id,
    required this.from,
    required this.name,
    required this.title,
    required this.notes,
  });

  factory TaskVisitModel.fromJson(Map<String, dynamic> json) {
    return TaskVisitModel(
      id: json['_id'],
      from: json['from'],
      name: json['name'],
      title: json['title'],
      notes: json['notes'],
    );
  }

  static List<TaskVisitModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => TaskVisitModel.fromJson(json)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['from'] = from;
    data['name'] = name;
    data['title'] = title;
    data['notes'] = notes;
    return data;
  }
}
