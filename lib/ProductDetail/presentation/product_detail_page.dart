import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/state_manager.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'package:project/ProductDetail/controller/product_detail_controller.dart';
import 'package:project/controller/searchProductController.dart';
import 'package:project/global_widget/globalAppBar.dart';
import 'package:project/ProductDetail/widget/product_detail_title.dart';
import 'package:project/model/productModel.dart';
import 'package:project/routes/routes_name.dart';
import 'package:project/theme/string.dart';
import 'package:project/theme/theme.dart';
import 'package:sizer/sizer.dart';

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({super.key});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  var productDetailController = Get.find<ProductDetailController>();
  var searchController = Get.find<SearchProductController>();

  String titleCategory = '';
  String headerTitle = '';
  @override
  void initState() {
    super.initState();
    var productId = int.parse(Get.parameters['id']!);
    titleCategory = Get.parameters['category'] ?? '';
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await productDetailController.getProductById(productId);
      await productDetailController.getSimilarData(
        categoryData: titleCategory,
        productModelData: productDetailController.productModelSingle,
      );
      if (titleCategory == AppString().radiatorAndCoolers) {
        headerTitle =
            '${productDetailController.productModelSingle?.catalogueNumber}/${productDetailController.productModelSingle?.oemPartNumber} ${productDetailController.productModelSingle?.productType} ${productDetailController.productModelSingle?.productTypeDesign} ${productDetailController.productModelSingle?.makes} ${productDetailController.productModelSingle?.models}';
      } else if (titleCategory == AppString().radiatorCapAndAdapters) {
        headerTitle =
            '${productDetailController.productModelSingle?.partNumber}${productDetailController.productModelSingle?.descriptionApplication}';
      } else if (titleCategory == AppString().caterpilarTube) {
        headerTitle =
            '${productDetailController.productModelSingle?.makes}${productDetailController.productModelSingle?.models}${productDetailController.productModelSingle?.productType}${productDetailController.productModelSingle?.productTypeDesign}';
      }
    });
  }

  DataCell tableCell(ProductModel item, String? value) {
    return DataCell(
      InkWell(
        onTap: () {
          Get.toNamed(
            AppRouteName.productDetailPage,
            parameters: {'id': item.id.toString(), 'category': titleCategory},
          );
        },
        child: Center(
          child: Text(
            value ?? '-',
            softWrap: true,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  DataColumn tableHeader({required String title, required VoidCallback onTap}) {
    return DataColumn(
      label: InkWell(
        onTap: onTap,
        child: Center(
          child: Container(
            margin: const EdgeInsets.only(left: 60),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: whiteTextStyle.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 12,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _customHeaderCell(
    String title, {
    required int flex,
    required VoidCallback onTap,
  }) {
    return Expanded(
      flex: flex,
      child: InkWell(
        onTap: onTap,
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Widget _customDataCell(String? value, {required int flex}) {
    return Expanded(
      flex: flex,
      child: Container(
        constraints: const BoxConstraints(minHeight: 45),
        alignment: Alignment.center,
        child: Text(
          value ?? '-',
          style: const TextStyle(color: Colors.black),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _tableFilterButton({
    required String title,
    required double width,
    VoidCallback? onTap,
  }) {
    return SizedBox(
      width: width,
      height: 22,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(2),
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(2),
            ),
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }

  DataColumn _tableColumn(String title, double width) {
    return DataColumn(
      label: SizedBox(
        width: width,
        child: Text(
          title,
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  DataCell _tableDataCell(String? value, double width) {
    return DataCell(
      SizedBox(
        width: width,
        child: Text(
          value ?? '-',
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  Widget buildTableRadiatorAndCoolers(List<ProductModel> data) {
    final tableWidth = 80.w - 48; // 24 kiri + 24 kanan

    // Total flex kolom
    const totalFlex = 11;

    final catalogueWidth = tableWidth * 1.5 / totalFlex;
    final makesWidth = tableWidth * 1.0 / totalFlex;
    final equipmentWidth = tableWidth * 1.5 / totalFlex;
    final modelsWidth = tableWidth * 1.2 / totalFlex;
    final oemWidth = tableWidth * 1.5 / totalFlex;
    final industryWidth = tableWidth * 1.0 / totalFlex;
    final productTypeWidth = tableWidth * 1.3 / totalFlex;

    return Container(
      width: 80.w,
      color: Colors.black,
      padding: const EdgeInsets.fromLTRB(24, 14, 24, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  'VARIATION RELATED TO $headerTitle',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Text(
                '*the data that is shown in the column below is clickable*',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          Row(
            children: [
              PopupMenuButton<String>(
                offset: const Offset(0, 25),
                padding: EdgeInsets.zero,

                onSelected: (value) {
                  productDetailController.filterByCatalogueNumber(
                    value == 'ALL' ? null : value,
                  );
                },

                itemBuilder: (context) {
                  final catalogueList =
                      productDetailController.productModel
                          .map((e) => e.catalogueNumber)
                          .whereType<String>()
                          .where((e) => e.isNotEmpty)
                          .toSet()
                          .toList()
                        ..sort();

                  return [
                    const PopupMenuItem<String>(
                      value: 'ALL',
                      child: Text('All'),
                    ),
                    ...catalogueList.map(
                      (catalogue) => PopupMenuItem<String>(
                        value: catalogue,
                        child: Text(catalogue),
                      ),
                    ),
                  ];
                },

                child: _tableFilterButton(
                  title: 'Catalogue Number',
                  width: catalogueWidth,
                ),
              ),

              const Spacer(),

              PopupMenuButton<String>(
                offset: const Offset(0, 25),
                padding: EdgeInsets.zero,

                onSelected: (value) {
                  productDetailController.filterByOEMPartNumber(
                    value == 'ALL' ? null : value,
                  );
                },

                itemBuilder: (context) {
                  final oemPartNumberList =
                      productDetailController.productModel
                          .map((e) => e.oemPartNumber)
                          .whereType<String>()
                          .where((e) => e.isNotEmpty)
                          .toSet()
                          .toList()
                        ..sort();

                  return [
                    const PopupMenuItem<String>(
                      value: 'ALL',
                      child: Text('All'),
                    ),
                    ...oemPartNumberList.map(
                      (catalogue) => PopupMenuItem<String>(
                        value: catalogue,
                        child: Text(catalogue),
                      ),
                    ),
                  ];
                },

                child: _tableFilterButton(
                  title: 'OEM Part Number',
                  width: makesWidth,
                ),
              ),

              const Spacer(),

              PopupMenuButton<String>(
                offset: const Offset(0, 25),
                padding: EdgeInsets.zero,

                onSelected: (value) {
                  productDetailController.filterByProductType(
                    value == 'ALL' ? null : value,
                  );
                },

                itemBuilder: (context) {
                  final productTypeList =
                      productDetailController.productModel
                          .map((e) => e.productType)
                          .whereType<String>()
                          .where((e) => e.isNotEmpty)
                          .toSet()
                          .toList()
                        ..sort();

                  return [
                    const PopupMenuItem<String>(
                      value: 'ALL',
                      child: Text('All'),
                    ),
                    ...productTypeList.map(
                      (catalogue) => PopupMenuItem<String>(
                        value: catalogue,
                        child: Text(catalogue),
                      ),
                    ),
                  ];
                },

                child: _tableFilterButton(
                  title: 'Product Type',
                  width: productTypeWidth,
                ),
              ),

              const Spacer(),
              PopupMenuButton<String>(
                offset: const Offset(0, 25),
                padding: EdgeInsets.zero,

                onSelected: (value) {
                  productDetailController.filterByProductDescription(
                    value == 'ALL' ? null : value,
                  );
                },

                itemBuilder: (context) {
                  final description =
                      productDetailController.productModel
                          .map((e) => e.descriptionApplication)
                          .whereType<String>()
                          .where((e) => e.isNotEmpty)
                          .toSet()
                          .toList()
                        ..sort();

                  return [
                    const PopupMenuItem<String>(
                      value: 'ALL',
                      child: Text('All'),
                    ),
                    ...description.map(
                      (catalogue) => PopupMenuItem<String>(
                        value: catalogue,
                        child: Text(catalogue),
                      ),
                    ),
                  ];
                },

                child: _tableFilterButton(
                  title: 'Description / Application',
                  width: tableWidth * 3 / totalFlex,
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          // ============================================================
          // TABLE
          // ============================================================
          // ClipRRect(
          //   borderRadius: BorderRadius.circular(3),
          //   child: DataTable(
          //     headingRowColor: WidgetStateProperty.all(const Color(0xFFFF5A00)),
          //     dataRowColor: WidgetStateProperty.all(Colors.white),
          //     dividerThickness: 1,

          //     // Hilangkan spacing bawaan DataTable
          //     horizontalMargin: 0,
          //     columnSpacing: 0,

          //     headingTextStyle: const TextStyle(
          //       color: Colors.white,
          //       fontSize: 12,
          //       fontWeight: FontWeight.bold,
          //     ),

          //     dataTextStyle: const TextStyle(color: Colors.black, fontSize: 12),

          //     columns: [
          //       _tableColumn('Catalogue Number', catalogueWidth),
          //       _tableColumn('Makes', makesWidth),
          //       _tableColumn('Equipment Type', equipmentWidth),
          //       _tableColumn('Models', modelsWidth),
          //       _tableColumn('OEM Part Number', oemWidth),
          //       _tableColumn('Industry', industryWidth),
          //       _tableColumn('Product Type', productTypeWidth),
          //       _tableColumn('Description / Application', catalogueWidth),
          //     ],

          //     rows: data.map((item) {
          //       return DataRow(
          //         cells: [
          //           _tableDataCell(item.catalogueNumber, catalogueWidth),
          //           _tableDataCell(item.makes, makesWidth),
          //           _tableDataCell(item.equipmentType, equipmentWidth),
          //           _tableDataCell(item.models, modelsWidth),
          //           _tableDataCell(item.oemPartNumber, oemWidth),
          //           _tableDataCell(item.industry, industryWidth),
          //           _tableDataCell(item.productType, productTypeWidth),
          //           _tableDataCell(
          //             item.descriptionApplication,
          //             productTypeWidth,
          //           ),
          //         ],
          //       );
          //     }).toList(),
          //   ),
          // ),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Column(
              children: [
                // --- HEADER TABEL (Warna Oranye) ---
                Container(
                  color: const Color(0xFFFF5A00),
                  padding: const EdgeInsets.symmetric(
                    vertical: 14,
                    horizontal: 16,
                  ),
                  child: Row(
                    children: [
                      // Flex disamakan: 2, 2, 2, 2, 2, 2, 5, 5
                      _customHeaderCell(
                        'Catalogue Number',
                        flex: 2,
                        onTap: () {
                          searchController.getAllProductsV2CatalogueNumberSort(
                            categoryProducts: AppString().radiatorAndCoolers,
                          );
                        },
                      ),
                      const SizedBox(width: 15),
                      _customHeaderCell(
                        'Makes',
                        flex: 2,
                        onTap: () {
                          searchController.getAllProductsMakesSort(
                            categoryProducts: AppString().radiatorAndCoolers,
                          );
                        },
                      ),
                      const SizedBox(width: 15),
                      _customHeaderCell(
                        'Equipment Type',
                        flex: 2,
                        onTap: () {
                          searchController.getAllProductsV2EquipmentTypeSort(
                            categoryProducts: AppString().radiatorAndCoolers,
                          );
                        },
                      ),
                      const SizedBox(width: 15),
                      _customHeaderCell(
                        'Models',
                        flex: 2,
                        onTap: () {
                          searchController.getAllProductsV2ModelsSort(
                            categoryProducts: AppString().radiatorAndCoolers,
                          );
                        },
                      ),
                      const SizedBox(width: 15),
                      _customHeaderCell(
                        'OEM Part Number',
                        flex: 2,
                        onTap: () {
                          searchController.getAllProductsOEMPartNumberSort(
                            categoryProducts: AppString().radiatorAndCoolers,
                          );
                        },
                      ),
                      const SizedBox(width: 15),
                      _customHeaderCell(
                        'Industry',
                        flex: 2,
                        onTap: () {
                          searchController.getAllProductsIndustrySort(
                            categoryProducts: AppString().radiatorAndCoolers,
                          );
                        },
                      ),
                      const SizedBox(width: 15),
                      _customHeaderCell(
                        'Product Type',
                        flex: 5,
                        onTap: () {
                          searchController.getAllProductsProductTypeSort(
                            categoryProducts: AppString().radiatorAndCoolers,
                          );
                        },
                      ),
                      const SizedBox(width: 15),
                      _customHeaderCell(
                        'Description / Application',
                        flex: 5,
                        onTap: () {
                          searchController
                              .getAllProductsDescriptionApplicationSort(
                                categoryProducts:
                                    AppString().radiatorAndCoolers,
                              );
                        },
                      ),
                    ],
                  ),
                ),

                // --- DATA TABEL (Warna Putih) ---
                ...data.map((item) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 14,
                      horizontal: 16,
                    ),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        bottom: BorderSide(color: Color(0xFFE0E0E0), width: 1),
                      ),
                    ),
                    child: InkWell(
                      onTap: () {
                        Get.toNamed(
                          AppRouteName.productDetailPage,
                          parameters: {
                            'id': item.id.toString(),
                            'category': AppString().radiatorAndCoolers,
                          },
                        );
                      },
                      child: Row(
                        children: [
                          _customDataCell(item.catalogueNumber, flex: 2),
                          const SizedBox(width: 15),
                          _customDataCell(item.makes, flex: 2),
                          const SizedBox(width: 15),
                          _customDataCell(item.equipmentType, flex: 2),
                          const SizedBox(width: 15),
                          _customDataCell(item.models, flex: 2),
                          const SizedBox(width: 15),
                          _customDataCell(item.oemPartNumber, flex: 2),
                          const SizedBox(width: 15),
                          _customDataCell(item.industry, flex: 2),
                          const SizedBox(width: 15),
                          _customDataCell(item.productType, flex: 5),
                          const SizedBox(width: 15),
                          _customDataCell(item.descriptionApplication, flex: 5),
                        ],
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTableRadiatorAndCap(List<ProductModel> data) {
    final tableWidth = 80.w - 48; // 24 kiri + 24 kanan

    // Total flex kolom
    const totalFlex = 11;

    final catalogueWidth = tableWidth * 1.5 / totalFlex;
    final makesWidth = tableWidth * 1.0 / totalFlex;
    final equipmentWidth = tableWidth * 1.5 / totalFlex;
    final modelsWidth = tableWidth * 1.2 / totalFlex;
    final oemWidth = tableWidth * 1.5 / totalFlex;
    final industryWidth = tableWidth * 1.0 / totalFlex;
    final productTypeWidth = tableWidth * 1.3 / totalFlex;

    return Container(
      width: 80.w,
      color: Colors.black,
      padding: const EdgeInsets.fromLTRB(24, 14, 24, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  'VARIATION RELATED TO $headerTitle',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Text(
                '*the data that is shown in the column below is clickable*',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          Row(
            children: [
              PopupMenuButton<String>(
                offset: const Offset(0, 25),
                padding: EdgeInsets.zero,

                onSelected: (value) {
                  productDetailController.filterByPartNumber(
                    value == 'ALL' ? null : value,
                  );
                },

                itemBuilder: (context) {
                  final partnumberlist =
                      productDetailController.productModel
                          .map((e) => e.partNumber)
                          .whereType<String>()
                          .where((e) => e.isNotEmpty)
                          .toSet()
                          .toList()
                        ..sort();

                  return [
                    const PopupMenuItem<String>(
                      value: 'ALL',
                      child: Text('All'),
                    ),
                    ...partnumberlist.map(
                      (partNumber) => PopupMenuItem<String>(
                        value: partNumber,
                        child: Text(partNumber),
                      ),
                    ),
                  ];
                },

                child: _tableFilterButton(
                  title: 'Part Number',
                  width: catalogueWidth,
                ),
              ),

              const Spacer(),

              PopupMenuButton<String>(
                offset: const Offset(0, 25),
                padding: EdgeInsets.zero,

                onSelected: (value) {
                  productDetailController.filterByApplication(
                    value == 'ALL' ? null : value,
                  );
                },

                itemBuilder: (context) {
                  final applicationList =
                      productDetailController.productModel
                          .map((e) => e.application)
                          .whereType<String>()
                          .where((e) => e.isNotEmpty)
                          .toSet()
                          .toList()
                        ..sort();

                  return [
                    const PopupMenuItem<String>(
                      value: 'ALL',
                      child: Text('All'),
                    ),
                    ...applicationList.map(
                      (catalogue) => PopupMenuItem<String>(
                        value: catalogue,
                        child: Text(catalogue),
                      ),
                    ),
                  ];
                },

                child: _tableFilterButton(
                  title: 'Application',
                  width: makesWidth,
                ),
              ),

              const Spacer(),

              PopupMenuButton<String>(
                offset: const Offset(0, 25),
                padding: EdgeInsets.zero,

                onSelected: (value) {
                  productDetailController.filterByPressureRating(
                    value == 'ALL' ? null : value,
                  );
                },

                itemBuilder: (context) {
                  final pressureRatingTypeList =
                      productDetailController.productModel
                          .map((e) => e.pressureRating)
                          .whereType<String>()
                          .where((e) => e.isNotEmpty)
                          .toSet()
                          .toList()
                        ..sort();

                  return [
                    const PopupMenuItem<String>(
                      value: 'ALL',
                      child: Text('All'),
                    ),
                    ...pressureRatingTypeList.map(
                      (catalogue) => PopupMenuItem<String>(
                        value: catalogue,
                        child: Text(catalogue),
                      ),
                    ),
                  ];
                },

                child: _tableFilterButton(
                  title: 'Pressure Rating',
                  width: productTypeWidth,
                ),
              ),
              SizedBox(width: 10),
              PopupMenuButton<String>(
                offset: const Offset(0, 25),
                padding: EdgeInsets.zero,

                onSelected: (value) {
                  productDetailController.filterByMaterial(
                    value == 'ALL' ? null : value,
                  );
                },

                itemBuilder: (context) {
                  final material =
                      productDetailController.productModel
                          .map((e) => e.materialType)
                          .whereType<String>()
                          .where((e) => e.isNotEmpty)
                          .toSet()
                          .toList()
                        ..sort();

                  return [
                    const PopupMenuItem<String>(
                      value: 'ALL',
                      child: Text('All'),
                    ),
                    ...material.map(
                      (catalogue) => PopupMenuItem<String>(
                        value: catalogue,
                        child: Text(catalogue),
                      ),
                    ),
                  ];
                },

                child: _tableFilterButton(
                  title: 'Material',
                  width: productTypeWidth,
                ),
              ),
              SizedBox(width: 10),
              PopupMenuButton<String>(
                offset: const Offset(0, 25),
                padding: EdgeInsets.zero,

                onSelected: (value) {
                  productDetailController.filterByProductDescription(
                    value == 'ALL' ? null : value,
                  );
                },

                itemBuilder: (context) {
                  final description =
                      productDetailController.productModel
                          .map((e) => e.descriptionApplication)
                          .whereType<String>()
                          .where((e) => e.isNotEmpty)
                          .toSet()
                          .toList()
                        ..sort();

                  return [
                    const PopupMenuItem<String>(
                      value: 'ALL',
                      child: Text('All'),
                    ),
                    ...description.map(
                      (catalogue) => PopupMenuItem<String>(
                        value: catalogue,
                        child: Text(catalogue),
                      ),
                    ),
                  ];
                },

                child: _tableFilterButton(
                  title: 'Description / Application',
                  width: tableWidth * 3 / totalFlex,
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          // ============================================================
          // TABLE
          // ============================================================
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Column(
              children: [
                // --- HEADER TABEL (Warna Oranye) ---
                Container(
                  color: const Color(0xFFFF5A00),
                  padding: const EdgeInsets.symmetric(
                    vertical: 14,
                    horizontal: 16,
                  ),

                  child: Row(
                    children: [
                      _customHeaderCell(
                        'Part Number',
                        flex: 2,
                        onTap: () {
                          searchController.getAllProductsV2PartNumberSort(
                            categoryProducts: titleCategory,
                          );
                        },
                      ),
                      const SizedBox(width: 15),
                      _customHeaderCell(
                        'Makes',
                        flex: 2,
                        onTap: () {
                          searchController.getAllProductsMakesSort(
                            categoryProducts: titleCategory,
                          );
                        },
                      ),
                      const SizedBox(width: 15),
                      _customHeaderCell(
                        'Application',
                        flex: 2,
                        onTap: () {
                          searchController.getAllProductsV2EquipmentTypeSort(
                            categoryProducts: titleCategory,
                          );
                        },
                      ),
                      const SizedBox(width: 15),
                      _customHeaderCell(
                        'Size',
                        flex: 2,
                        onTap: () {
                          searchController.getAllProductsSizeSort(
                            categoryProducts: titleCategory,
                          );
                        },
                      ),
                      const SizedBox(width: 15),
                      _customHeaderCell(
                        'Pressure Rating',
                        flex: 2,
                        onTap: () {
                          searchController.getAllProductsPersureRatingSort(
                            categoryProducts: titleCategory,
                          );
                        },
                      ),
                      const SizedBox(width: 15),
                      _customHeaderCell(
                        'Material',
                        flex: 2,
                        onTap: () {
                          searchController.getAllProductsMaterialTypeSort(
                            categoryProducts: titleCategory,
                          );
                        },
                      ),
                      const SizedBox(width: 15),
                      // Deskripsi menggunakan Flex: 5 agar sama panjang dengan tombolnya
                      _customHeaderCell(
                        'Description Application',
                        flex: 5,
                        onTap: () {
                          searchController
                              .getAllProductsDescriptionApplicationSort(
                                categoryProducts: titleCategory,
                              );
                        },
                      ),
                    ],
                  ),
                ),

                // --- DATA TABEL (Warna Putih) ---
                ...data.map((item) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 14,
                      horizontal: 16,
                    ),
                    decoration: const BoxDecoration(
                      color: Colors.white,

                      // Garis bawah sebagai pengganti dividerThickness di DataTable
                      border: Border(
                        bottom: BorderSide(color: Color(0xFFE0E0E0), width: 1),
                      ),
                    ),
                    child: InkWell(
                      onTap: () {
                        Get.toNamed(
                          AppRouteName.productDetailPage,
                          parameters: {
                            'id': item.id.toString(),
                            'category': titleCategory,
                          },
                        );
                      },
                      child: Row(
                        children: [
                          _customDataCell(item.partNumber, flex: 2),
                          const SizedBox(width: 15),
                          _customDataCell(item.makes, flex: 2),
                          const SizedBox(width: 15),
                          _customDataCell(item.application, flex: 2),
                          const SizedBox(width: 15),
                          _customDataCell(item.size, flex: 2),
                          const SizedBox(width: 15),
                          _customDataCell(item.pressureRating, flex: 2),
                          const SizedBox(width: 15),
                          _customDataCell(item.materialType, flex: 2),
                          const SizedBox(width: 15),
                          // Deskripsi menggunakan Flex: 5
                          _customDataCell(item.descriptionApplication, flex: 5),
                        ],
                      ),
                    ),
                  );
                }).toList(), // Hapus toList() jika ada error linting (opsional)
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget buildTableRadiatorAndCap(List<ProductModel> data) {
  //   return Container(
  //     width: 80.w,
  //     color: Colors.black,
  //     padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
  //     child: Center(
  //       child: SingleChildScrollView(
  //         scrollDirection: Axis.horizontal,
  //         child: ClipRRect(
  //           borderRadius: BorderRadius.circular(10),
  //           child: DataTable(
  //             headingRowColor: WidgetStateProperty.all(const Color(0xFFFF5A00)),
  //             dataRowColor: WidgetStateProperty.all(Colors.white),
  //             dividerThickness: 1,
  //             columnSpacing: 30,

  //             columns: [
  //               tableHeader(
  //                 title: 'Part Number',
  //                 onTap: () {
  //                   searchController.getAllProductsV2CatalogueNumber(
  //                     categoryProducts: titleCategory,
  //                   );
  //                 },
  //               ),
  //               tableHeader(
  //                 title: 'Makes',
  //                 onTap: () {
  //                   searchController.getAllProductsMakes(
  //                     categoryProducts: titleCategory,
  //                   );
  //                 },
  //               ),
  //               tableHeader(
  //                 title: 'Application',
  //                 onTap: () {
  //                   searchController.getAllProductsV2EquipmentType(
  //                     categoryProducts: titleCategory,
  //                   );
  //                 },
  //               ),
  //               tableHeader(
  //                 title: 'Size',
  //                 onTap: () {
  //                   searchController.getAllProductsSize(
  //                     categoryProducts: titleCategory,
  //                   );
  //                 },
  //               ),
  //               tableHeader(
  //                 title: 'Pressure Rating',
  //                 onTap: () {
  //                   searchController.getAllProductsPersureRating(
  //                     categoryProducts: titleCategory,
  //                   );
  //                 },
  //               ),
  //               tableHeader(
  //                 title: 'Material',
  //                 onTap: () {
  //                   searchController.getAllProductsMaterialType(
  //                     categoryProducts: titleCategory,
  //                   );
  //                 },
  //               ),
  //               tableHeader(
  //                 title: 'Description Application',
  //                 onTap: () {
  //                   searchController.getAllProductsDescriptionApplication(
  //                     categoryProducts: titleCategory,
  //                   );
  //                 },
  //               ),
  //             ],

  //             rows: data.map((item) {
  //               return DataRow(
  //                 cells: [
  //                   tableCell(item, item.partNumber),
  //                   tableCell(item, item.makes),
  //                   tableCell(item, item.application),
  //                   tableCell(item, item.size),
  //                   tableCell(item, item.pressureRating),
  //                   tableCell(item, item.materialType),
  //                   tableCell(item, item.descriptionApplication),
  //                 ],
  //               );
  //             }).toList(),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  // Widget buildTableCaterpillarTube(List<ProductModel> data) {
  //   // return Container();
  //   return Container(
  //     width: 80.w,
  //     color: Colors.black,
  //     padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
  //     child: Center(
  //       child: SingleChildScrollView(
  //         scrollDirection: Axis.horizontal,
  //         child: ClipRRect(
  //           borderRadius: BorderRadius.circular(10),
  //           child: DataTable(
  //             headingRowColor: WidgetStateProperty.all(const Color(0xFFFF5A00)),
  //             dataRowColor: WidgetStateProperty.all(Colors.white),
  //             dividerThickness: 1,
  //             columnSpacing: 30,

  //             columns: [
  //               tableHeader(
  //                 title: 'Catalogue Number',
  //                 onTap: () {
  //                   searchController.getAllProductsV2CatalogueNumber(
  //                     categoryProducts: titleCategory,
  //                   );
  //                 },
  //               ),

  //               tableHeader(title: 'Makes', onTap: () {}),

  //               tableHeader(
  //                 title: 'Equipment Type',
  //                 onTap: () {
  //                   searchController.getAllProductsV2EquipmentType(
  //                     categoryProducts: titleCategory,
  //                   );
  //                 },
  //               ),

  //               tableHeader(
  //                 title: 'Models',
  //                 onTap: () {
  //                   searchController.getAllProductsV2Models(
  //                     categoryProducts: titleCategory,
  //                   );
  //                 },
  //               ),

  //               tableHeader(
  //                 title: 'OEM Part Number',
  //                 onTap: () {
  //                   searchController.getAllProductsOEMPartNumber(
  //                     categoryProducts: titleCategory,
  //                   );
  //                 },
  //               ),

  //               tableHeader(
  //                 title: 'Industry',
  //                 onTap: () {
  //                   searchController.getAllProductsIndustry(
  //                     categoryProducts: titleCategory,
  //                   );
  //                 },
  //               ),

  //               tableHeader(
  //                 title: 'Product Type',
  //                 onTap: () {
  //                   searchController.getAllProductsProductType(
  //                     categoryProducts: titleCategory,
  //                   );
  //                 },
  //               ),
  //               tableHeader(
  //                 title: 'Application',
  //                 onTap: () {
  //                   searchController.getAllProductsDescriptionApplication(
  //                     categoryProducts: titleCategory,
  //                   );
  //                 },
  //               ),
  //             ],

  //             rows: data.map((item) {
  //               return DataRow(
  //                 cells: [
  //                   tableCell(item, item.catalogueNumber),
  //                   tableCell(item, item.makes),
  //                   tableCell(item, item.equipmentType),
  //                   tableCell(item, item.models),
  //                   tableCell(item, item.oemPartNumber),
  //                   tableCell(item, item.industry),
  //                   tableCell(item, item.productType),
  //                   tableCell(item, item.application),
  //                 ],
  //               );
  //             }).toList(),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
  Widget buildTableCaterpillarTube(List<ProductModel> data) {
    final tableWidth = 80.w - 48; // 24 kiri + 24 kanan

    // Total flex kolom
    const totalFlex = 11;

    final catalogueWidth = tableWidth * 1.5 / totalFlex;
    final makesWidth = tableWidth * 1.0 / totalFlex;
    final equipmentWidth = tableWidth * 1.5 / totalFlex;
    final modelsWidth = tableWidth * 1.2 / totalFlex;
    final oemWidth = tableWidth * 1.5 / totalFlex;
    final industryWidth = tableWidth * 1.0 / totalFlex;
    final productTypeWidth = tableWidth * 1.3 / totalFlex;

    return Container(
      width: 80.w,
      color: Colors.black,
      padding: const EdgeInsets.fromLTRB(24, 14, 24, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  'VARIATION RELATED TO $headerTitle',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Text(
                '*the data that is shown in the column below is clickable*',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          Row(
            children: [
              PopupMenuButton<String>(
                offset: const Offset(0, 25),
                padding: EdgeInsets.zero,

                onSelected: (value) {
                  productDetailController.filterByCatalogueNumber(
                    value == 'ALL' ? null : value,
                  );
                },

                itemBuilder: (context) {
                  final catalogueList =
                      productDetailController.productModel
                          .map((e) => e.catalogueNumber)
                          .whereType<String>()
                          .where((e) => e.isNotEmpty)
                          .toSet()
                          .toList()
                        ..sort();

                  return [
                    const PopupMenuItem<String>(
                      value: 'ALL',
                      child: Text('All'),
                    ),
                    ...catalogueList.map(
                      (catalogue) => PopupMenuItem<String>(
                        value: catalogue,
                        child: Text(catalogue),
                      ),
                    ),
                  ];
                },

                child: _tableFilterButton(
                  title: 'Catalogue Number',
                  width: catalogueWidth,
                ),
              ),

              const Spacer(),

              PopupMenuButton<String>(
                offset: const Offset(0, 25),
                padding: EdgeInsets.zero,

                onSelected: (value) {
                  productDetailController.filterByOEMPartNumber(
                    value == 'ALL' ? null : value,
                  );
                },

                itemBuilder: (context) {
                  final oemPartNumberList =
                      productDetailController.productModel
                          .map((e) => e.oemPartNumber)
                          .whereType<String>()
                          .where((e) => e.isNotEmpty)
                          .toSet()
                          .toList()
                        ..sort();

                  return [
                    const PopupMenuItem<String>(
                      value: 'ALL',
                      child: Text('All'),
                    ),
                    ...oemPartNumberList.map(
                      (catalogue) => PopupMenuItem<String>(
                        value: catalogue,
                        child: Text(catalogue),
                      ),
                    ),
                  ];
                },

                child: _tableFilterButton(
                  title: 'OEM Part Number',
                  width: makesWidth,
                ),
              ),

              const Spacer(),

              PopupMenuButton<String>(
                offset: const Offset(0, 25),
                padding: EdgeInsets.zero,

                onSelected: (value) {
                  productDetailController.filterByProductTypeDesign(
                    value == 'ALL' ? null : value,
                  );
                },

                itemBuilder: (context) {
                  final productTypeDesignList =
                      productDetailController.productModel
                          .map((e) => e.productTypeDesign)
                          .whereType<String>()
                          .where((e) => e.isNotEmpty)
                          .toSet()
                          .toList()
                        ..sort();

                  return [
                    const PopupMenuItem<String>(
                      value: 'ALL',
                      child: Text('All'),
                    ),
                    ...productTypeDesignList.map(
                      (catalogue) => PopupMenuItem<String>(
                        value: catalogue,
                        child: Text(catalogue),
                      ),
                    ),
                  ];
                },

                child: _tableFilterButton(
                  title: 'Product Type Design',
                  width: productTypeWidth,
                ),
              ),

              const Spacer(),
              PopupMenuButton<String>(
                offset: const Offset(0, 25),
                padding: EdgeInsets.zero,

                onSelected: (value) {
                  productDetailController.filterByApplication(
                    value == 'ALL' ? null : value,
                  );
                },

                itemBuilder: (context) {
                  final application =
                      productDetailController.productModel
                          .map((e) => e.application)
                          .whereType<String>()
                          .where((e) => e.isNotEmpty)
                          .toSet()
                          .toList()
                        ..sort();

                  return [
                    const PopupMenuItem<String>(
                      value: 'ALL',
                      child: Text('All'),
                    ),
                    ...application.map(
                      (catalogue) => PopupMenuItem<String>(
                        value: catalogue,
                        child: Text(catalogue),
                      ),
                    ),
                  ];
                },

                child: _tableFilterButton(
                  title: 'Application',
                  width: productTypeWidth,
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          // ============================================================
          // TABLE
          // ============================================================
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Column(
              children: [
                // --- HEADER TABEL (Warna Oranye) ---
                Container(
                  color: const Color(0xFFFF5A00),
                  padding: const EdgeInsets.symmetric(
                    vertical: 14,
                    horizontal: 16,
                  ),

                  child: Row(
                    children: [
                      _customHeaderCell(
                        'Catalog Number',
                        flex: 2,
                        onTap: () {
                          searchController.getAllProductsV2CatalogueNumberSort(
                            categoryProducts: titleCategory,
                          );
                        },
                      ),
                      const SizedBox(width: 15),
                      _customHeaderCell(
                        'Makes',
                        flex: 2,
                        onTap: () {
                          searchController.getAllProductsMakesSort(
                            categoryProducts: titleCategory,
                          );
                        },
                      ),
                      const SizedBox(width: 15),
                      _customHeaderCell(
                        'Equipment Type ',
                        flex: 2,
                        onTap: () {
                          searchController.getAllProductsV2EquipmentTypeSort(
                            categoryProducts: titleCategory,
                          );
                        },
                      ),
                      const SizedBox(width: 15),
                      _customHeaderCell(
                        'Models',
                        flex: 2,
                        onTap: () {
                          searchController.getAllProductsV2ModelsSort(
                            categoryProducts: titleCategory,
                          );
                        },
                      ),
                      const SizedBox(width: 15),
                      _customHeaderCell(
                        'OEM Part Number',
                        flex: 2,
                        onTap: () {
                          searchController.getAllProductsOEMPartNumberSort(
                            categoryProducts: titleCategory,
                          );
                        },
                      ),
                      const SizedBox(width: 15),
                      _customHeaderCell(
                        'Industry',
                        flex: 2,
                        onTap: () {
                          searchController.getAllProductsIndustrySort(
                            categoryProducts: titleCategory,
                          );
                        },
                      ),
                      const SizedBox(width: 15),
                      // Deskripsi menggunakan Flex: 5 agar sama panjang dengan tombolnya
                      _customHeaderCell(
                        'Product Type',
                        flex: 2,
                        onTap: () {
                          searchController.getAllProductsProductTypeSort(
                            categoryProducts: titleCategory,
                          );
                        },
                      ),
                      const SizedBox(width: 15),

                      _customHeaderCell(
                        'Product Type Design',
                        flex: 2,
                        onTap: () {
                          searchController.getAllProductsProductTypeDesignSort(
                            categoryProducts: titleCategory,
                          );
                        },
                      ),
                      const SizedBox(width: 15),

                      _customHeaderCell(
                        'Application',
                        flex: 2,
                        onTap: () {
                          searchController
                              .getAllProductsDescriptionApplicationSort(
                                categoryProducts: titleCategory,
                              );
                        },
                      ),
                    ],
                  ),
                ),

                // --- DATA TABEL (Warna Putih) ---
                ...data.map((item) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 14,
                      horizontal: 16,
                    ),
                    decoration: const BoxDecoration(
                      color: Colors.white,

                      // Garis bawah sebagai pengganti dividerThickness di DataTable
                      border: Border(
                        bottom: BorderSide(color: Color(0xFFE0E0E0), width: 1),
                      ),
                    ),
                    child: InkWell(
                      onTap: () {
                        Get.toNamed(
                          AppRouteName.productDetailPage,
                          parameters: {
                            'id': item.id.toString(),
                            'category': titleCategory,
                          },
                        );
                      },
                      child: Row(
                        children: [
                          _customDataCell(item.catalogueNumber, flex: 2),
                          const SizedBox(width: 15),
                          _customDataCell(item.makes, flex: 2),
                          const SizedBox(width: 15),
                          _customDataCell(item.equipmentType, flex: 2),
                          const SizedBox(width: 15),
                          _customDataCell(item.models, flex: 2),
                          const SizedBox(width: 15),
                          _customDataCell(item.oemPartNumber, flex: 2),
                          const SizedBox(width: 15),
                          _customDataCell(item.industry, flex: 2),
                          const SizedBox(width: 15),
                          // Deskripsi menggunakan Flex: 5
                          _customDataCell(item.productType, flex: 2),
                          const SizedBox(width: 15),
                          _customDataCell(item.productTypeDesign, flex: 2),
                          const SizedBox(width: 15),
                          _customDataCell(item.application, flex: 2),
                        ],
                      ),
                    ),
                  );
                }).toList(), // Hapus toList() jika ada error linting (opsional)
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget data(ProductDetailController controller) {
    return (titleCategory == AppString().radiatorAndCoolers)
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProductDetailTitle(
                title1: 'Catalog Number',
                title2: controller.productModelSingle?.catalogueNumber ?? '',
              ),
              ProductDetailTitle(
                title1: 'Makes',
                title2: controller.productModelSingle?.makes ?? '',
              ),
              ProductDetailTitle(
                title1: 'Equipment Type',
                title2: controller.productModelSingle?.equipmentType ?? '',
              ),
              ProductDetailTitle(
                title1: 'Models',
                title2: controller.productModelSingle?.models ?? '',
              ),
              ProductDetailTitle(
                title1: 'Industry',
                title2: controller.productModelSingle?.industry ?? '',
              ),
              ProductDetailTitle(
                title1: 'OEM Part Number',
                title2: controller.productModelSingle?.oemPartNumber ?? '',
              ),
              ProductDetailTitle(
                title1: 'Product Type',
                title2: controller.productModelSingle?.productType ?? '',
              ),
              ProductDetailTitle(
                title1: 'Product Type Design',
                title2: controller.productModelSingle?.productTypeDesign ?? '',
              ),
              ProductDetailTitle(
                title1: 'Material Type',
                title2: controller.productModelSingle?.materialType ?? '',
              ),
              ProductDetailTitle(
                title1: 'Description / Application',
                title2:
                    controller.productModelSingle?.descriptionApplication ?? '',
              ),
              ProductDetailTitle(
                title1: 'Product Type Design Options',
                title2: '-',
              ),
              ProductDetailTitle(title1: 'Material Type Options', title2: '-'),

              const SizedBox(height: 80),

              InkWell(
                onTap: () async {
                  await controller.sendEmail(controller.productModelSingle);
                },

                child: Container(
                  width: 280,
                  height: 67,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        'assets/images/Rectangle 48_result.webp',
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'REQUEST A QUOTE',
                        style: whiteTextStyle.copyWith(
                          fontSize: 14,
                          fontWeight: bold,
                        ),
                      ),
                      SizedBox(width: 8),
                      Container(
                        width: 20,
                        height: 17,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                              'assets/images/Logo-SHop 1_result.webp',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
        : (titleCategory == AppString().radiatorCapAndAdapters)
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProductDetailTitle(
                title1: 'Part Number',
                title2: controller.productModelSingle?.partNumber ?? '',
              ),
              ProductDetailTitle(
                title1: 'Makes',
                title2: controller.productModelSingle?.makes ?? '',
              ),
              ProductDetailTitle(
                title1: 'Application',
                title2: controller.productModelSingle?.application ?? '',
              ),
              ProductDetailTitle(
                title1: 'Size',
                title2: controller.productModelSingle?.size ?? '',
              ),

              ProductDetailTitle(
                title1: 'Pressure Rating',
                title2: controller.productModelSingle?.pressureRating ?? '',
              ),
              ProductDetailTitle(
                title1: 'Material Type',
                title2: controller.productModelSingle?.materialType ?? '',
              ),
              ProductDetailTitle(
                title1: 'Description / Application',
                title2:
                    controller.productModelSingle?.descriptionApplication ?? '',
              ),

              const SizedBox(height: 80),

              InkWell(
                onTap: () async {
                  await controller.sendEmail(controller.productModelSingle);
                },

                child: Container(
                  width: 280,
                  height: 67,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        'assets/images/Rectangle 48_result.webp',
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'REQUEST A QUOTE',
                        style: whiteTextStyle.copyWith(
                          fontSize: 14,
                          fontWeight: bold,
                        ),
                      ),
                      SizedBox(width: 8),
                      Container(
                        width: 20,
                        height: 17,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                              'assets/images/Logo-SHop 1_result.webp',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
        : (titleCategory == AppString().caterpilarTube)
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProductDetailTitle(
                title1: 'Catalog Number',
                title2: controller.productModelSingle?.catalogueNumber ?? '',
              ),
              ProductDetailTitle(
                title1: 'Makes',
                title2: controller.productModelSingle?.makes ?? '',
              ),
              ProductDetailTitle(
                title1: 'Equipment Type',
                title2: controller.productModelSingle?.equipmentType ?? '',
              ),
              ProductDetailTitle(
                title1: 'Models',
                title2: controller.productModelSingle?.models ?? '',
              ),
              ProductDetailTitle(
                title1: 'Industry',
                title2: controller.productModelSingle?.industry ?? '',
              ),
              ProductDetailTitle(
                title1: 'OEM Part Number',
                title2: controller.productModelSingle?.oemPartNumber ?? '',
              ),
              ProductDetailTitle(
                title1: 'Product Type',
                title2: controller.productModelSingle?.productType ?? '',
              ),
              ProductDetailTitle(
                title1: 'Product Type Design',
                title2: controller.productModelSingle?.productTypeDesign ?? '',
              ),
              ProductDetailTitle(
                title1: 'Material Type',
                title2: controller.productModelSingle?.materialType ?? '',
              ),
              ProductDetailTitle(
                title1: 'Application',
                title2: controller.productModelSingle?.application ?? '',
              ),

              const SizedBox(height: 80),

              InkWell(
                onTap: () async {
                  await controller.sendEmail(controller.productModelSingle);
                },

                child: Container(
                  width: 280,
                  height: 67,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        'assets/images/Rectangle 48_result.webp',
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'REQUEST A QUOTE',
                        style: whiteTextStyle.copyWith(
                          fontSize: 14,
                          fontWeight: bold,
                        ),
                      ),
                      SizedBox(width: 8),
                      Container(
                        width: 20,
                        height: 17,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                              'assets/images/Logo-SHop 1_result.webp',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
        : Container();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductDetailController>(
      builder: (controller) {
        return Globalappbar(
          pageWidget: Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Column(
              children: [
                Text(
                  headerTitle,
                  style: blackTextStyle.copyWith(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 60),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [data(controller)],
                    ),

                    const SizedBox(width: 120),

                    /// KANAN
                    Row(
                      children: [
                        Column(
                          children: [
                            InkWell(
                              onTap: () {
                                Get.dialog(
                                  Dialog(
                                    backgroundColor: Colors.transparent,
                                    insetPadding: const EdgeInsets.all(20),
                                    child: InteractiveViewer(
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            controller
                                                .productModelSingle
                                                ?.drawing2d ??
                                            '',
                                        fit: BoxFit.contain,
                                        placeholder: (_, __) => const Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                        errorWidget: (_, __, ___) => const Icon(
                                          Icons.broken_image,
                                          size: 55,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                              child: CachedNetworkImage(
                                imageUrl:
                                    controller.productModelSingle?.drawing2d ??
                                    '',
                                width: 280,
                                height: 280,
                                fit: BoxFit.cover,
                                placeholder: (_, __) => const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                ),
                                errorWidget: (_, __, ___) =>
                                    const Icon(Icons.person, size: 55),
                              ),
                            ),

                            const SizedBox(height: 10),
                          ],
                        ),
                        SizedBox(width: 40),
                        InkWell(
                          onTap: () {
                            Get.dialog(
                              Dialog(
                                backgroundColor: Colors.transparent,
                                insetPadding: const EdgeInsets.all(20),
                                child: InteractiveViewer(
                                  child: ModelViewer(
                                    src:
                                        controller
                                            .productModelSingle
                                            ?.drawing3d ??
                                        '',
                                    alt: 'Model 3D Astronaut',
                                    cameraControls: true,
                                  ),
                                ),
                              ),
                            );
                          },
                          child: SizedBox(
                            width: 280,
                            height: 280,
                            child: ModelViewer(
                              src:
                                  controller.productModelSingle?.drawing3d ??
                                  '',
                              alt: 'Model 3D Astronaut',
                              cameraControls: true,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 40),

                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Container(),
                //     Expanded(
                //       child: Text(
                //         'VARIATION RELATED TO $headerTitle',
                //         style: blackTextStyle.copyWith(
                //           fontSize: 24,
                //           fontWeight: FontWeight.bold,
                //         ),
                //       ),
                //     ),
                //     Container(),
                //   ],
                // ),
                Text(
                  'VARIATION RELATED TO $headerTitle',
                  style: blackTextStyle.copyWith(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),

                (titleCategory == 'Radiators and Coolers')
                    ? buildTableRadiatorAndCoolers(
                        controller.productModelFilter,
                      )
                    : (titleCategory == 'Radiator Cap and Adapter')
                    ? buildTableRadiatorAndCap(controller.productModelFilter)
                    : (titleCategory ==
                          'CATERPILLAR® TUBE AND SHELL OIL COOLER')
                    ? buildTableCaterpillarTube(controller.productModel)
                    : Container(),
              ],
            ),
          ),
        );
      },
    );
  }
}
