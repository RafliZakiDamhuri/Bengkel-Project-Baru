class ProductModel {
  final int id;
  final String? catalogueNumber;
  final String? makes;
  final String? equipmentType;
  final String? models;
  final String? oemPartNumber;
  final String? industry;
  final String? productType;
  final String? productTypeDesign;
  final String? materialType;
  final String? descriptionApplication;
  final String? drawing2d;
  final String? drawing3d;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? categoryProducts;
  final String? productHeader;
  final String? partNumber;
  final String? application;
  final String? size;
  final String? pressureRating;
  final String? coreType;
  final String? tankDimension;
  final String? sealType;

  ProductModel({
    required this.id,
    this.catalogueNumber,
    this.makes,
    this.equipmentType,
    this.models,
    this.oemPartNumber,
    this.industry,
    this.productType,
    this.productTypeDesign,
    this.materialType,
    this.descriptionApplication,
    this.drawing2d,
    this.drawing3d,
    required this.createdAt,
    required this.updatedAt,
    this.categoryProducts,
    this.productHeader,
    this.partNumber,
    this.application,
    this.size,
    this.pressureRating,
    this.coreType,
    this.tankDimension,
    this.sealType,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] as int,
      catalogueNumber: json['catalogue_number'] as String?,
      makes: json['makes'] as String?,
      equipmentType: json['equipment_type'] as String?,
      models: json['models'] as String?,
      oemPartNumber: json['oem_part_number'] as String?,
      industry: json['industry'] as String?,
      productType: json['product_type'] as String?,
      productTypeDesign: json['product_type_design'] as String?,
      materialType: json['material_type'] as String?,
      descriptionApplication: json['description_application'] as String?,
      drawing2d: json['drawing_2d'] as String?,
      drawing3d: json['drawing_3d'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      categoryProducts: json['category_products'] as String?,
      productHeader: json['product_header'] as String?,
      partNumber: json['part_number'] as String?,
      application: json['application'] as String?,
      size: json['size'] as String?,
      pressureRating: json['pressure_rating'] as String?,
      coreType: json['core_type'] as String?,
      tankDimension: json['over_tank_dimension'] as String?,
      sealType: json['seal_type'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'catalogue_number': catalogueNumber,
      'makes': makes,
      'equipment_type': equipmentType,
      'models': models,
      'oem_part_number': oemPartNumber,
      'industry': industry,
      'product_type': productType,
      'product_type_design': productTypeDesign,
      'material_type': materialType,
      'description_application': descriptionApplication,
      'drawing_2d': drawing2d,
      'drawing_3d': drawing3d,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'category_products': categoryProducts,
      'product_header': productHeader,
      'part_number': partNumber,
      'application': application,
      'size': size,
      'pressure_rating': pressureRating,
      'core_type': coreType,
      'over_tank_dimension': tankDimension,
      'seal_type': sealType,
    };
  }
}
