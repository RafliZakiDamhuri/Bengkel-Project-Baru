class CoreTypeModel {
  CoreTypeModel({
    required this.id,
    required this.createdAt,
    required this.coreType,
  });

  final int id;
  final DateTime? createdAt;
  final String coreType;

  CoreTypeModel copyWith({int? id, DateTime? createdAt, String? coreType}) {
    return CoreTypeModel(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      coreType: coreType ?? this.coreType,
    );
  }

  factory CoreTypeModel.fromJson(Map<String, dynamic> json) {
    return CoreTypeModel(
      id: json["id"] ?? "",
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      coreType: json["core_type"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "created_at": createdAt?.toIso8601String(),
    "core_type": coreType,
  };

  @override
  String toString() {
    return "$id, $createdAt, $coreType,";
  }
}
