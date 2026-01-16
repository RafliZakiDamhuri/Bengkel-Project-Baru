class Applicationmodel {
  Applicationmodel({
    required this.id,
    required this.createdAt,
    required this.applicationName,
  });

  final int id;
  final DateTime? createdAt;
  final String applicationName;

  Applicationmodel copyWith({
    int? id,
    DateTime? createdAt,
    String? applicationName,
  }) {
    return Applicationmodel(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      applicationName: applicationName ?? this.applicationName,
    );
  }

  factory Applicationmodel.fromJson(Map<String, dynamic> json) {
    return Applicationmodel(
      id: json["id"] ?? "",
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      applicationName: json["application_name"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "created_at": createdAt?.toIso8601String(),
    "application_name": applicationName,
  };

  @override
  String toString() {
    return "$id, $createdAt, $applicationName,";
  }
}
