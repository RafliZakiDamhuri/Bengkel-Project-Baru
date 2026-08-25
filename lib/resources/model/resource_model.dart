class ResourceModel {
  final String id;
  final String fileName;
  final String? type;
  final String? fileUrl;
  final String? fileExtention;

  final DateTime? createdAt;

  ResourceModel({
    required this.id,
    required this.fileName,
    this.type,
    this.fileUrl,
    this.createdAt,
    this.fileExtention,
  });

  factory ResourceModel.fromJson(Map<String, dynamic> json) {
    return ResourceModel(
      id: json['id'],
      fileName: json['file_name'] ?? '',
      type: json['type'],
      fileUrl: json['file_url'],
      fileExtention: json['file_extention'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
    );
  }
}
