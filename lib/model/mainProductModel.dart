class MainProductModel {
  MainProductModel({
    required this.id,
    required this.createdAt,
    required this.productName,
    required this.imageUrl,
    required this.description,
    required this.pdfData,
  });

  final int id;
  final DateTime? createdAt;
  final String productName;
  final String imageUrl;
  final String description;
  final String pdfData;

  MainProductModel copyWith({
    int? id,
    DateTime? createdAt,
    String? productName,
    String? imageUrl,
    String? description,
    String? pdfData,
  }) {
    return MainProductModel(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      productName: productName ?? this.productName,
      imageUrl: imageUrl ?? this.imageUrl,
      description: description ?? this.description,
      pdfData: pdfData ?? this.pdfData,
    );
  }

  factory MainProductModel.fromJson(Map<String, dynamic> json) {
    return MainProductModel(
      id: json["id"] ?? "",
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      productName: json["productName"] ?? "",
      imageUrl: json["imageUrl"] ?? "",
      description: json["description"] ?? "",
      pdfData: json["pdfData"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "created_at": createdAt?.toIso8601String(),
    "productName": productName,
    "imageUrl": imageUrl,
    "description": description,
    "pdfData": pdfData,
  };

  @override
  String toString() {
    return "$id, $createdAt, $productName,$imageUrl,$description,$pdfData";
  }
}
