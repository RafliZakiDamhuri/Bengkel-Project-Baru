import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:project/model/allDataModel.dart';
import 'package:project/model/applicationModel.dart';
import 'package:project/model/coreTypeModel.dart';
import 'package:project/model/dropDownModel.dart';
import 'package:project/model/materialModel.dart';
import 'package:project/model/modelModel.dart';
import 'package:project/model/productModel.dart';
import 'package:project/theme/string.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Searchproductcontroller extends GetxController {
  final supabase = Supabase.instance.client;
  List<DropdownModel?> sizeList = [];

  List<DropdownModel?> makeList = [];
  List<DropdownModel?> productList = [];
  List<DropdownModel?> productDesignList = [];

  List<DropdownModel?> applicationModel = [];
  List<DropdownModel?> modelList = [];
  List<DropdownModel?> industryList = [];
  List<DropdownModel?> equipmentTypeList = [];
  List<DropdownModel?> pressureRatingList = [];

  List<DropdownModel?> coreTypeModel = [];

  List<Materialmodel?> materialModel = [];

  List<AllDataModel> allDataModel = [];
  List<ProductModel> productModel = [];
  List<ProductModel> productModelSealSpecial = [];

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
  Future<List<DropdownModel>> _getDistinctData({
    required String? category,
    required Map<String, String> functionMap,
    required String defaultFunction,
  }) async {
    final functionName = functionMap[category] ?? defaultFunction;

    final response = await Supabase.instance.client.rpc(functionName);

    return (response as List).map((e) => DropdownModel.fromJson(e)).toList();
  }

  Future<void> getDataByCore({required String coreType}) async {
    final response = await Supabase.instance.client
        .from('products')
        .select('*')
        .eq('core_type', coreType);
    productModel = (response as List)
        .map((e) => ProductModel.fromJson(e))
        .toList();

    update();
  }

  Future<void> getDataBySeal({required String sealType}) async {
    final response = await Supabase.instance.client
        .from('products')
        .select('*')
        .eq('seal_type', sealType);
    productModelSealSpecial = (response as List)
        .map((e) => ProductModel.fromJson(e))
        .toList();

    update();
  }

  Future<void> getAllMake({required String? category}) async {
    makeList = await _getDistinctData(
      category: category,
      functionMap: {
        AppString().caterpilarTube: 'get_distinct_makes_caterpillar_tube',
        AppString().radiatorAndCoolers:
            'get_distinct_makes_radiators_and_coolers',
        AppString().radiatorCapAndAdapters:
            'get_distinct_makes_radiators_and_cap',
      },
      defaultFunction: 'get_distinct_makes_radiators_and_coolers',
    );

    update();
  }

  Future<void> getAllEquipmentType({required String? category}) async {
    equipmentTypeList = await _getDistinctData(
      category: category,
      functionMap: {
        AppString().caterpilarTube:
            'get_distinct_equipment_types_caterpillar_tube',
        AppString().radiatorAndCoolers:
            'get_distinct_equipment_types_radiators_and_coolers',
        AppString().radiatorCapAndAdapters:
            'get_distinct_equipment_types_radiators_and_cap',
      },
      defaultFunction: 'get_distinct_equipment_types_radiators_and_coolers',
    );

    update();
  }

  Future<void> getAllModel({required String? category}) async {
    modelList = await _getDistinctData(
      category: category,
      functionMap: {
        AppString().caterpilarTube: 'get_distinct_models_caterpillar_tube',
        AppString().radiatorAndCoolers:
            'get_distinct_models_radiators_and_coolers',
        AppString().radiatorCapAndAdapters:
            'get_distinct_models_radiators_and_cap',
      },
      defaultFunction: 'get_distinct_models_radiators_and_coolers',
    );

    update();
  }

  Future<void> getAllIndustry({required String? category}) async {
    industryList = await _getDistinctData(
      category: category,
      functionMap: {
        AppString().caterpilarTube: 'get_distinct_industries_caterpillar_tube',
        AppString().radiatorAndCoolers:
            'get_distinct_industries_radiators_and_coolers',
        AppString().radiatorCapAndAdapters:
            'get_distinct_industries_radiators_and_cap',
      },
      defaultFunction: 'get_distinct_industries_radiators_and_coolers',
    );

    update();
  }

  Future<void> getAllProductTypeDesign({required String? category}) async {
    productDesignList = await _getDistinctData(
      category: category,
      functionMap: {
        AppString().caterpilarTube:
            'get_distinct_product_type_designs_caterpillar_tube',

        AppString().radiatorAndCoolers:
            'get_distinct_product_type_designs_radiators_and_coolers',
        AppString().radiatorCapAndAdapters:
            'get_distinct_product_type_designs_radiators_and_cap',
      },
      defaultFunction:
          'get_distinct_product_type_designs_radiators_and_coolers',
    );

    update();
  }

  Future getAllSize() async {
    try {
      final response = await Supabase.instance.client.rpc('get_distinct_size');
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

  Future<void> getAllProducts({required String? category}) async {
    productList = await _getDistinctData(
      category: category,
      functionMap: {
        AppString().caterpilarTube:
            'get_distinct_product_types_caterpillar_tube',
        AppString().radiatorAndCoolers:
            'get_distinct_product_types_radiators_and_coolers',
        AppString().radiatorCapAndAdapters:
            'get_distinct_product_types_radiators_and_cap',
      },
      defaultFunction: 'get_distinct_product_types_radiators_and_coolers',
    );

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

    getAllProductsMakes(categoryProducts: flow);
    update();
  }

  Future<void> getDatabyPartNumber({
    String? value,
    String? catalogueType,
  }) async {
    try {
      var query = supabase.from('products').select('*');

      if (value != null && value.trim().isNotEmpty) {
        if (catalogueType != AppString().radiatorCapAndAdapters) {
          query = query
              .eq('category_products', catalogueType ?? '')
              .or(
                'catalogue_number.ilike.%$value%,oem_part_number.ilike.%$value%',
              );
        } else {
          query = query
              .eq('category_products', catalogueType ?? '')
              .or('part_number.ilike.%$value%');
        }
      }

      final response = await query.order('makes', ascending: true);
      print('response :: $response');
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

  Future<void> getDataNewCaterpillarRadiatorCore({
    bool isTableSeal = false,
  }) async {
    var query = supabase
        .from('products')
        .select()
        .eq('category_products', AppString().caterpillarRadiatorCore);

    final response = await query;
    if (isTableSeal == true) {
      productModelSealSpecial = (response as List)
          .map((e) => ProductModel.fromJson(e))
          .toList();
    } else {
      productModel = (response as List)
          .map((e) => ProductModel.fromJson(e))
          .toList();
    }

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
    final response = await query
        .eq('category_products', AppString().radiatorAndCoolers)
        .order('makes', ascending: true);

    productModel = (response as List)
        .map((e) => ProductModel.fromJson(e))
        .toList();

    update();
  }

  Future<void> getAllProductsMakes({required String categoryProducts}) async {
    try {
      final response = await Supabase.instance.client
          .from('products')
          .select('*')
          .eq('category_products', categoryProducts)
          .order('makes', ascending: true);

      productModel = (response as List)
          .map((e) => ProductModel.fromJson(e))
          .toList();

      update();
    } catch (e) {
      print('Error getAllProducts: $e');
    }
  }

  Future<void> getAllProductsMakesSpecial({
    required String categoryProducts,
  }) async {
    try {
      final response = await Supabase.instance.client
          .from('products')
          .select('*')
          .eq('category_products', categoryProducts)
          .order('makes', ascending: true);

      productModelSealSpecial = (response as List)
          .map((e) => ProductModel.fromJson(e))
          .toList();

      update();
    } catch (e) {
      print('Error getAllProducts: $e');
    }
  }

  Future<void> getAllProductsSize({required String categoryProducts}) async {
    try {
      final response = await Supabase.instance.client
          .from('products')
          .select('*')
          .eq('category_products', categoryProducts)
          .order('size', ascending: true);

      productModel = (response as List)
          .map((e) => ProductModel.fromJson(e))
          .toList();

      update();
    } catch (e) {
      print('Error getAllProducts: $e');
    }
  }

  Future<void> getAllProductsPersureRating({
    required String categoryProducts,
  }) async {
    try {
      final response = await Supabase.instance.client
          .from('products')
          .select('*')
          .eq('category_products', categoryProducts)
          .order('pressure_rating', ascending: true);

      productModel = (response as List)
          .map((e) => ProductModel.fromJson(e))
          .toList();

      update();
    } catch (e) {
      print('Error getAllProducts: $e');
    }
  }

  Future<void> getAllProductsV2CatalogueNumber({
    required String categoryProducts,
  }) async {
    try {
      final response = await Supabase.instance.client
          .from('products')
          .select('*')
          .eq('category_products', categoryProducts)
          .order('catalogue_number', ascending: true);

      productModel = (response as List)
          .map((e) => ProductModel.fromJson(e))
          .toList();

      update();
    } catch (e) {
      print('Error getAllProducts: $e');
    }
  }

  Future<void> getAllProductsV2CatalogueNumberSpecialSeal({
    required String categoryProducts,
  }) async {
    try {
      final response = await Supabase.instance.client
          .from('products')
          .select('*')
          .eq('category_products', categoryProducts)
          .order('catalogue_number', ascending: true);

      productModelSealSpecial = (response as List)
          .map((e) => ProductModel.fromJson(e))
          .toList();

      update();
    } catch (e) {
      print('Error getAllProducts: $e');
    }
  }

  Future<void> getAllProductsV2EquipmentType({
    required String categoryProducts,
  }) async {
    try {
      final response = await Supabase.instance.client
          .from('products')
          .select('*')
          .eq('category_products', categoryProducts)
          .order('equipment_type', ascending: true);

      productModel = (response as List)
          .map((e) => ProductModel.fromJson(e))
          .toList();

      update();
    } catch (e) {
      print('Error getAllProducts: $e');
    }
  }

  Future<void> getAllProductsV2EquipmentTypeSpecialSeal({
    required String categoryProducts,
  }) async {
    try {
      final response = await Supabase.instance.client
          .from('products')
          .select('*')
          .eq('category_products', categoryProducts)
          .order('equipment_type', ascending: true);

      productModelSealSpecial = (response as List)
          .map((e) => ProductModel.fromJson(e))
          .toList();

      update();
    } catch (e) {
      print('Error getAllProducts: $e');
    }
  }

  Future<void> getAllProductsV2Models({
    required String categoryProducts,
  }) async {
    try {
      final response = await Supabase.instance.client
          .from('products')
          .select('*')
          .eq('category_products', categoryProducts)
          .order('models', ascending: true);

      productModel = (response as List)
          .map((e) => ProductModel.fromJson(e))
          .toList();

      update();
    } catch (e) {
      print('Error getAllProducts: $e');
    }
  }

  Future<void> getAllProductsV2ModelsSpecialSeal({
    required String categoryProducts,
  }) async {
    try {
      final response = await Supabase.instance.client
          .from('products')
          .select('*')
          .eq('category_products', categoryProducts)
          .order('models', ascending: true);

      productModelSealSpecial = (response as List)
          .map((e) => ProductModel.fromJson(e))
          .toList();

      update();
    } catch (e) {
      print('Error getAllProducts: $e');
    }
  }

  Future<void> getAllProductsProductTypeDesign({
    required String categoryProducts,
  }) async {
    try {
      final response = await Supabase.instance.client
          .from('products')
          .select('*')
          .eq('category_products', categoryProducts)
          .order('product_type_design', ascending: true);

      productModel = (response as List)
          .map((e) => ProductModel.fromJson(e))
          .toList();

      update();
    } catch (e) {
      print('Error getAllProducts: $e');
    }
  }

  Future<void> getAllProductsSealType({
    required String categoryProducts,
  }) async {
    try {
      final response = await Supabase.instance.client
          .from('products')
          .select('*')
          .eq('category_products', categoryProducts)
          .order('seal_type', ascending: true);

      productModel = (response as List)
          .map((e) => ProductModel.fromJson(e))
          .toList();

      update();
    } catch (e) {
      print('Error getAllProducts: $e');
    }
  }

  Future<void> getAllProductsOverTank({
    required String categoryProducts,
  }) async {
    try {
      final response = await Supabase.instance.client
          .from('products')
          .select('*')
          .eq('category_products', categoryProducts)
          .order('over_tank_dimension', ascending: true);

      productModel = (response as List)
          .map((e) => ProductModel.fromJson(e))
          .toList();

      update();
    } catch (e) {
      print('Error getAllProducts: $e');
    }
  }

  Future<void> getAllProductsMaterialType({
    required String categoryProducts,
  }) async {
    try {
      final response = await Supabase.instance.client
          .from('products')
          .select('*')
          .eq('category_products', categoryProducts)
          .order('material_type', ascending: true);

      productModel = (response as List)
          .map((e) => ProductModel.fromJson(e))
          .toList();
      print('Ini adalah response :: $response');
      update();
    } catch (e) {
      print('Error getAllProducts: $e');
    }
  }

  Future<void> getAllProductsMaterialTypeSpesial({
    required String categoryProducts,
  }) async {
    try {
      final response = await Supabase.instance.client
          .from('products')
          .select('*')
          .eq('category_products', categoryProducts)
          .order('material_type', ascending: true);

      productModelSealSpecial = (response as List)
          .map((e) => ProductModel.fromJson(e))
          .toList();
      print('Ini adalah response :: $response');
      update();
    } catch (e) {
      print('Error getAllProducts: $e');
    }
  }

  Future<void> getAllProductsOEMPartNumber({
    required String categoryProducts,
  }) async {
    try {
      final response = await Supabase.instance.client
          .from('products')
          .select('*')
          .eq('category_products', categoryProducts)
          .order('oem_part_number', ascending: true);

      productModel = (response as List)
          .map((e) => ProductModel.fromJson(e))
          .toList();

      update();
    } catch (e) {
      print('Error getAllProducts: $e');
    }
  }

  Future<void> getAllProductsOEMPartNumberSpecialSeal({
    required String categoryProducts,
  }) async {
    try {
      final response = await Supabase.instance.client
          .from('products')
          .select('*')
          .eq('category_products', categoryProducts)
          .order('oem_part_number', ascending: true);

      productModelSealSpecial = (response as List)
          .map((e) => ProductModel.fromJson(e))
          .toList();

      update();
    } catch (e) {
      print('Error getAllProducts: $e');
    }
  }

  Future<void> getAllProductsIndustry({
    required String categoryProducts,
  }) async {
    try {
      final response = await Supabase.instance.client
          .from('products')
          .select('*')
          .eq('category_products', categoryProducts)
          .order('industry', ascending: true);

      productModel = (response as List)
          .map((e) => ProductModel.fromJson(e))
          .toList();

      update();
    } catch (e) {
      print('Error getAllProducts: $e');
    }
  }

  Future<void> getAllProductsIndustrySpecialSeal({
    required String categoryProducts,
  }) async {
    try {
      final response = await Supabase.instance.client
          .from('products')
          .select('*')
          .eq('category_products', categoryProducts)
          .order('industry', ascending: true);

      productModelSealSpecial = (response as List)
          .map((e) => ProductModel.fromJson(e))
          .toList();

      update();
    } catch (e) {
      print('Error getAllProducts: $e');
    }
  }

  Future<void> getAllProductsProductType({
    required String categoryProducts,
  }) async {
    try {
      final response = await Supabase.instance.client
          .from('products')
          .select('*')
          .eq('category_products', categoryProducts)
          .order('product_type', ascending: true);

      productModel = (response as List)
          .map((e) => ProductModel.fromJson(e))
          .toList();

      update();
    } catch (e) {
      print('Error getAllProducts: $e');
    }
  }

  Future<void> getAllProductsDescriptionApplication({
    required String categoryProducts,
  }) async {
    try {
      final response = await Supabase.instance.client
          .from('products')
          .select('*')
          .eq('category_products', categoryProducts)
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
