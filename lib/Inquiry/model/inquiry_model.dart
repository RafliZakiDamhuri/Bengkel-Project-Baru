class UserDataModel {
  final String? id;
  final String? name;
  final String? email;
  final String? description;
  final String? message;
  final String? position;
  final String? phoneNumber;
  final String? inquiryType;
  final String? attachmentUrl;
  final String? companyName;
  final String? location;

  final DateTime? createdAt;

  UserDataModel({
    this.id,
    this.name,
    this.email,
    this.description,
    this.message,
    this.position,
    this.phoneNumber,
    this.inquiryType,
    this.attachmentUrl,
    this.companyName,
    this.createdAt,
    this.location,
  });

  factory UserDataModel.fromJson(Map<String, dynamic> json) {
    return UserDataModel(
      id: json['id']?.toString(),
      name: json['name'],
      email: json['email'],
      description: json['description'],
      message: json['message'],
      position: json['position'],
      phoneNumber: json['phone_number'],
      inquiryType: json['inquiry_type'],
      attachmentUrl: json['attachment_url'],
      companyName: json['companyName'],
      location: json['location'],
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'].toString())
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'description': description,
      'message': message,
      'position': position,
      'phone_number': phoneNumber,
      'inquiry_type': inquiryType,
      'attachment_url': attachmentUrl,
      'companyName': companyName,
      'created_at': createdAt?.toIso8601String(),
      'location': location,
    };
  }
}
