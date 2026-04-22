class ServiceModel {
  ServiceModel({
    required this.id,
    required this.createdAt,
    required this.serviceName,
    required this.imageUrl,
    required this.description,
  });

  final int id;
  final DateTime? createdAt;
  final String serviceName;
  final String imageUrl;
  final String description;

  ServiceModel copyWith({
    int? id,
    DateTime? createdAt,
    String? serviceName,
    String? imageUrl,
    String? description,
  }) {
    return ServiceModel(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      serviceName: serviceName ?? this.serviceName,
      imageUrl: imageUrl ?? this.imageUrl,
      description: description ?? this.description,
    );
  }

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      id: json["id"] ?? "",
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      serviceName: json["serviceName"] ?? "",
      imageUrl: json["imageUrl"] ?? "",
      description: json["description"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "created_at": createdAt?.toIso8601String(),
    "serviceName": serviceName,
    "imageUrl": imageUrl,
    "description": description,
  };

  @override
  String toString() {
    return "$id, $createdAt, $serviceName,$imageUrl,$description";
  }
}
