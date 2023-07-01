class CustomerModel {
  final Location? location;
  final String? id;
  final String? img;
  final String? name;
  final String? address;
  final String? type;
  final CustomerGroup? customerGroup;
  final Branch? branch;
  final String? erpId;
  final CreatedBy? createdBy;
  final String? status;
  final String? workflowState;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  CustomerModel({
    this.location,
    this.img,
    this.id,
    this.name,
    this.address,
    this.type,
    this.customerGroup,
    this.branch,
    this.erpId,
    this.createdBy,
    this.status,
    this.workflowState,
    this.createdAt,
    this.updatedAt,
  });

  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    return CustomerModel(
      location:
          json['location'] != null ? Location.fromJson(json['location']) : null,
      id: json['_id'],
      name: json['name'],
      img: json['img'],
      address: json['address'],
      type: json['type'],
      customerGroup: json['customerGroup'] != null
          ? CustomerGroup.fromJson(json['customerGroup'])
          : null,
      branch: json['branch'] != null ? Branch.fromJson(json['branch']) : null,
      erpId: json['erpId'],
      createdBy: json['createdBy'] != null
          ? CreatedBy.fromJson(json['createdBy'])
          : null,
      status: json['status'],
      workflowState: json['workflowState'],
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
    );
  }

  static List<CustomerModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => CustomerModel.fromJson(json)).toList();
  }
}

class Location {
  final String? type;
  final List<double>? coordinates;

  Location({
    this.type,
    this.coordinates,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      type: json['type'],
      coordinates: json['coordinates'] != null
          ? List<double>.from(json['coordinates'])
          : null,
    );
  }
}

class CustomerGroup {
  final String? id;
  final String? name;

  CustomerGroup({
    this.id,
    this.name,
  });

  factory CustomerGroup.fromJson(Map<String, dynamic> json) {
    return CustomerGroup(
      id: json['_id'],
      name: json['name'],
    );
  }
}

class Branch {
  final String? id;
  final String? name;

  Branch({
    this.id,
    this.name,
  });

  factory Branch.fromJson(Map<String, dynamic> json) {
    return Branch(
      id: json['_id'],
      name: json['name'],
    );
  }
}

class CreatedBy {
  final String? id;
  final String? name;

  CreatedBy({
    this.id,
    this.name,
  });

  factory CreatedBy.fromJson(Map<String, dynamic> json) {
    return CreatedBy(
      id: json['_id'],
      name: json['name'],
    );
  }
}
