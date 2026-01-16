class MakeModel {
  MakeModel({
    required this.id,
    required this.createdAt,
    required this.makeName,
  });

  final int id;
  final DateTime? createdAt;
  final String makeName;

  MakeModel copyWith({int? id, DateTime? createdAt, String? makeName}) {
    return MakeModel(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      makeName: makeName ?? this.makeName,
    );
  }

  factory MakeModel.fromJson(Map<String, dynamic> json) {
    return MakeModel(
      id: json["id"] ?? "",
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      makeName: json["make_name"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "created_at": createdAt?.toIso8601String(),
    "make_name": makeName,
  };

  @override
  String toString() {
    return "$id, $createdAt, $makeName,";
  }
}
