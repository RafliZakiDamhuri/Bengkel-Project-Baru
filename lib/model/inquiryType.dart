class InquiryTypeModel {
  InquiryTypeModel({
    required this.id,
    required this.createdAt,
    required this.inquiryType,
  });

  final int id;
  final DateTime? createdAt;
  final String inquiryType;

  InquiryTypeModel copyWith({
    int? id,
    DateTime? createdAt,
    String? inquiryType,
  }) {
    return InquiryTypeModel(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      inquiryType: inquiryType ?? this.inquiryType,
    );
  }

  factory InquiryTypeModel.fromJson(Map<String, dynamic> json) {
    return InquiryTypeModel(
      id: json["id"] ?? "",
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      inquiryType: json["inquiry_type"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "created_at": createdAt?.toIso8601String(),
    "inquiry_type": inquiryType,
  };

  @override
  String toString() {
    return "$id, $createdAt, $inquiryType,";
  }
}
