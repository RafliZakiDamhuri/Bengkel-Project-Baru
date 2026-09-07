import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:project/model/allDataModel.dart';
import 'package:project/model/dropDownModel.dart';
import 'package:project/model/materialModel.dart';
import 'package:project/model/productModel.dart';
import 'package:project/theme/string.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SearchProductController extends GetxController {
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
  List<ProductModel> productModelForListFilter = [];
  List<ProductModel> productModelForListFilterCatalogNumber = [];
  List<ProductModel> productModelForListFilterCatalogEquipmenType = [];
  List<ProductModel> productModelForListFilterCatalogModels = [];
  List<ProductModel> productModelForListFilterCatalogOemPartNumber = [];
  List<ProductModel> productModelForListFilterCatalogIndystry = [];
  List<ProductModel> productModelForListFilterCatalogProductType = [];
  List<ProductModel> productModelForListFilterCatalogProductTypeDesign = [];
  List<ProductModel> productModelForListFilterCatalogDescription = [];

  List<ProductModel> productModelForListFilterPartNumber = [];
  List<ProductModel> productModelForListFilterMakes = [];
  List<ProductModel> productModelForListFilterSize = [];

  List<ProductModel> productModelForListFilterApplication = [];
  List<ProductModel> productModelForListFilterPartPressure = [];
  List<ProductModel> productModelForListFilterPartMaterial = [];
  List<ProductModel> productModelForListFilterPartDescriptionApplication = [];

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

  /// Mengambil produk sesuai [category], lalu melakukan de-duplikasi
  /// berdasarkan nilai [field] (hanya menyimpan satu produk per nilai unik).
  ///
  /// Menggantikan banyak method `getProductsByCategoryForListFilter*` yang
  /// sebelumnya berisi logika identik yang di-copy-paste.
  Future<void> _fetchUniqueProductsByField({
    required String category,
    required String Function(ProductModel) field,
    required void Function(List<ProductModel>) setter,
  }) async {
    final response = await supabase
        .from('products')
        .select()
        .eq('category_products', category);

    final products = (response as List)
        .map((e) => ProductModel.fromJson(e))
        .toList();

    final unique = <String, ProductModel>{};

    for (final product in products) {
      final key = field(product);

      if (key.isNotEmpty) {
        unique[key] = product;
      }
    }

    setter(unique.values.toList());
    update();
  }

  /// Mengambil seluruh produk sesuai [categoryProducts] yang diurutkan
  /// berdasarkan [column] ascending. Jika [special], hasil disimpan ke
  /// [productModelSealSpecial], selain itu ke [productModel].
  ///
  /// Menggantikan banyak method `getAllProducts*` yang identik.
  Future<void> _fetchProductsOrderedByColumn({
    required String categoryProducts,
    required String column,
    bool special = false,
  }) async {
    try {
      final response = await Supabase.instance.client
          .from('products')
          .select('*')
          .eq('category_products', categoryProducts)
          .order(column, ascending: true);

      final list = (response as List)
          .map((e) => ProductModel.fromJson(e))
          .toList();

      if (special) {
        productModelSealSpecial = list;
      } else {
        productModel = list;
      }

      update();
    } catch (e) {
      // Sorted/filter error suppressed to avoid crashing the UI
    }
  }

  /// Mengurutkan [productModel] berdasarkan [field], bolak-balik ascending /
  /// descending setiap dipanggil. Menggunakan [isSort] atau [isSortSpecial]
  /// tergantung [useSpecial].
  void _sortProductModel({
    required String Function(ProductModel) field,
    bool useSpecial = false,
  }) {
    try {
      productModel.sort((a, b) {
        if (useSpecial ? isSortSpecial : isSort) {
          return field(a).compareTo(field(b));
        } else {
          return field(b).compareTo(field(a));
        }
      });

      if (useSpecial) {
        isSortSpecial = !isSortSpecial;
      } else {
        isSort = !isSort;
      }

      update();
    } catch (e) {
      // Sorted/filter error suppressed to avoid crashing the UI
    }
  }

  void clearText() {
    selectedMake = null;
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
      // Sorted/filter error suppressed to avoid crashing the UI
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
      // Sorted/filter error suppressed to avoid crashing the UI
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

      productModel = (response as List)
          .map((e) => ProductModel.fromJson(e))
          .toList();

      update();
    } catch (_) {
      // error handled
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

  Future<void> getDataByFilter(
    String? queryData,
    String? type, {
    required String categoryProducts,
  }) async {
    final Map<String, String> columnMap = {
      'Makes': 'makes',
      'Catalogue Number': 'catalogue_number',
      'Equipment Type': 'equipment_type',
      'Models': 'models',
      'OEM Part Number': 'oem_part_number',
      'Industry': 'industry',
      'Product Type': 'product_type',
      'Description': 'description_application',
      'Presure Ratting': 'pressure_rating',
      'Size': 'size',
      'Application': 'application',
      'Material': 'material_type',
      'Part Number': 'part_number',
      'Product Type Design': 'product_type_design',
    };

    final column = columnMap[type];

    var query = supabase.from('products').select('*');

    if (column != null && queryData != null) {
      query = query.eq(column, queryData);
    }

    final response = await query
        .eq('category_products', categoryProducts)
        .order('makes', ascending: true);

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
      // Sorted/filter error suppressed to avoid crashing the UI
    }
  }

  void getAllProductsMakesSort({required String categoryProducts}) {
    _sortProductModel(field: (p) => p.makes ?? '');
  }

  Future<void> getProductsByCategory({required String category}) async {
    final response = await supabase
        .from('products')
        .select()
        .eq('category_products', category);

    productModel = (response as List)
        .map((e) => ProductModel.fromJson(e))
        .toList();

    update();
  }

  Future<void> getProductsByCategoryForListFilterCatalog({
    required String category,
  }) {
    return _fetchUniqueProductsByField(
      category: category,
      field: (p) => p.catalogueNumber ?? '',
      setter: (list) => productModelForListFilterCatalogNumber = list,
    );
  }

  Future<void> getProductsByCategoryForListFilterEquipmentType({
    required String category,
  }) {
    return _fetchUniqueProductsByField(
      category: category,
      field: (p) => p.equipmentType ?? '',
      setter: (list) => productModelForListFilterCatalogEquipmenType = list,
    );
  }

  Future<void> getProductsByCategoryForListFilterModels({
    required String category,
  }) {
    return _fetchUniqueProductsByField(
      category: category,
      field: (p) => p.models ?? '',
      setter: (list) => productModelForListFilterCatalogModels = list,
    );
  }

  Future<void> getProductsByCategoryForListFilterAeomPartNumber({
    required String category,
  }) {
    return _fetchUniqueProductsByField(
      category: category,
      field: (p) => p.oemPartNumber ?? '',
      setter: (list) => productModelForListFilterCatalogOemPartNumber = list,
    );
  }

  Future<void> getProductsByCategoryForListFilterIndustry({
    required String category,
  }) {
    return _fetchUniqueProductsByField(
      category: category,
      field: (p) => p.industry ?? '',
      setter: (list) => productModelForListFilterCatalogIndystry = list,
    );
  }

  Future<void> getProductsByCategoryForListFilterProductType({
    required String category,
  }) {
    return _fetchUniqueProductsByField(
      category: category,
      field: (p) => p.productType ?? '',
      setter: (list) => productModelForListFilterCatalogProductType = list,
    );
  }

  Future<void> getProductsByCategoryForListFilterProductTypeDesign({
    required String category,
  }) {
    return _fetchUniqueProductsByField(
      category: category,
      field: (p) => p.productTypeDesign ?? '',
      setter: (list) =>
          productModelForListFilterCatalogProductTypeDesign = list,
    );
  }

  Future<void> getProductsByCategoryForListFilterProductTypeDescription({
    required String category,
  }) {
    return _fetchUniqueProductsByField(
      category: category,
      field: (p) => p.descriptionApplication ?? '',
      setter: (list) => productModelForListFilterCatalogDescription = list,
    );
  }

  Future<void> getProductsByCategoryForListFilterPartNumber({
    required String category,
  }) {
    return _fetchUniqueProductsByField(
      category: category,
      field: (p) => p.partNumber ?? '',
      setter: (list) => productModelForListFilterPartNumber = list,
    );
  }

  Future<void> getProductsByCategoryForListFilterMakes({
    required String category,
  }) {
    return _fetchUniqueProductsByField(
      category: category,
      field: (p) => p.makes ?? '',
      setter: (list) => productModelForListFilterMakes = list,
    );
  }

  Future<void> getProductsByCategoryForListFilterApplication({
    required String category,
  }) {
    return _fetchUniqueProductsByField(
      category: category,
      field: (p) => p.application ?? '',
      setter: (list) => productModelForListFilterApplication = list,
    );
  }

  Future<void> getProductsByCategoryForListFilterSize({
    required String category,
  }) {
    return _fetchUniqueProductsByField(
      category: category,
      field: (p) => p.size ?? '',
      setter: (list) => productModelForListFilterSize = list,
    );
  }

  Future<void> getProductsByCategoryForListFilterPressureRating({
    required String category,
  }) {
    return _fetchUniqueProductsByField(
      category: category,
      field: (p) => p.pressureRating ?? '',
      setter: (list) => productModelForListFilterPartPressure = list,
    );
  }

  Future<void> getProductsByCategoryForListFilterMaterial({
    required String category,
  }) {
    return _fetchUniqueProductsByField(
      category: category,
      field: (p) => p.materialType ?? '',
      setter: (list) => productModelForListFilterPartMaterial = list,
    );
  }

  Future<void> getProductsByCategoryForListFilterDescriptionApplication({
    required String category,
  }) {
    return _fetchUniqueProductsByField(
      category: category,
      field: (p) => p.descriptionApplication ?? '',
      setter: (list) =>
          productModelForListFilterPartDescriptionApplication = list,
    );
  }

  void getAllProductsMakesSortSpecial({required String categoryProducts}) {
    _sortProductModel(field: (p) => p.makes ?? '', useSpecial: true);
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
      // Sorted/filter error suppressed to avoid crashing the UI
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
      // Sorted/filter error suppressed to avoid crashing the UI
    }
  }

  void getAllProductsPersureRatingSort({required String categoryProducts}) {
    _sortProductModel(field: (p) => p.pressureRating ?? '');
  }

  Future<void> getAllProductsPersureRating({required String categoryProducts}) {
    return _fetchProductsOrderedByColumn(
      categoryProducts: categoryProducts,
      column: 'pressure_rating',
    );
  }

  Future<void> getAllProductsV2CatalogueNumber({
    required String categoryProducts,
  }) {
    return _fetchProductsOrderedByColumn(
      categoryProducts: categoryProducts,
      column: 'catalogue_number',
    );
  }

  bool isSort = true;
  bool isSortSpecial = true;
  void getAllProductsV2CatalogueNumberSort({required String categoryProducts}) {
    _sortProductModel(field: (p) => p.catalogueNumber ?? '');
  }

  Future<void> getAllProductsV2PartNumberSort({
    required String categoryProducts,
  }) async {
    try {
      productModel.sort((a, b) {
        if (isSort) {
          // Ascending (A-Z)
          return (a.partNumber ?? '').compareTo(b.partNumber ?? '');
        } else {
          // Descending (Z-A)
          return (b.partNumber ?? '').compareTo(a.partNumber ?? '');
        }
      });

      // Ubah mode sort untuk klik berikutnya
      isSort = !isSort;

      update();
    } catch (e) {
      // Sorted/filter error suppressed to avoid crashing the UI
    }
  }

  void getAllProductsV2CatalogueNumberSortSpecialSeal({
    required String categoryProducts,
  }) {
    _sortProductModel(field: (p) => p.catalogueNumber ?? '', useSpecial: true);
  }

  void getAllProductsSizeSort({required String categoryProducts}) {
    _sortProductModel(field: (p) => p.size ?? '');
  }

  void getAllProductsSizeSortSpecialSeal({required String categoryProducts}) {
    _sortProductModel(field: (p) => p.size ?? '', useSpecial: true);
  }

  Future<void> getAllProductsV2EquipmentTypeSort({
    required String categoryProducts,
  }) async {
    try {
      productModel.sort((a, b) {
        if (isSort) {
          // Ascending (A-Z)
          return (a.equipmentType ?? '').compareTo(b.equipmentType ?? '');
        } else {
          // Descending (Z-A)
          return (b.equipmentType ?? '').compareTo(a.equipmentType ?? '');
        }
      });

      // Ubah mode sort untuk klik berikutnya
      isSort = !isSort;

      update();
    } catch (e) {
      // Sorted/filter error suppressed to avoid crashing the UI
    }
  }

  Future<void> getAllProductsV2ModelsSort({
    required String categoryProducts,
  }) async {
    try {
      productModel.sort((a, b) {
        if (isSort) {
          // Ascending (A-Z)
          return (a.models ?? '').compareTo(b.models ?? '');
        } else {
          // Descending (Z-A)
          return (b.models ?? '').compareTo(a.models ?? '');
        }
      });

      // Ubah mode sort untuk klik berikutnya
      isSort = !isSort;

      update();
    } catch (e) {
      // Sorted/filter error suppressed to avoid crashing the UI
    }
  }

  Future<void> getAllProductsOEMPartNumberSort({
    required String categoryProducts,
  }) async {
    try {
      productModel.sort((a, b) {
        if (isSort) {
          // Ascending (A-Z)
          return (a.oemPartNumber ?? '').compareTo(b.oemPartNumber ?? '');
        } else {
          // Descending (Z-A)
          return (b.oemPartNumber ?? '').compareTo(a.oemPartNumber ?? '');
        }
      });

      // Ubah mode sort untuk klik berikutnya
      isSort = !isSort;

      update();
    } catch (e) {
      // Sorted/filter error suppressed to avoid crashing the UI
    }
  }

  Future<void> getAllProductsOEMPartNumberSortSpecialSeal({
    required String categoryProducts,
  }) async {
    try {
      productModel.sort((a, b) {
        if (isSortSpecial) {
          // Ascending (A-Z)
          return (a.oemPartNumber ?? '').compareTo(b.oemPartNumber ?? '');
        } else {
          // Descending (Z-A)
          return (b.oemPartNumber ?? '').compareTo(a.oemPartNumber ?? '');
        }
      });

      // Ubah mode sort untuk klik berikutnya
      isSortSpecial = !isSortSpecial;

      update();
    } catch (e) {
      // Sorted/filter error suppressed to avoid crashing the UI
    }
  }

  Future<void> getAllProductsIndustrySort({
    required String categoryProducts,
  }) async {
    try {
      productModel.sort((a, b) {
        if (isSort) {
          // Ascending (A-Z)
          return (a.industry ?? '').compareTo(b.industry ?? '');
        } else {
          // Descending (Z-A)
          return (b.industry ?? '').compareTo(a.industry ?? '');
        }
      });

      // Ubah mode sort untuk klik berikutnya
      isSort = !isSort;

      update();
    } catch (e) {
      // Sorted/filter error suppressed to avoid crashing the UI
    }
  }

  Future<void> getAllProductsIndustrySortSpecialSeal({
    required String categoryProducts,
  }) async {
    try {
      productModel.sort((a, b) {
        if (isSortSpecial) {
          // Ascending (A-Z)
          return (a.industry ?? '').compareTo(b.industry ?? '');
        } else {
          // Descending (Z-A)
          return (b.industry ?? '').compareTo(a.industry ?? '');
        }
      });

      // Ubah mode sort untuk klik berikutnya
      isSortSpecial = !isSortSpecial;

      update();
    } catch (e) {
      // Sorted/filter error suppressed to avoid crashing the UI
    }
  }

  Future<void> getAllProductsProductTypeSort({
    required String categoryProducts,
  }) async {
    try {
      productModel.sort((a, b) {
        if (isSort) {
          // Ascending (A-Z)
          return (a.productType ?? '').compareTo(b.productType ?? '');
        } else {
          // Descending (Z-A)
          return (b.productType ?? '').compareTo(a.productType ?? '');
        }
      });

      // Ubah mode sort untuk klik berikutnya
      isSort = !isSort;

      update();
    } catch (e) {
      // Sorted/filter error suppressed to avoid crashing the UI
    }
  }

  Future<void> getAllProductsProductTypeSortSpecialSeal({
    required String categoryProducts,
  }) async {
    try {
      productModel.sort((a, b) {
        if (isSortSpecial) {
          // Ascending (A-Z)
          return (a.productType ?? '').compareTo(b.productType ?? '');
        } else {
          // Descending (Z-A)
          return (b.productType ?? '').compareTo(a.productType ?? '');
        }
      });

      // Ubah mode sort untuk klik berikutnya
      isSortSpecial = !isSortSpecial;

      update();
    } catch (e) {
      // Sorted/filter error suppressed to avoid crashing the UI
    }
  }

  Future<void> getAllProductsProductTypeDesignSort({
    required String categoryProducts,
  }) async {
    try {
      productModel.sort((a, b) {
        if (isSort) {
          // Ascending (A-Z)
          return (a.productTypeDesign ?? '').compareTo(
            b.productTypeDesign ?? '',
          );
        } else {
          // Descending (Z-A)
          return (b.productTypeDesign ?? '').compareTo(
            a.productTypeDesign ?? '',
          );
        }
      });

      // Ubah mode sort untuk klik berikutnya
      isSort = !isSort;

      update();
    } catch (e) {
      // Sorted/filter error suppressed to avoid crashing the UI
    }
  }

  Future<void> getAllProductsProductTypeDesignSortSpecialSeal({
    required String categoryProducts,
  }) async {
    try {
      productModel.sort((a, b) {
        if (isSortSpecial) {
          // Ascending (A-Z)
          return (a.productType ?? '').compareTo(b.productType ?? '');
        } else {
          // Descending (Z-A)
          return (b.productType ?? '').compareTo(a.productType ?? '');
        }
      });

      // Ubah mode sort untuk klik berikutnya
      isSortSpecial = !isSortSpecial;

      update();
    } catch (e) {
      // Sorted/filter error suppressed to avoid crashing the UI
    }
  }

  Future<void> getAllProductsDescriptionApplicationSort({
    required String categoryProducts,
  }) async {
    try {
      productModel.sort((a, b) {
        if (isSort) {
          // Ascending (A-Z)
          return (a.descriptionApplication ?? '').compareTo(
            b.descriptionApplication ?? '',
          );
        } else {
          // Descending (Z-A)
          return (b.descriptionApplication ?? '').compareTo(
            a.descriptionApplication ?? '',
          );
        }
      });

      // Ubah mode sort untuk klik berikutnya
      isSort = !isSort;

      update();
    } catch (e) {
      // Sorted/filter error suppressed to avoid crashing the UI
    }
  }

  Future<void> getAllProductsDescriptionApplicationSpecialSeal({
    required String categoryProducts,
  }) async {
    try {
      productModel.sort((a, b) {
        if (isSortSpecial) {
          // Ascending (A-Z)
          return (a.descriptionApplication ?? '').compareTo(
            b.descriptionApplication ?? '',
          );
        } else {
          // Descending (Z-A)
          return (b.descriptionApplication ?? '').compareTo(
            a.descriptionApplication ?? '',
          );
        }
      });

      // Ubah mode sort untuk klik berikutnya
      isSortSpecial = !isSortSpecial;

      update();
    } catch (e) {
      // Sorted/filter error suppressed to avoid crashing the UI
    }
  }

  Future<void> getAllProductsV2EquipmentTypeSortSpecialSeal({
    required String categoryProducts,
  }) async {
    try {
      productModel.sort((a, b) {
        if (isSortSpecial) {
          // Ascending (A-Z)
          return (a.equipmentType ?? '').compareTo(b.equipmentType ?? '');
        } else {
          // Descending (Z-A)
          return (b.equipmentType ?? '').compareTo(a.equipmentType ?? '');
        }
      });

      // Ubah mode sort untuk klik berikutnya
      isSort = !isSort;

      update();
    } catch (e) {
      // Sorted/filter error suppressed to avoid crashing the UI
    }
  }

  Future<void> getAllProductsV2ModelsSortSpecialSeal({
    required String categoryProducts,
  }) async {
    try {
      productModel.sort((a, b) {
        if (isSortSpecial) {
          // Ascending (A-Z)
          return (a.models ?? '').compareTo(b.models ?? '');
        } else {
          // Descending (Z-A)
          return (b.models ?? '').compareTo(a.models ?? '');
        }
      });

      // Ubah mode sort untuk klik berikutnya
      isSortSpecial = !isSortSpecial;

      update();
    } catch (e) {
      // Sorted/filter error suppressed to avoid crashing the UI
    }
  }

  Future<void> getAllProductsV2CatalogueNumberSpecialSeal({
    required String categoryProducts,
  }) async {
    try {
      productModel.sort((a, b) {
        if (isSortSpecial) {
          // Ascending (A-Z)
          return (a.catalogueNumber ?? '').compareTo(b.catalogueNumber ?? '');
        } else {
          // Descending (Z-A)
          return (b.catalogueNumber ?? '').compareTo(a.catalogueNumber ?? '');
        }
      });

      // Ubah mode sort untuk klik berikutnya
      isSortSpecial = !isSortSpecial;

      update();
    } catch (e) {
      // Sorted/filter error suppressed to avoid crashing the UI
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
      // Sorted/filter error suppressed to avoid crashing the UI
    }
  }

  Future<void> getAllProductsV2EquipmentTypeSpecialSeal({
    required String categoryProducts,
  }) async {
    try {
      productModel.sort((a, b) {
        if (isSortSpecial) {
          // Ascending (A-Z)
          return (a.equipmentType ?? '').compareTo(b.equipmentType ?? '');
        } else {
          // Descending (Z-A)
          return (b.equipmentType ?? '').compareTo(a.equipmentType ?? '');
        }
      });

      // Ubah mode sort untuk klik berikutnya
      isSortSpecial = !isSortSpecial;

      update();
    } catch (e) {
      // Sorted/filter error suppressed to avoid crashing the UI
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
      // Sorted/filter error suppressed to avoid crashing the UI
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
      // Sorted/filter error suppressed to avoid crashing the UI
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
      // Sorted/filter error suppressed to avoid crashing the UI
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
      // Sorted/filter error suppressed to avoid crashing the UI
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
      // Sorted/filter error suppressed to avoid crashing the UI
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

      update();
    } catch (e) {
      // Sorted/filter error suppressed to avoid crashing the UI
    }
  }

  Future<void> getAllProductsMaterialTypeSort({
    required String categoryProducts,
  }) async {
    try {
      productModel.sort((a, b) {
        return (a.materialType ?? '').compareTo(b.materialType ?? '');
      });

      update();
    } catch (e) {
      // Sorted/filter error suppressed to avoid crashing the UI
    }
  }

  Future<void> getAllProductsMaterialTypeSortSpecial({
    required String categoryProducts,
  }) async {
    try {
      productModel.sort((a, b) {
        if (isSortSpecial) {
          // Ascending (A-Z)
          return (a.materialType ?? '').compareTo(b.materialType ?? '');
        } else {
          // Descending (Z-A)
          return (b.materialType ?? '').compareTo(a.materialType ?? '');
        }
      });

      // Ubah mode sort untuk klik berikutnya
      isSortSpecial = !isSortSpecial;

      update();
    } catch (e) {
      // Sorted/filter error suppressed to avoid crashing the UI
    }
  }

  Future<void> getAllProductsMaterialTypeSpecial({
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

      update();
    } catch (e) {
      // Sorted/filter error suppressed to avoid crashing the UI
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
      // Sorted/filter error suppressed to avoid crashing the UI
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
      // Sorted/filter error suppressed to avoid crashing the UI
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
      // Sorted/filter error suppressed to avoid crashing the UI
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
      // Sorted/filter error suppressed to avoid crashing the UI
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
      // Sorted/filter error suppressed to avoid crashing the UI
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
          .order('description_application', ascending: true);

      productModel = (response as List)
          .map((e) => ProductModel.fromJson(e))
          .toList();

      update();
    } catch (e) {
      // Sorted/filter error suppressed to avoid crashing the UI
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
