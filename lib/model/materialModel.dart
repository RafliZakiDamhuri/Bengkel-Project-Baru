class Materialmodel {
  Materialmodel({
    required this.id,
    required this.createdAt,
    required this.materialName,
  });

  final int id;
  final DateTime? createdAt;
  final String materialName;

  Materialmodel copyWith({int? id, DateTime? createdAt, String? materialName}) {
    return Materialmodel(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      materialName: materialName ?? this.materialName,
    );
  }

  factory Materialmodel.fromJson(Map<String, dynamic> json) {
    return Materialmodel(
      id: json["id"] ?? "",
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      materialName: json["material_name"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "created_at": createdAt?.toIso8601String(),
    "material_name": materialName,
  };

  @override
  String toString() {
    return "$id, $createdAt, $materialName,";
  }
}
