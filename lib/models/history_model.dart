class HistoryModel {
  String id;
  UserModel user;
  String message;
  DateTime createdAt;
  DateTime updatedAt;

  HistoryModel({
    required this.id,
    required this.user,
    required this.message,
    required this.createdAt,
    required this.updatedAt,
  });

  static List<HistoryModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => HistoryModel.fromJson(json)).toList();
  }

  factory HistoryModel.fromJson(Map<String, dynamic> json) {
    return HistoryModel(
      id: json['_id'],
      user: UserModel.fromJson(json['user']),
      message: json['message'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}

class UserModel {
  String id;
  String name;

  UserModel({
    required this.id,
    required this.name,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'],
      name: json['name'],
    );
  }
}
