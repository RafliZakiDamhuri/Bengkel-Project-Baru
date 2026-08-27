import 'package:get/get.dart';
import 'package:project/model/productModel.dart';
import 'package:project/theme/string.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductDetailController extends GetxController {
  bool isLoading = false;
  final supabase = Supabase.instance.client;
  ProductModel? productModelSingle;
  List<ProductModel> productModel = [];
  List<ProductModel> productModelFilter = [];

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
      update();
    } catch (e) {
      Get.snackbar('Error', 'Failed to get product: $e');
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<void> sendEmail(ProductModel? product) async {
    final productName =
        product?.productType ?? product?.catalogueNumber ?? 'Product';

    final subject = Uri.encodeComponent(
      'Product Information Request - $productName',
    );

    final body = Uri.encodeComponent('''
Dear INDOCOOL Sales Team,

I would like to request information regarding the following product/service:

Product / Service:
$productName

Company Name:
____________

Contact Person:
____________

Position:
____________

Country:
____________

Phone / WhatsApp:
____________

Quantity Required:
____________

Message / Special Instruction:
____________

Please contact me with further information, pricing, availability, and technical recommendations.

Thank you.

Best Regards
''');

    final gmailUri = Uri.parse(
      'https://mail.google.com/mail/?view=cm&fs=1&to=sales@indocool.co.id&su=$subject&body=$body',
    );

    if (await canLaunchUrl(gmailUri)) {
      await launchUrl(gmailUri, mode: LaunchMode.externalApplication);
    }
  }

  String? selectedCategory;
  String? selectedMakes;
  String? selectedModels;

  Future<void> getSimilarData({
    required String? categoryData,
    ProductModel? productModelData,
  }) async {
    try {
      selectedCategory = categoryData;
      selectedMakes = productModelData?.makes;
      selectedModels = productModelData?.models;

      var query = supabase
          .from('products')
          .select()
          .eq('category_products', categoryData ?? '');

      if (categoryData == AppString().radiatorAndCoolers) {
        query = query
            .eq('makes', productModelData?.makes ?? '')
            .eq('models', productModelData?.models ?? '');
      } else {
        query = query.eq('makes', productModelData?.makes ?? '');
      }

      final response = await query;

      final products = (response as List)
          .map((e) => ProductModel.fromJson(e))
          .toList();

      // MASTER
      productModel = products;

      // DISPLAY
      productModelFilter = List<ProductModel>.from(products);

      update();
    } catch (e) {
      print('Error getSimilarData: $e');
    }
  }

  Future<void> filterByCatalogueNumber(String? catalogueNumber) async {
    try {
      var query = supabase
          .from('products')
          .select()
          .eq('category_products', selectedCategory ?? '');

      if (selectedMakes != null && selectedMakes!.isNotEmpty) {
        query = query.eq('makes', selectedMakes!);
      }

      if (selectedModels != null &&
          selectedModels!.isNotEmpty &&
          selectedCategory == AppString().radiatorAndCoolers) {
        query = query.eq('models', selectedModels!);
      }

      if (catalogueNumber != null && catalogueNumber.isNotEmpty) {
        query = query.eq('catalogue_number', catalogueNumber);
      }

      final response = await query;

      productModelFilter = (response as List)
          .map((e) => ProductModel.fromJson(e))
          .toList();

      update();
    } catch (e) {
      print('Error filter catalogue number: $e');
    }
  }

  Future<void> filterByPartNumber(String? partNumber) async {
    try {
      var query = supabase
          .from('products')
          .select()
          .eq('category_products', selectedCategory ?? '');

      if (selectedMakes != null && selectedMakes!.isNotEmpty) {
        query = query.eq('makes', selectedMakes!);
      }

      if (selectedModels != null &&
          selectedModels!.isNotEmpty &&
          selectedCategory == AppString().radiatorAndCoolers) {
        query = query.eq('models', selectedModels!);
      }

      if (partNumber != null && partNumber.isNotEmpty) {
        query = query.eq('part_number', partNumber);
      }

      final response = await query;

      productModelFilter = (response as List)
          .map((e) => ProductModel.fromJson(e))
          .toList();

      update();
    } catch (e) {
      print('Error filter catalogue number: $e');
    }
  }

  Future<void> filterByOEMPartNumber(String? oemPartNumber) async {
    try {
      var query = supabase
          .from('products')
          .select()
          .eq('category_products', selectedCategory ?? '');

      if (selectedMakes != null && selectedMakes!.isNotEmpty) {
        query = query.eq('makes', selectedMakes!);
      }

      if (selectedModels != null &&
          selectedModels!.isNotEmpty &&
          selectedCategory == AppString().radiatorAndCoolers) {
        query = query.eq('models', selectedModels!);
      }

      if (oemPartNumber != null && oemPartNumber.isNotEmpty) {
        query = query.eq('oem_part_number', oemPartNumber);
      }

      final response = await query;

      productModelFilter = (response as List)
          .map((e) => ProductModel.fromJson(e))
          .toList();

      update();
    } catch (e) {
      print('Error filter oem number: $e');
    }
  }

  Future<void> filterByApplication(String? application) async {
    try {
      var query = supabase
          .from('products')
          .select()
          .eq('category_products', selectedCategory ?? '');

      if (selectedMakes != null && selectedMakes!.isNotEmpty) {
        query = query.eq('makes', selectedMakes!);
      }

      if (selectedModels != null &&
          selectedModels!.isNotEmpty &&
          selectedCategory == AppString().radiatorAndCoolers) {
        query = query.eq('models', selectedModels!);
      }

      if (application != null && application.isNotEmpty) {
        query = query.eq('application', application);
      }

      final response = await query;

      productModelFilter = (response as List)
          .map((e) => ProductModel.fromJson(e))
          .toList();

      update();
    } catch (e) {
      print('Error filter oem number: $e');
    }
  }

  Future<void> filterByPressureRating(String? pressureRating) async {
    try {
      var query = supabase
          .from('products')
          .select()
          .eq('category_products', selectedCategory ?? '');

      if (selectedMakes != null && selectedMakes!.isNotEmpty) {
        query = query.eq('makes', selectedMakes!);
      }

      if (selectedModels != null &&
          selectedModels!.isNotEmpty &&
          selectedCategory == AppString().radiatorAndCoolers) {
        query = query.eq('models', selectedModels!);
      }

      if (pressureRating != null && pressureRating.isNotEmpty) {
        query = query.eq('pressure_rating', pressureRating);
      }

      final response = await query;

      productModelFilter = (response as List)
          .map((e) => ProductModel.fromJson(e))
          .toList();

      update();
    } catch (e) {
      print('Error filter oem number: $e');
    }
  }

  Future<void> filterByMakes(String? makes) async {
    try {
      var query = supabase
          .from('products')
          .select()
          .eq('category_products', selectedCategory ?? '');

      if (selectedMakes != null && selectedMakes!.isNotEmpty) {
        query = query.eq('makes', selectedMakes!);
      }

      if (selectedModels != null &&
          selectedModels!.isNotEmpty &&
          selectedCategory == AppString().radiatorAndCoolers) {
        query = query.eq('models', selectedModels!);
      }

      if (makes != null && makes.isNotEmpty) {
        query = query.eq('makes', makes);
      }

      final response = await query;

      productModelFilter = (response as List)
          .map((e) => ProductModel.fromJson(e))
          .toList();

      update();
    } catch (e) {
      print('Error filter oem number: $e');
    }
  }

  Future<void> filterByMaterial(String? material) async {
    try {
      var query = supabase
          .from('products')
          .select()
          .eq('category_products', selectedCategory ?? '');

      if (selectedMakes != null && selectedMakes!.isNotEmpty) {
        query = query.eq('makes', selectedMakes!);
      }

      if (selectedModels != null &&
          selectedModels!.isNotEmpty &&
          selectedCategory == AppString().radiatorAndCoolers) {
        query = query.eq('models', selectedModels!);
      }

      if (material != null && material.isNotEmpty) {
        query = query.eq('material_type', material);
      }

      final response = await query;

      productModelFilter = (response as List)
          .map((e) => ProductModel.fromJson(e))
          .toList();

      update();
    } catch (e) {
      print('Error filter oem number: $e');
    }
  }

  Future<void> filterByProductType(String? productType) async {
    try {
      var query = supabase
          .from('products')
          .select()
          .eq('category_products', selectedCategory ?? '');

      if (selectedMakes != null && selectedMakes!.isNotEmpty) {
        query = query.eq('makes', selectedMakes!);
      }

      if (selectedModels != null &&
          selectedModels!.isNotEmpty &&
          selectedCategory == AppString().radiatorAndCoolers) {
        query = query.eq('models', selectedModels!);
      }

      if (productType != null && productType.isNotEmpty) {
        query = query.eq('product_type', productType);
      }

      final response = await query;

      productModelFilter = (response as List)
          .map((e) => ProductModel.fromJson(e))
          .toList();

      update();
    } catch (e) {
      print('Error filter oem number: $e');
    }
  }

  Future<void> filterByProductTypeDesign(String? productTypeDesign) async {
    try {
      var query = supabase
          .from('products')
          .select()
          .eq('category_products', selectedCategory ?? '');

      if (selectedMakes != null && selectedMakes!.isNotEmpty) {
        query = query.eq('makes', selectedMakes!);
      }

      if (selectedModels != null &&
          selectedModels!.isNotEmpty &&
          selectedCategory == AppString().radiatorAndCoolers) {
        query = query.eq('models', selectedModels!);
      }

      if (productTypeDesign != null && productTypeDesign.isNotEmpty) {
        query = query.eq('product_type_design', productTypeDesign);
      }

      final response = await query;

      productModelFilter = (response as List)
          .map((e) => ProductModel.fromJson(e))
          .toList();

      update();
    } catch (e) {
      print('Error filter oem number: $e');
    }
  }

  Future<void> filterByProductDescription(String? description) async {
    try {
      var query = supabase
          .from('products')
          .select()
          .eq('category_products', selectedCategory ?? '');

      if (selectedMakes != null && selectedMakes!.isNotEmpty) {
        query = query.eq('makes', selectedMakes!);
      }

      if (selectedModels != null &&
          selectedModels!.isNotEmpty &&
          selectedCategory == AppString().radiatorAndCoolers) {
        query = query.eq('models', selectedModels!);
      }

      if (description != null && description.isNotEmpty) {
        query = query.eq('description_application', description);
      }

      final response = await query;

      productModelFilter = (response as List)
          .map((e) => ProductModel.fromJson(e))
          .toList();

      update();
    } catch (e) {
      print('Error filter oem number: $e');
    }
  }
}
