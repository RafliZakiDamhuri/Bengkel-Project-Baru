class DropdownModel {
  final String id;
  final String name;

  DropdownModel({required this.id, required this.name});

  factory DropdownModel.fromJson(Map<String, dynamic> json) {
    return DropdownModel(id: json['id'].toString(), name: json['name']);
  }
}
