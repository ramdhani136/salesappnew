class VisitNoteModel {
  String id;
  String title;
  String visit;
  List<Map> tags;
  String notes;
  DateTime createdAt;
  DateTime updatedAt;

  VisitNoteModel({
    required this.id,
    required this.title,
    required this.visit,
    required this.tags,
    required this.notes,
    required this.createdAt,
    required this.updatedAt,
  });

  factory VisitNoteModel.fromJson(Map<String, dynamic> json) {
    return VisitNoteModel(
      id: json['_id'],
      title: json['title'],
      visit: json['visit'],
      tags: List<Map>.from(json['tags']),
      notes: json['notes'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  static List<VisitNoteModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) {
      return VisitNoteModel.fromJson(json);
    }).toList();
  }
}
