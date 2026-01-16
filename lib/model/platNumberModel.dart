class PlatNumberModel {
  PlatNumberModel({
    required this.id,
    required this.createdAt,
    required this.platNumber,
  });

  final int id;
  final DateTime? createdAt;
  final String platNumber;

  PlatNumberModel copyWith({int? id, DateTime? createdAt, String? platNumber}) {
    return PlatNumberModel(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      platNumber: platNumber ?? this.platNumber,
    );
  }

  factory PlatNumberModel.fromJson(Map<String, dynamic> json) {
    return PlatNumberModel(
      id: json["id"] ?? "",
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      platNumber: json["plat_number"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "created_at": createdAt?.toIso8601String(),
    "plat_number": platNumber,
  };

  @override
  String toString() {
    return "$id, $createdAt, $platNumber,";
  }
}
