class AlternativeModel {
  AlternativeModel({
    required this.id,
    required this.createdAt,
    required this.alternative,
  });

  final int id;
  final DateTime? createdAt;
  final String alternative;

  AlternativeModel copyWith({
    int? id,
    DateTime? createdAt,
    String? alternative,
  }) {
    return AlternativeModel(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      alternative: alternative ?? this.alternative,
    );
  }

  factory AlternativeModel.fromJson(Map<String, dynamic> json) {
    return AlternativeModel(
      id: json["id"] ?? "",
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      alternative: json["alternative"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "created_at": createdAt?.toIso8601String(),
    "alternative": alternative,
  };

  @override
  String toString() {
    return "$id, $createdAt, $alternative,";
  }
}
