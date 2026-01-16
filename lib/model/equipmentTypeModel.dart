class EquipmentTypeModel {
  EquipmentTypeModel({
    required this.id,
    required this.createdAt,
    required this.equipmentType,
  });

  final int id;
  final DateTime? createdAt;
  final String equipmentType;

  EquipmentTypeModel copyWith({
    int? id,
    DateTime? createdAt,
    String? equipmentType,
  }) {
    return EquipmentTypeModel(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      equipmentType: equipmentType ?? this.equipmentType,
    );
  }

  factory EquipmentTypeModel.fromJson(Map<String, dynamic> json) {
    return EquipmentTypeModel(
      id: json["id"] ?? "",
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      equipmentType: json["equipment_type"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "created_at": createdAt?.toIso8601String(),
    "equipment_type": equipmentType,
  };

  @override
  String toString() {
    return "$id, $createdAt, $equipmentType,";
  }
}
