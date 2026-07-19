import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/model/productModel.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CmsController extends GetxController {
  late SidebarXController sidebarController;
  final catalogueNumberController = TextEditingController();
  final makesController = TextEditingController();
  final equipmentTypeController = TextEditingController();
  final modelsController = TextEditingController();
  final oemPartcontroller = TextEditingController();
  final industryController = TextEditingController();
  final productTypeController = TextEditingController();
  final productTypeDesignController = TextEditingController();
  final materialTypeController = TextEditingController();
  final descriptionController = TextEditingController();
  final partNumberController = TextEditingController();
  final applicationController = TextEditingController();
  final sizeController = TextEditingController();
  final pressureRatinController = TextEditingController();

  final supabase = Supabase.instance.client;
  List<ProductModel> productModel = [];

  @override
  void onInit() async {
    super.onInit();

    sidebarController = SidebarXController(selectedIndex: 0, extended: true);
    sidebarController.addListener(() {
      cleanTextEditingController();
    });
    await getRadiatorAndCoolers();
  }

  @override
  void onClose() {
    sidebarController.dispose();
    super.onClose();
  }

  void cleanTextEditingController() {
    catalogueNumberController.clear();
    makesController.clear();
    equipmentTypeController.clear();
    modelsController.clear();
    oemPartcontroller.clear();
    industryController.clear();
    productTypeController.clear();
    productTypeDesignController.clear();
    materialTypeController.clear();
    descriptionController.clear();
    partNumberController.clear();
    applicationController.clear();
    sizeController.clear();
    pressureRatinController.clear();
  }

  void fillTextEditinControllerRadiatorAndCoolers(ProductModel? item) {
    catalogueNumberController.text = item?.catalogueNumber ?? '';
    makesController.text = item?.makes ?? '';
    equipmentTypeController.text = item?.equipmentType ?? '';
    modelsController.text = item?.models ?? '';
    oemPartcontroller.text = item?.oemPartNumber ?? '';
    industryController.text = item?.industry ?? '';
    productTypeController.text = item?.productType ?? '';
    productTypeDesignController.text = item?.productTypeDesign ?? '';
    materialTypeController.text = item?.materialType ?? '';
    descriptionController.text = item?.descriptionApplication ?? '';
  }

  Future<void> updateProductRadiatorAndCoolers({required int id}) async {
    try {
      await supabase
          .from('products')
          .update({
            'catalogue_number': catalogueNumberController.text.trim(),
            'makes': makesController.text.trim(),
            'equipment_type': equipmentTypeController.text.trim(),
            'models': modelsController.text.trim(),
            'oem_part_number': oemPartcontroller.text.trim(),
            'industry': industryController.text.trim(),
            'product_type': productTypeController.text.trim(),
            'product_type_design': productTypeDesignController.text.trim(),
            'material_type': materialTypeController.text.trim(),
            'description_application': descriptionController.text.trim(),
            'updated_at': DateTime.now().toIso8601String(),
          })
          .eq('id', id);
      Get.snackbar('Success', 'Product updated successfully');
      await getRadiatorAndCoolers();
      cleanTextEditingController();
      sidebarController.selectIndex(5);

      Get.offNamed('/cms');
    } catch (e) {
      Get.snackbar('Error', 'Failed to update product: $e');
    }
  }

  Future<void> saveProductRadiatorsAndCoolers({
    String? categoryProducts,
  }) async {
    try {
      await supabase.from('products').insert({
        'catalogue_number': catalogueNumberController.text.trim(),
        'makes': makesController.text.trim(),
        'equipment_type': equipmentTypeController.text.trim(),
        'models': modelsController.text.trim(),
        'oem_part_number': oemPartcontroller.text.trim(),
        'industry': industryController.text.trim(),
        'product_type': productTypeController.text.trim(),
        'product_type_design': productTypeDesignController.text.trim(),
        'material_type': materialTypeController.text.trim(),
        'description_application': descriptionController.text.trim(),
        'category_products': categoryProducts?.trim(),
        'product_header':
            '${partNumberController.text.trim()} ${descriptionController.text.trim()}',
      });

      Get.snackbar('Berhasil', 'Produk berhasil ditambahkan');
      cleanTextEditingController();
      update();
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  Future<void> saveProductRadiatorsAndCap({String? categoryProducts}) async {
    try {
      await supabase.from('products').insert({
        'part_number': partNumberController.text.trim(),
        'makes': makesController.text.trim(),
        'application': applicationController.text.trim(),
        'size': sizeController.text.trim(),
        'pressure_rating': pressureRatinController.text.trim(),
        'material_type': materialTypeController.text.trim(),
        'description_application': descriptionController.text.trim(),
        'category_products': categoryProducts?.trim(),
        'product_header':
            '${catalogueNumberController.text.trim()} ${makesController.text.trim()} ${modelsController.text.trim()} ${oemPartcontroller.text.trim()} ${productTypeController.text.trim()} ${productTypeDesignController.text.trim()}',
      });

      Get.snackbar('Berhasil', 'Produk berhasil ditambahkan');
      cleanTextEditingController();
      update();
    } catch (e) {
      print('ini adalah error ; $e');
      Get.snackbar('Error', e.toString());
    }
  }

  Future<void> getRadiatorAndCoolers() async {
    try {
      final response = await supabase
          .from('products')
          .select('*')
          .eq('category_products', 'Radiators and Coolers')
          .order('makes', ascending: true);

      productModel = (response as List)
          .map((e) => ProductModel.fromJson(e))
          .toList();
      update();
    } catch (e) {
      Get.snackbar('Error', 'Failed to get radiators coolers : $e');
    }
  }

  Future<void> deleteProduct(int id) async {
    try {
      print('id ; $id');
      await supabase.from('products').delete().eq('id', id);

      Get.snackbar('Success', 'Product deleted successfully');

      await getRadiatorAndCoolers();
      update();
    } catch (e) {
      Get.snackbar('Error', 'Failed to delete product: $e');
    }
  }
}
