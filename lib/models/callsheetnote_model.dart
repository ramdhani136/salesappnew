class CallsheetNoteModel {
  String id;
  String title;
  String callsheet;
  List<Map> tags;
  String notes;
  DateTime createdAt;
  DateTime updatedAt;

  CallsheetNoteModel({
    required this.id,
    required this.title,
    required this.callsheet,
    required this.tags,
    required this.notes,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CallsheetNoteModel.fromJson(Map<String, dynamic> json) {
    return CallsheetNoteModel(
      id: json['_id'],
      title: json['title'],
      callsheet: json['callsheet'],
      tags: List<Map>.from(json['tags']),
      notes: json['notes'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  static List<CallsheetNoteModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) {
      return CallsheetNoteModel.fromJson(json);
    }).toList();
  }
}
