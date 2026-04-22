import 'package:get/get.dart';
import 'package:project/model/allDataModel.dart';
import 'package:project/model/serviceModel.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Homecontroller extends GetxController {
  bool isViewListHome1 = true;
  bool isViewListHome2 = false;
  bool isViewListHome3 = false;
  bool isViewListHome4 = false;
  bool isViewListHome5 = false;
  bool isViewListHome6 = false;

  final supabase = Supabase.instance.client;
  List<AllDataModel> allDataModel = [];
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
    final response = await query;
    allDataModel = response.map((e) => AllDataModel.fromJson(e)).toList();

    update();
  }

  List<ServiceModel>? serviceModel;
  Future getService() async {
    serviceModel = [];
    final response = await supabase.from('Services').select();
    serviceModel = response.map((e) => ServiceModel.fromJson(e)).toList();
    update();
  }

  @override
  void onInit() {
    super.onInit();
    getService();
    print("App sudah load!");
  }
}
