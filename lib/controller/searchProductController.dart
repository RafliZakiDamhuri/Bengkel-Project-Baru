import 'package:get/get.dart';
import 'package:project/model/allDataModel.dart';
import 'package:project/model/applicationModel.dart';
import 'package:project/model/coreTypeModel.dart';
import 'package:project/model/makeModel.dart';
import 'package:project/model/materialModel.dart';
import 'package:project/model/modelModel.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Searchproductcontroller extends GetxController {
  final supabase = Supabase.instance.client;
  List<MakeModel?> makeModel = [];
  List<Applicationmodel?> applicationModel = [];
  List<Materialmodel?> materialModel = [];
  List<ModelModel?> modelModel = [];
  List<CoreTypeModel?> coreTypeModel = [];

  List<AllDataModel> allDataModel = [];

  String? selectedMake;
  String? selectedApplication;
  String? selectedMaterial;
  String? selectedModel;
  String? selectedCoreType;
  String? typedPlatNumber;

  Future getAllMake() async {
    final response = await supabase
        .from('Make') // Ganti dengan nama tabelmu
        .select(); // Mengambil semua kolom
    makeModel = response.map((e) => MakeModel.fromJson(e)).toList();
    print('Ini adalah makeModel :: $makeModel');
    update();
  }

  Future getAllApplication() async {
    final response = await supabase.from('Application').select();
    applicationModel = response
        .map((e) => Applicationmodel.fromJson(e))
        .toList();

    update();
  }

  Future getAllMaterial() async {
    final response = await supabase.from('Material').select();
    materialModel = response.map((e) => Materialmodel.fromJson(e)).toList();

    update();
  }

  Future getAllModel() async {
    final response = await supabase.from('Model').select();
    modelModel = response.map((e) => ModelModel.fromJson(e)).toList();

    update();
  }

  Future getAllCoreType() async {
    final response = await supabase.from('CoreType').select();
    coreTypeModel = response.map((e) => CoreTypeModel.fromJson(e)).toList();

    update();
  }

  Future<void> getDatabyPlatNumber(String? value) async {
    var query = supabase.from('AllData').select('''
      *,
      Make (id,make_name),
      Application (id,application_name),
      Material (id,material_name),
      PlatNumber!inner (id,plat_number),
      Model (id,model_name),
      EquipmentType (id,equipment_type),
      CoreType (id,core_type),
      Alternative (id,alternative)
    ''');
    if (value != null && value!.isNotEmpty) {
      query = query.ilike('PlatNumber.plat_number', '%$value%');
    }
    if (selectedMake != null && selectedMake!.isNotEmpty) {
      query = query.eq('make_id', selectedMake!);
    }

    if (selectedApplication != null && selectedApplication!.isNotEmpty) {
      query = query.eq('application_id', selectedApplication!);
    }

    if (selectedMaterial != null && selectedMaterial!.isNotEmpty) {
      query = query.eq('material_id', selectedMaterial!);
    }
    if (selectedModel != null && selectedModel!.isNotEmpty) {
      query = query.eq('model_id', selectedModel!);
    }
    if (selectedCoreType != null && selectedCoreType!.isNotEmpty) {
      query = query.eq('core_type_id', selectedCoreType!);
    }
    final response = await query;
    allDataModel = response.map((e) => AllDataModel.fromJson(e)).toList();

    for (var i = 0; i < allDataModel.length; i++) {
      print(allDataModel[i].platNumber);
    }
    update();
  }

  Future getData() async {
    var query = supabase.from('AllData').select('''
      *,
      Make (id,make_name),
      Application (id,application_name),
      Material (id,material_name),
      PlatNumber (id,plat_number),
      Model (id,model_name),
      EquipmentType (id,equipment_type),
      CoreType (id,core_type),
      Alternative (id,alternative)
    ''');

    // 2. Tambahkan filter hanya jika variabel tidak null/kosong
    if (typedPlatNumber != null && typedPlatNumber!.isNotEmpty) {
      query = query.ilike('PlatNumber.plat_number', '%$typedPlatNumber%');
    }
    if (selectedMake != null && selectedMake!.isNotEmpty) {
      query = query.eq('make_id', selectedMake!);
    }

    if (selectedApplication != null && selectedApplication!.isNotEmpty) {
      query = query.eq('application_id', selectedApplication!);
    }

    if (selectedMaterial != null && selectedMaterial!.isNotEmpty) {
      query = query.eq('material_id', selectedMaterial!);
    }
    if (selectedModel != null && selectedModel!.isNotEmpty) {
      query = query.eq('model_id', selectedModel!);
    }
    if (selectedCoreType != null && selectedCoreType!.isNotEmpty) {
      query = query.eq('core_type_id', selectedCoreType!);
    }

    // 3. Eksekusi query
    final response = await query;

    allDataModel = response.map((e) => AllDataModel.fromJson(e)).toList();
    update();
  }

  void setSelectedMake(String value) {
    selectedMake = value;
    update();
  }

  void setSelectedApplication(String value) {
    selectedApplication = value;
    update();
  }

  void setSelectedMaterial(String value) {
    selectedMaterial = value;
    update();
  }

  void setSelectedModel(String value) {
    selectedModel = value;
    update();
  }

  void setSelectedCoreType(String value) {
    selectedCoreType = value;
    update();
  }

  void setTypedPlatNumber(String value) {
    typedPlatNumber = value;
    update();
  }
}
