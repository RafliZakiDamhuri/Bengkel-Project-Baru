import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/model/allDataModel.dart';
import 'package:project/model/productModel.dart';
import 'package:project/model/serviceModel.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Homecontroller extends GetxController {
  bool isViewListHome1 = true;
  bool isViewListHome2 = false;
  bool isViewListHome3 = false;
  bool isViewListHome4 = false;
  bool isViewListHome5 = false;
  bool isViewListHome6 = false;
  List<String> categoryType = [];
  final supabase = Supabase.instance.client;

  List<ProductModel> productModel = [];

  Future<void> getDataByHeader(String? keyword) async {
    final response = await supabase
        .from('products')
        .select()
        .ilike('product_header', '%$keyword%');

    productModel = (response as List)
        .map((e) => ProductModel.fromJson(e))
        .toList();

    update();
  }

  List<ServiceModel>? serviceModel;
  Future getService() async {
    serviceModel = [];
    final response = await supabase.from('Services').select();
    serviceModel = response.map((e) => ServiceModel.fromJson(e)).toList();
    update();
  }

  Future<void> getCategoryType() async {
    final response = await supabase.rpc('get_distinct_category_products');
    print('Ini adalah response ;;; $response');
    const categoryOrder = [
      'Radiators and Coolers',
      'CATERPILLAR RADIATOR CORE',
      'CATERPILLAR® TUBE AND SHELL OIL COOLER',
      'Radiator Cap and Adapter',
    ];

    categoryType =
        (response as List)
            .map((e) => e['category_products'] as String)
            .where((category) => categoryOrder.contains(category))
            .toList()
          ..sort(
            (a, b) =>
                categoryOrder.indexOf(a).compareTo(categoryOrder.indexOf(b)),
          );
  }

  @override
  void onInit() {
    super.onInit();
    getService();
    getCategoryType();
    print("App sudah load!");
  }
}
