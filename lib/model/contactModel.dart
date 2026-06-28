class ContactModel {
  ContactModel({
    required this.id,
    required this.createdAt,

    required this.name,
    required this.phoneNumber,
    required this.email,
    required this.image,
  });

  final int id;
  final DateTime? createdAt;

  final String? name;
  final String? phoneNumber;
  final String? email;
  final String? image;

  ContactModel copyWith({
    int? id,
    DateTime? createdAt,
    String? inquiryType,
    String? name,
    String? phoneNumber,
    String? email,
    String? image,
  }) {
    return ContactModel(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,

      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      image: image ?? this.image,
    );
  }

  factory ContactModel.fromJson(Map<String, dynamic> json) {
    return ContactModel(
      id: json["id"] ?? "",
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),

      name: json["name"] ?? "",
      phoneNumber: json["phone_number"] ?? "",
      email: json["email"] ?? "",
      image: json["image"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "created_at": createdAt?.toIso8601String(),

    "name": name,
    "phone_number": phoneNumber,
    "image": image,
  };

  @override
  String toString() {
    return "$id, $createdAt, $name,$phoneNumber,$email,$image";
  }
}
