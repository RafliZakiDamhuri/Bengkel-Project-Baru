class BlogModel {
  BlogModel({
    required this.id,
    required this.title,
    required this.content,
    required this.imageUrl,
    required this.authorId,
    required this.createdAt,
    required this.writer,
    required this.type,
  });

  final String id;
  final String title;
  final List<dynamic> content;
  final String imageUrl;
  final String authorId;
  final DateTime? createdAt;
  final String writer;
  final String type;

  BlogModel copyWith({
    String? id,
    String? title,
    List<dynamic>? content,
    String? imageUrl,
    String? authorId,
    DateTime? createdAt,
    String? writer,
    String? type,
  }) {
    return BlogModel(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      imageUrl: imageUrl ?? this.imageUrl,
      authorId: authorId ?? this.authorId,
      createdAt: createdAt ?? this.createdAt,
      writer: writer ?? this.writer,
      type: type ?? this.type,
    );
  }

  factory BlogModel.fromJson(Map<String, dynamic> json) {
    return BlogModel(
      id: json["id"] ?? "",
      title: json["title"] ?? "",
      content: json["content"] ?? [],
      imageUrl: json["image_url"] ?? "",
      authorId: json["author_id"] ?? "",
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      writer: json["writer"] ?? "",
      type: json["type"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "content": content,
    "image_url": imageUrl,
    "author_id": authorId,
    "created_at": createdAt?.toIso8601String(),
    "writer": writer,
    "type": type,
  };

  @override
  String toString() {
    return "$id, $title, $content, $imageUrl, $authorId, $createdAt, $writer, $type";
  }
}
