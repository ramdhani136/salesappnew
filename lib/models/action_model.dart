class ActionModel {
  final String action;
  final NextStateModel nextState;

  ActionModel({required this.action, required this.nextState});

  static List<ActionModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => ActionModel.fromJson(json)).toList();
  }

  factory ActionModel.fromJson(Map<String, dynamic> json) {
    return ActionModel(
      action: json['action'],
      nextState: NextStateModel.fromJson(json['nextState']),
    );
  }
}

class NextStateModel {
  final String id;
  final String name;

  NextStateModel({required this.id, required this.name});

  factory NextStateModel.fromJson(Map<String, dynamic> json) {
    return NextStateModel(
      id: json['id'],
      name: json['name'],
    );
  }
}
