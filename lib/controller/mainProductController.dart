import 'package:get/get.dart';
import 'package:project/global%20widget/globalScaffold.dart';
import 'package:project/model/mainProductModel.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

class MainProductController extends GetxController {
  final supabase = Supabase.instance.client;
  bool isLoading = true;
  List<MainProductModel>? mainProductModel;
  Future getProduct() async {
    mainProductModel = [];
    final response = await supabase.from('MainProduct').select();
    mainProductModel = response
        .map((e) => MainProductModel.fromJson(e))
        .toList();
    isLoading = false;
    update();
  }

  @override
  void onInit() {
    getProduct();
    super.onInit();
  }
}
