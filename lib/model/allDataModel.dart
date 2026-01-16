import 'package:project/model/alternativeModel.dart';
import 'package:project/model/applicationModel.dart';
import 'package:project/model/coreTypeModel.dart';
import 'package:project/model/equipmentTypeModel.dart';
import 'package:project/model/makeModel.dart';
import 'package:project/model/materialModel.dart';
import 'package:project/model/modelModel.dart';
import 'package:project/model/platNumberModel.dart';

class AllDataModel {
  AllDataModel({
    required this.id,
    this.createdAt,
    this.productCode,
    this.platNumber,
    this.makeId,
    this.applicationId,
    this.materialId,
    this.modelData,
    this.application,
    this.alternativeModel,
    this.height,
    this.weight,
    this.thickness,
    this.coreTypeModel,
    this.equipmentTypeModel,
    this.compatible,
    this.make, // Objek Nested
    this.applicationRel, // Objek Nested (nama diubah agar tidak bentrok dengan string application)
    this.material, // Objek Nested
  });

  final int id;
  final DateTime? createdAt;
  final String? productCode;
  final PlatNumberModel? platNumber;
  final int? makeId;
  final int? applicationId;
  final int? materialId;
  final ModelModel? modelData;
  final String? application;
  final AlternativeModel? alternativeModel;
  final double? height;
  final double? weight;
  final double? thickness;
  final CoreTypeModel? coreTypeModel;
  final EquipmentTypeModel? equipmentTypeModel;
  final String? compatible;

  // Model Referensi
  final MakeModel? make;
  final Applicationmodel? applicationRel;
  final Materialmodel? material;

  factory AllDataModel.fromJson(Map<String, dynamic> json) {
    return AllDataModel(
      id: json["id"] ?? 0,
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      productCode: json["product_code"],
      platNumber: json["PlatNumber"] != null
          ? PlatNumberModel.fromJson(json["PlatNumber"])
          : null,
      makeId: json["make_id"],
      applicationId: json["application_id"],
      materialId: json["material_id"],
      modelData: json["Model"] != null
          ? ModelModel.fromJson(json["Model"])
          : null,
      application: json["application"],
      alternativeModel: json["Alternative"] != null
          ? AlternativeModel.fromJson(json["Alternative"])
          : null,
      height: (json["height"] as num?)?.toDouble(),
      weight: (json["weight"] as num?)?.toDouble(),
      thickness: (json["thickness"] as num?)?.toDouble(),
      coreTypeModel: json["CoreType"] != null
          ? CoreTypeModel.fromJson(json["CoreType"])
          : null,
      equipmentTypeModel: json["EquipmentType"] != null
          ? EquipmentTypeModel.fromJson(json["EquipmentType"])
          : null,
      compatible: json["compatible"],
      // Mapping Nested Object
      make: json["Make"] != null ? MakeModel.fromJson(json["Make"]) : null,
      applicationRel: json["Application"] != null
          ? Applicationmodel.fromJson(json["Application"])
          : null,
      material: json["Material"] != null
          ? Materialmodel.fromJson(json["Material"])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "created_at": createdAt?.toIso8601String(),
    "product_code": productCode,
    "product_number": platNumber,
    "model": modelData,
    "height": height,
    "weight": weight,
    "thickness": thickness,
    "core_type": coreTypeModel,

    // ... tambahkan yang lain jika perlu
  };
}
