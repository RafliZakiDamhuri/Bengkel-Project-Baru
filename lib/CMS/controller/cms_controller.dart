import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project/global%20widget/globalLoadingWidget.dart';
import 'package:project/model/productModel.dart';
import 'package:project/theme/string.dart';
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
  String? categoryTypeData;
  final sealTypeController = TextEditingController();
  final overTankController = TextEditingController();
  final coretypeController = TextEditingController();
  Uint8List? bytes;
  String? imageName;
  String? imageUrl;

  final supabase = Supabase.instance.client;
  List<ProductModel> productModel = [];
  ProductModel? productModelSingle;
  bool isLoading = false;
  @override
  void onInit() async {
    super.onInit();

    sidebarController = SidebarXController(selectedIndex: 0, extended: true);
    sidebarController.addListener(() async {
      final index = sidebarController.selectedIndex;

      cleanTextEditingController();
      productModel = [];
      productModel.clear();
      if (index == 6) {
        await getAllData(categoryTypeData: AppString().radiatorAndCoolers);
        categoryTypeData = AppString().radiatorAndCoolers;
      } else if (index == 7) {
        await getAllData(categoryTypeData: AppString().radiatorCapAndAdapters);
        categoryTypeData = AppString().radiatorCapAndAdapters;
      } else if (index == 8) {
        await getAllData(categoryTypeData: AppString().caterpilarTube);
        categoryTypeData = AppString().caterpilarTube;
      } else if (index == 9) {
        await getAllData(categoryTypeData: AppString().caterpillarRadiatorCore);
        categoryTypeData = AppString().caterpillarRadiatorCore;
      }
    });
  }

  @override
  void onClose() {
    sidebarController.dispose();
    super.onClose();
  }

  Future<void> pickAndUploadImage() async {
    final ImagePicker picker = ImagePicker();

    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image == null) return;

    bytes = await image.readAsBytes();
    imageName = image.name;
    update();
  }

  Future<void> insertDrawing() async {
    try {
      final fileName = '${DateTime.now().millisecondsSinceEpoch}_$imageName';
      final path = 'products/$fileName';
      print('Ini adalah : ${imageName?.split('.').last}');
      await Supabase.instance.client.storage
          .from('2d-product-images')
          .uploadBinary(
            path,
            bytes!,
            fileOptions: FileOptions(
              contentType: 'image/${imageName?.split('.').last}',
            ),
          );

      imageUrl = Supabase.instance.client.storage
          .from('2d-product-images')
          .getPublicUrl(path);
      hideLoadingDialog();
    } on Exception catch (e) {
      print('Ini adalah error : $e');
      hideLoadingDialog();
    }
  }

  void cleanTextEditingController() {
    coretypeController.clear();
    sealTypeController.clear();
    overTankController.clear();
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
    coretypeController.clear();
    overTankController.clear();
    sealTypeController.clear();
    productTypeDesignController.clear();
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
    partNumberController.text = item?.partNumber ?? '';
    applicationController.text = item?.application ?? '';
    sizeController.text = item?.size ?? '';
    pressureRatinController.text = item?.pressureRating ?? '';
    productTypeDesignController.text = item?.productTypeDesign ?? '';
    coretypeController.text = item?.coreType ?? '';
    sealTypeController.text = item?.sealType ?? '';
    overTankController.text = item?.tankDimension ?? '';
  }

  Future<void> getProductById(int id) async {
    try {
      isLoading = true;
      update();

      final response = await supabase
          .from('products')
          .select()
          .eq('id', id)
          .single();

      productModelSingle = ProductModel.fromJson(response);
    } catch (e) {
      Get.snackbar('Error', 'Failed to get product: $e');
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<void> updateProductRadiatorAndCoolers({required int id}) async {
    try {
      showLoadingDialog();
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
            'part_number': partNumberController.text.trim(),
            'application': applicationController.text.trim(),
            'size': sizeController.text.trim(),
            'pressure_rating': pressureRatinController.text.trim(),
            'core_type': coretypeController.text.trim(),
            'seal_type': sealTypeController.text.trim(),
            'over_tank_dimension': overTankController.text.trim(),
            'updated_at': DateTime.now().toIso8601String(),
          })
          .eq('id', id);
      Get.snackbar('Success', 'Product updated successfully');
      await getAllData(categoryTypeData: categoryTypeData);
      cleanTextEditingController();
      if (categoryTypeData == AppString().radiatorAndCoolers) {
        sidebarController.selectIndex(6);
      } else if (categoryTypeData == AppString().radiatorCapAndAdapters) {
        sidebarController.selectIndex(7);
      } else if (categoryTypeData == AppString().caterpilarTube) {
        sidebarController.selectIndex(8);
      } else if (categoryTypeData == AppString().caterpillarRadiatorCore) {
        sidebarController.selectIndex(9);
      }

      Get.offNamed('/cms');
      hideLoadingDialog();
    } catch (e) {
      Get.snackbar('Error', 'Failed to update product: $e');
    }
  }

  Future<void> saveProduct({required Map<String, dynamic> data}) async {
    try {
      await supabase.from('products').insert(data);

      Get.snackbar('Berhasil', 'Produk berhasil ditambahkan');

      cleanTextEditingController();

      update();
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  Future<void> savecaterpillarRadiatorCore({String? categoryProducts}) async {
    await saveProduct(
      data: {
        'catalogue_number': catalogueNumberController.text.trim(),
        'makes': makesController.text.trim(),
        'equipment_type': equipmentTypeController.text.trim(),
        'models': modelsController.text.trim(),
        'oem_part_number': oemPartcontroller.text.trim(),
        'seal_type': sealTypeController.text.trim(),
        'product_type': productTypeController.text.trim(),
        'over_tank_dimension': overTankController.text.trim(),
        'material_type': materialTypeController.text.trim(),
        'core_type': coretypeController.text.trim(),
        'category_products': categoryProducts?.trim(),
      },
    );
  }

  Future<void> saveProductRadiatorsAndCoolers({
    String? categoryProducts,
  }) async {
    showLoadingDialog();
    await insertDrawing();
    await saveProduct(
      data: {
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
        'drawing_2d': imageUrl,
        'product_header': [
          catalogueNumberController.text.trim(),
          makesController.text.trim(),
          modelsController.text.trim(),
          oemPartcontroller.text.trim(),
          productTypeController.text.trim(),
          productTypeDesignController.text.trim(),
        ].where((e) => e.isNotEmpty).join(' '),
      },
    );
  }

  Future<void> saveProductRadiatorsAndCap({String? categoryProducts}) async {
    await saveProduct(
      data: {
        'part_number': partNumberController.text.trim(),
        'makes': makesController.text.trim(),
        'application': applicationController.text.trim(),
        'size': sizeController.text.trim(),
        'pressure_rating': pressureRatinController.text.trim(),
        'material_type': materialTypeController.text.trim(),
        'description_application': descriptionController.text.trim(),
        'category_products': categoryProducts?.trim(),
        'product_header': [
          partNumberController.text.trim(),
          descriptionController.text.trim(),
        ].where((e) => e.isNotEmpty).join(' '),
      },
    );
  }

  Future<void> savecaterpillarTubeAndShellOil({
    String? categoryProducts,
  }) async {
    await saveProduct(
      data: {
        'catalogue_number': catalogueNumberController.text.trim(),
        'makes': makesController.text.trim(),
        'equipment_type': equipmentTypeController.text.trim(),
        'models': modelsController.text.trim(),
        'oem_part_number': oemPartcontroller.text.trim(),
        'industry': industryController.text.trim(),
        'product_type': productTypeController.text.trim(),
        'product_type_design': productTypeDesignController.text.trim(),
        'material_type': materialTypeController.text.trim(),
        'category_products': categoryProducts?.trim(),
        'application': applicationController.text.trim(),
        'product_header': [
          catalogueNumberController.text.trim(),
          modelsController.text.trim(),
          oemPartcontroller.text.trim(),
          productTypeController.text.trim(),
          productTypeDesignController.text.trim(),
        ].where((e) => e.isNotEmpty).join(' '),
      },
    );
  }

  Future<void> getAllData({String? categoryTypeData}) async {
    try {
      isLoading = true;
      update();

      var response;
      print('Ini adalah categoryTypeData 222 : $categoryTypeData');

      response = await supabase
          .from('products')
          .select('*')
          .eq('category_products', categoryTypeData ?? '')
          .order('makes', ascending: true);

      print('Ini adalah response ::: $response');
      productModel = (response as List)
          .map((e) => ProductModel.fromJson(e))
          .toList();
      await Future.delayed(Duration(seconds: 3));
      isLoading = false;
      update();
    } catch (e) {
      Get.snackbar('Error', 'Failed to get data: $e');
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<void> deleteProduct(int id) async {
    try {
      print('id ; $id');
      await supabase.from('products').delete().eq('id', id);

      Get.snackbar('Success', 'Product deleted successfully');

      await getAllData(categoryTypeData: categoryTypeData);
      update();
    } catch (e) {
      Get.snackbar('Error', 'Failed to delete product: $e');
    }
  }
}
