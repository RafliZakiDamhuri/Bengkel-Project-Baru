class ModelModel {
  ModelModel({
    required this.id,
    required this.createdAt,
    required this.modelName,
  });

  final int id;
  final DateTime? createdAt;
  final String modelName;

  ModelModel copyWith({int? id, DateTime? createdAt, String? modelName}) {
    return ModelModel(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      modelName: modelName ?? this.modelName,
    );
  }

  factory ModelModel.fromJson(Map<String, dynamic> json) {
    return ModelModel(
      id: json["id"] ?? "",
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      modelName: json["model_name"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "created_at": createdAt?.toIso8601String(),
    "model_name": modelName,
  };

  @override
  String toString() {
    return "$id, $createdAt, $modelName,";
  }
}
