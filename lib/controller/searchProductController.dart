import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:project/model/allDataModel.dart';
import 'package:project/model/applicationModel.dart';
import 'package:project/model/coreTypeModel.dart';
import 'package:project/model/dropDownModel.dart';
import 'package:project/model/materialModel.dart';
import 'package:project/model/modelModel.dart';
import 'package:project/model/productModel.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Searchproductcontroller extends GetxController {
  final supabase = Supabase.instance.client;
  List<DropdownModel?> sizeList = [];

  List<DropdownModel?> makeModel = [];
  List<DropdownModel?> productList = [];
  List<DropdownModel?> productDesignList = [];

  List<DropdownModel?> applicationModel = [];
  List<DropdownModel?> modelsModel = [];
  List<DropdownModel?> industryModel = [];
  List<DropdownModel?> equipmentTypeList = [];
  List<DropdownModel?> pressureRatingList = [];

  List<DropdownModel?> coreTypeModel = [];

  List<Materialmodel?> materialModel = [];

  List<AllDataModel> allDataModel = [];
  List<ProductModel> productModel = [];

  String? selectedMake;
  String? selectedApplication;
  String? selectedProduct;
  String? selectedEquipmentType;
  String? selectedPressureRating;

  String? selectedIndustry;
  String? selectedMaterial;
  String? selectedModel;
  String? selectedCoreType;
  String? selectedSize;
  String? selectedProductTypeDesign;

  String? typedPlatNumber;
  final GlobalKey tableKey = GlobalKey();

  Future getAllSize() async {
    try {
      final response = await Supabase.instance.client.rpc('get_distinct_size');
      print('Ini adalah response :: $response');
      sizeList = (response as List)
          .map((e) => DropdownModel.fromJson(e))
          .toList();
      update();
    } catch (e) {
      print('Ini adalah : $e');
    }
  }

  Future getAllPressureRating() async {
    try {
      final response = await Supabase.instance.client.rpc(
        'get_distinct_pressure_rating',
      );
      pressureRatingList = (response as List)
          .map((e) => DropdownModel.fromJson(e))
          .toList();
      update();
    } catch (e) {
      print('Ini adalah : $e');
    }
    update();
  }

  Future getAllMake({required String? category}) async {
    try {
      if (category == 'CATERPILLAR® TUBE AND SHELL OIL COOLER SEARCH PART') {
        final response = await Supabase.instance.client.rpc(
          'get_distinct_makes_caterpillar',
        );
        makeModel = (response as List)
            .map((e) => DropdownModel.fromJson(e))
            .toList();
        update();
      } else {
        final response = await Supabase.instance.client.rpc(
          'get_distinct_makes',
        );
        makeModel = (response as List)
            .map((e) => DropdownModel.fromJson(e))
            .toList();
        update();
      }
    } catch (e) {
      print('Ini adalah : $e');
    }
  }

  Future<void> scrollToTable() async {
    final context = tableKey.currentContext;

    if (context != null) {
      await Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    }
  }

  Future getAllProducts() async {
    try {
      final response = await Supabase.instance.client.rpc(
        'get_distinct_product_type',
      );
      productList = (response as List)
          .map((e) => DropdownModel.fromJson(e))
          .toList();
      update();
    } catch (e) {
      print('Ini adalah : $e');
    }
    update();
  }

  Future getAllModel() async {
    try {
      final response = await Supabase.instance.client.rpc(
        'get_distinct_models',
      );
      modelsModel = (response as List)
          .map((e) => DropdownModel.fromJson(e))
          .toList();
      update();
    } catch (e) {}
    update();
  }

  Future getAllIndustry() async {
    try {
      final response = await Supabase.instance.client.rpc(
        'get_distinct_industry',
      );
      industryModel = (response as List)
          .map((e) => DropdownModel.fromJson(e))
          .toList();
      update();
    } catch (e) {
      print('Ini adalah : $e');
    }
    update();
  }

  Future<void> reset({required String flow}) async {
    selectedMake = null;
    selectedProduct = null;
    selectedModel = null;
    selectedIndustry = null;
    selectedEquipmentType = null;
    typedPlatNumber = null;
    selectedSize = null;
    selectedPressureRating = null;
    selectedProductTypeDesign = null;

    getAllProductsV2(categoryProducts: flow);
    update();
  }

  Future getAllProductTypeDesign() async {
    try {
      final response = await Supabase.instance.client.rpc(
        'get_distinct_product_type_design',
      );
      productDesignList = (response as List)
          .map((e) => DropdownModel.fromJson(e))
          .toList();
      update();
    } catch (e) {
      print('Ini adalah : $e');
    }
    update();
  }

  Future getAllEquipmentType() async {
    try {
      final response = await Supabase.instance.client.rpc(
        'get_distinct_equipment_type',
      );
      equipmentTypeList = (response as List)
          .map((e) => DropdownModel.fromJson(e))
          .toList();
      update();
    } catch (e) {
      print('Ini adalah : $e');
    }
    update();
  }

  Future<void> getDatabyPartNumber(String? value) async {
    try {
      var query = supabase.from('products').select('*');

      if (value != null && value.trim().isNotEmpty) {
        query = query.or(
          'catalogue_number.ilike.%$value%,oem_part_number.ilike.%$value%',
        );
      }

      final response = await query.order('makes', ascending: true);

      productModel = (response as List)
          .map((e) => ProductModel.fromJson(e))
          .toList();

      update();
    } catch (e) {
      print(e);
    }
  }

  Future<void> getDataNewRadiatorAndCoolers({
    required String categoryProducts,
  }) async {
    var query = supabase
        .from('products')
        .select()
        .eq('category_products', categoryProducts);

    if (selectedMake != null && selectedMake!.isNotEmpty) {
      query = query.eq('makes', selectedMake!);
    }

    if (selectedModel != null && selectedModel!.isNotEmpty) {
      query = query.eq('models', selectedModel!);
    }

    if (selectedEquipmentType != null && selectedEquipmentType!.isNotEmpty) {
      query = query.eq('equipment_type', selectedEquipmentType!);
    }

    if (selectedProduct != null && selectedProduct!.isNotEmpty) {
      query = query.eq('product_type', selectedProduct!);
    }

    if (selectedIndustry != null && selectedIndustry!.isNotEmpty) {
      query = query.eq('industry', selectedIndustry!);
    }

    final response = await query;

    productModel = (response as List)
        .map((e) => ProductModel.fromJson(e))
        .toList();

    update();
  }

  Future<void> getDataNewCatapillarTubeAndShellOilCooler({
    required String categoryProducts,
  }) async {
    print('ini adalah :: $categoryProducts');
    var query = supabase
        .from('products')
        .select()
        .eq('category_products', categoryProducts);

    if (selectedMake != null && selectedMake!.isNotEmpty) {
      query = query.eq('makes', selectedMake!);
    }

    if (selectedModel != null && selectedModel!.isNotEmpty) {
      query = query.eq('models', selectedModel!);
    }

    if (selectedEquipmentType != null && selectedEquipmentType!.isNotEmpty) {
      query = query.eq('equipment_type', selectedEquipmentType!);
    }

    if (selectedProductTypeDesign != null &&
        selectedProductTypeDesign!.isNotEmpty) {
      query = query.eq('product_type_design', selectedProductTypeDesign!);
    }

    if (selectedIndustry != null && selectedIndustry!.isNotEmpty) {
      query = query.eq('industry', selectedIndustry!);
    }

    final response = await query;

    print('Jumlah data: ${(response as List).length}');

    productModel = (response as List)
        .map((e) => ProductModel.fromJson(e))
        .toList();

    update();
  }

  Future<void> getDataNewRadiatorCapAndAdapter({
    required String categoryProducts,
  }) async {
    var query = supabase
        .from('products')
        .select()
        .eq('category_products', categoryProducts);

    if (selectedSize != null && selectedSize!.isNotEmpty) {
      query = query.eq('size', selectedSize!);
    }

    if (selectedPressureRating != null && selectedPressureRating!.isNotEmpty) {
      query = query.eq('pressure_rating', selectedPressureRating!);
    }

    final response = await query;

    productModel = (response as List)
        .map((e) => ProductModel.fromJson(e))
        .toList();

    update();
  }

  Future<void> getDatabyType(String? queryData, String? type) async {
    final Map<String, String> columnMap = {
      'BROWSE PER EQUIPMENT TYPE': 'equipment_type',
      'BROWSE PER MAKES': 'makes',
      'BROWSE PER PRODUCT TYPE': 'product_type',
    };

    final column = columnMap[type];

    var query = supabase.from('products').select('*');

    if (column != null && queryData != null) {
      query = query.eq(column, queryData);
    }

    final response = await query.order('makes', ascending: true);

    productModel = (response as List)
        .map((e) => ProductModel.fromJson(e))
        .toList();

    update();
  }

  Future<void> getAllProductsV2({required String categoryProducts}) async {
    try {
      final response = await Supabase.instance.client
          .from('products')
          .select('*')
          .eq('category_products', categoryProducts)
          .order('makes', ascending: true);

      print(response);
      print('Ini adalah response ::: ${response}');
      productModel = (response as List)
          .map((e) => ProductModel.fromJson(e))
          .toList();

      update();
    } catch (e) {
      print('Error getAllProducts: $e');
    }
  }

  Future<void> getAllProductsV2CatalogueNumber() async {
    try {
      final response = await Supabase.instance.client
          .from('products')
          .select('*')
          .order('catalogue_number', ascending: true);

      productModel = (response as List)
          .map((e) => ProductModel.fromJson(e))
          .toList();

      update();
    } catch (e) {
      print('Error getAllProducts: $e');
    }
  }

  Future<void> getAllProductsV2EquipmentType() async {
    try {
      final response = await Supabase.instance.client
          .from('products')
          .select('*')
          .order('equipment_type', ascending: true);

      productModel = (response as List)
          .map((e) => ProductModel.fromJson(e))
          .toList();

      update();
    } catch (e) {
      print('Error getAllProducts: $e');
    }
  }

  Future<void> getAllProductsV2Models() async {
    try {
      final response = await Supabase.instance.client
          .from('products')
          .select('*')
          .order('models', ascending: true);

      productModel = (response as List)
          .map((e) => ProductModel.fromJson(e))
          .toList();

      update();
    } catch (e) {
      print('Error getAllProducts: $e');
    }
  }

  Future<void> getAllProductsProductTypeDesign() async {
    try {
      final response = await Supabase.instance.client
          .from('products')
          .select('*')
          .order('product_type_design', ascending: true);

      productModel = (response as List)
          .map((e) => ProductModel.fromJson(e))
          .toList();

      update();
    } catch (e) {
      print('Error getAllProducts: $e');
    }
  }

  Future<void> getAllProductsOEMPartNumber() async {
    try {
      final response = await Supabase.instance.client
          .from('products')
          .select('*')
          .order('oem_part_number', ascending: true);

      productModel = (response as List)
          .map((e) => ProductModel.fromJson(e))
          .toList();

      update();
    } catch (e) {
      print('Error getAllProducts: $e');
    }
  }

  Future<void> getAllProductsIndustry() async {
    try {
      final response = await Supabase.instance.client
          .from('products')
          .select('*')
          .order('industry', ascending: true);

      productModel = (response as List)
          .map((e) => ProductModel.fromJson(e))
          .toList();

      update();
    } catch (e) {
      print('Error getAllProducts: $e');
    }
  }

  Future<void> getAllProductsProductType() async {
    try {
      final response = await Supabase.instance.client
          .from('products')
          .select('*')
          .order('product_type', ascending: true);

      productModel = (response as List)
          .map((e) => ProductModel.fromJson(e))
          .toList();

      update();
    } catch (e) {
      print('Error getAllProducts: $e');
    }
  }

  Future<void> getAllProductsDescriptionApplication() async {
    try {
      final response = await Supabase.instance.client
          .from('products')
          .select('*')
          .order('  description_application', ascending: true);

      productModel = (response as List)
          .map((e) => ProductModel.fromJson(e))
          .toList();

      update();
    } catch (e) {
      print('Error getAllProducts: $e');
    }
  }

  void setSelectedMake(String value) {
    selectedMake = value;
    update();
  }

  void setSelectedProductTypeDesign(String value) {
    selectedProductTypeDesign = value;
    update();
  }

  void setSelectedSize(String value) {
    selectedSize = value;
    update();
  }

  void setSelectedApplication(String value) {
    selectedApplication = value;
    update();
  }

  void setSelectedProduct(String value) {
    selectedProduct = value;
    update();
  }

  void setSelectedEquipmentType(String value) {
    selectedEquipmentType = value;
    update();
  }

  void setSelectedPressureRating(String value) {
    selectedPressureRating = value;
    update();
  }

  void setSelectedIndustry(String value) {
    selectedIndustry = value;
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
