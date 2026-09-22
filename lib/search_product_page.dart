import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/controller/globalController.dart';

import 'package:project/controller/searchProductController.dart';
import 'package:project/global_widget/globalAppBar.dart';
import 'package:project/global_widget/radiatorAndCapAdapter/listOfButtonRadiatorAndCap.dart';
import 'package:project/global_widget/radiatorAndCoolers/radiatorAndCoolersWidget.dart';
import 'package:project/global_widget/radiatorAndCatapillar/listOfButtonRadiatorAndCatapillar.dart';
import 'package:project/model/productModel.dart';
import 'package:project/product_radiator_core.dart';
import 'package:project/radiator_core_element.dart';
import 'package:project/routes/routes_name.dart';
import 'package:project/theme/app_images.dart';
import 'package:project/theme/string.dart';
import 'package:project/theme/theme.dart';
import 'package:sizer/sizer.dart';

class SearchProductArgument {
  String? flow;

  SearchProductArgument({required this.flow});
}

class SearchProductPage extends StatefulWidget {
  const SearchProductPage({super.key});

  @override
  State<SearchProductPage> createState() => _SearchProductPageState();
}

class _SearchProductPageState extends State<SearchProductPage> {
  late SearchProductArgument argument;
  @override
  void initState() {
    super.initState();
    final flow = Get.parameters['flow'];

    if (flow != null) {
      argument = SearchProductArgument(flow: flow);
    }
  }

  @override
  Widget build(BuildContext context) {
    var globalController = Get.find<GlobalController>();
    var searchController = Get.find<SearchProductController>();

    DataCell tableCell(ProductModel item, String? text) {
      return DataCell(
        InkWell(
          onTap: () {
            Get.toNamed(
              AppRouteName.productDetailPage,
              parameters: {
                'id': item.id.toString(),
                'category': argument.flow ?? '',
              },
            );
          },
          child: Center(
            child: Text(
              text ?? '',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ),
      );
    }

    DataColumn tableHeader({
      required String title,
      required VoidCallback onTap,
    }) {
      return DataColumn(
        label: InkWell(
          onTap: onTap,
          child: Center(
            child: Row(
              children: [
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: whiteTextStyle.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                  ),
                ),
                Icon(Icons.swap_vert, color: Colors.white),
              ],
            ),
          ),
        ),
      );
    }

    Widget buttonSort(SearchProductController controller) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ElevatedButton.icon(
            onPressed: () async {
              if (argument.flow == 'Radiators and Coolers') {
                await controller.getDataNewRadiatorAndCoolers(
                  categoryProducts: argument.flow ?? '',
                );
              } else if (argument.flow == 'Radiator Cap and Adapter') {
                await controller.getDataNewRadiatorCapAndAdapter(
                  categoryProducts: argument.flow ?? '',
                );
              } else if (argument.flow == AppString().caterpilarTube) {
                await controller.getDataNewCatapillarTubeAndShellOilCooler(
                  categoryProducts: argument.flow ?? '',
                );
              }
              controller.scrollToTable();
            },
            label: Text("Sort", style: whiteTextStyle),
            style: ElevatedButton.styleFrom(backgroundColor: Color(0xffF15E00)),
          ),

          const SizedBox(width: 12),

          ElevatedButton.icon(
            onPressed: () async {
              await controller.reset(flow: argument.flow ?? '');
            },
            icon: const Icon(Icons.refresh, color: Colors.grey),
            label: Text("Reset", style: greyTextStyle),
            style: ElevatedButton.styleFrom(backgroundColor: kBlackColor),
          ),
        ],
      );
    }

    Widget buttonShowAll(SearchProductController controller) {
      return ElevatedButton.icon(
        onPressed: () async {
          searchController.getProductsByCategory(category: argument.flow ?? '');
          controller.scrollToTable();
        },
        label: Text("Show All", style: whiteTextStyle),
        style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
      );
    }

    Widget tableTitle() {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 31,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.black,
              border: Border.all(color: const Color(0xFFFF7800), width: 1),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Container(
              margin: EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 8),
              child: Text(
                '${argument.flow} CATALOGUE LIST',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
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
      );
    }

    DataColumn _tableColumn(
      String title,
      double width, {
      required VoidCallback onTap,
    }) {
      return DataColumn(
        label: InkWell(
          onTap: onTap,
          child: SizedBox(
            width: width,
            child: Text(
              title,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      );
    }

    DataCell _tableDataCell(String? value, double width) {
      return DataCell(
        SizedBox(
          width: width,
          child: Text(value ?? '-', textAlign: TextAlign.start),
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
                color: Colors.black, // Sesuaikan warna teks header kamu
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
          constraints: const BoxConstraints(
            minHeight:
                45, // Atur tinggi minimum agar baris 1 baris tingginya sama dengan yang 2 baris
          ),
          alignment:
              Alignment.center, // Tetap di tengah agar selaras dengan header
          child: Text(
            value ?? '-',
            style: const TextStyle(color: Colors.black),
            textAlign: TextAlign.start, // Teks di dalam sel juga di-center
          ),
        ),
      );
    }

    Widget buildTableCaterpillarTubeAndShellOil(List<ProductModel> data) {
      return Container(
        margin: const EdgeInsets.only(left: 60, right: 60),
        color: Colors.black,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          children: [
            tableTitle(),
            const SizedBox(height: 16),

            // 1. BARIS TOMBOL FILTER
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Listofbuttonradiatorandcatapillar(
                searchController: searchController,
                categoryProducts: AppString().caterpilarTube,
              ),
            ),
            const SizedBox(height: 16),

            // 2. CUSTOM TABLE MENGGUNAKAN ROW & EXPANDED
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
                            searchController
                                .getAllProductsV2CatalogueNumberSort(
                                  categoryProducts: argument.flow ?? '',
                                );
                          },
                        ),
                        const SizedBox(width: 15),
                        _customHeaderCell(
                          'Makes',
                          flex: 2,
                          onTap: () {
                            searchController.getAllProductsMakesSort(
                              categoryProducts: argument.flow ?? '',
                            );
                          },
                        ),
                        const SizedBox(width: 15),
                        _customHeaderCell(
                          'Equipment Type ',
                          flex: 2,
                          onTap: () {
                            searchController.getAllProductsV2EquipmentTypeSort(
                              categoryProducts: argument.flow ?? '',
                            );
                          },
                        ),
                        const SizedBox(width: 15),
                        _customHeaderCell(
                          'Models',
                          flex: 2,
                          onTap: () {
                            searchController.getAllProductsV2ModelsSort(
                              categoryProducts: argument.flow ?? '',
                            );
                          },
                        ),
                        const SizedBox(width: 15),
                        _customHeaderCell(
                          'OEM Part Number',
                          flex: 2,
                          onTap: () {
                            searchController.getAllProductsOEMPartNumberSort(
                              categoryProducts: argument.flow ?? '',
                            );
                          },
                        ),
                        const SizedBox(width: 15),
                        _customHeaderCell(
                          'Industry',
                          flex: 2,
                          onTap: () {
                            searchController.getAllProductsIndustrySort(
                              categoryProducts: argument.flow ?? '',
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
                              categoryProducts: argument.flow ?? '',
                            );
                          },
                        ),
                        const SizedBox(width: 15),

                        _customHeaderCell(
                          'Product Type Design',
                          flex: 2,
                          onTap: () {
                            searchController
                                .getAllProductsProductTypeDesignSort(
                                  categoryProducts: argument.flow ?? '',
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
                                  categoryProducts: argument.flow ?? '',
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
                          bottom: BorderSide(
                            color: Color(0xFFE0E0E0),
                            width: 1,
                          ),
                        ),
                      ),
                      child: InkWell(
                        onTap: () {
                          Get.toNamed(
                            AppRouteName.productDetailPage,
                            parameters: {
                              'id': item.id.toString(),
                              'category': argument.flow ?? '',
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

    Widget buildTableRadiatorAndCap(List<ProductModel> data) {
      return Container(
        margin: const EdgeInsets.only(left: 60, right: 60),
        color: Colors.black,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          children: [
            tableTitle(),
            const SizedBox(height: 16),

            // 1. BARIS TOMBOL FILTER
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ListOfButtonRadiatorAndCap(
                searchController: searchController,
                categoryProducts: argument.flow ?? '',
              ),
            ),
            const SizedBox(height: 16),

            // 2. CUSTOM TABLE MENGGUNAKAN ROW & EXPANDED
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
                              categoryProducts: argument.flow ?? '',
                            );
                          },
                        ),
                        const SizedBox(width: 15),
                        _customHeaderCell(
                          'Makes',
                          flex: 2,
                          onTap: () {
                            searchController.getAllProductsMakesSort(
                              categoryProducts: argument.flow ?? '',
                            );
                          },
                        ),
                        const SizedBox(width: 15),
                        _customHeaderCell(
                          'Application',
                          flex: 2,
                          onTap: () {
                            searchController.getAllProductsV2EquipmentTypeSort(
                              categoryProducts: argument.flow ?? '',
                            );
                          },
                        ),
                        const SizedBox(width: 15),
                        _customHeaderCell(
                          'Size',
                          flex: 2,
                          onTap: () {
                            searchController.getAllProductsSizeSort(
                              categoryProducts: argument.flow ?? '',
                            );
                          },
                        ),
                        const SizedBox(width: 15),
                        _customHeaderCell(
                          'Pressure Rating',
                          flex: 2,
                          onTap: () {
                            searchController.getAllProductsPersureRatingSort(
                              categoryProducts: argument.flow ?? '',
                            );
                          },
                        ),
                        const SizedBox(width: 15),
                        _customHeaderCell(
                          'Material',
                          flex: 2,
                          onTap: () {
                            searchController.getAllProductsMaterialTypeSort(
                              categoryProducts: argument.flow ?? '',
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
                                  categoryProducts: argument.flow ?? '',
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
                          bottom: BorderSide(
                            color: Color(0xFFE0E0E0),
                            width: 1,
                          ),
                        ),
                      ),
                      child: InkWell(
                        onTap: () {
                          Get.toNamed(
                            AppRouteName.productDetailPage,
                            parameters: {
                              'id': item.id.toString(),
                              'category': argument.flow ?? '',
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
                            _customDataCell(
                              item.descriptionApplication,
                              flex: 5,
                            ),
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

    Widget buildTableRadiatorCoreCatalogList(List<ProductModel> data) {
      return Container(
        margin: const EdgeInsets.only(left: 60, right: 60),
        color: Colors.black,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          children: [
            // tableTitle(),
            const SizedBox(height: 16),

            // 1. BARIS TOMBOL FILTER

            // 2. CUSTOM TABLE MENGGUNAKAN ROW & EXPANDED
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
                          'Catalogue Number',
                          flex: 2,
                          onTap: () {
                            searchController
                                .getAllProductsV2CatalogueNumberSort(
                                  categoryProducts: argument.flow ?? '',
                                );
                          },
                        ),
                        const SizedBox(width: 15),
                        _customHeaderCell(
                          'Makes',
                          flex: 2,
                          onTap: () {
                            searchController.getAllProductsMakesSort(
                              categoryProducts: argument.flow ?? '',
                            );
                          },
                        ),
                        const SizedBox(width: 15),
                        _customHeaderCell(
                          'Equipment Type',
                          flex: 2,
                          onTap: () {
                            searchController.getAllProductsV2EquipmentTypeSort(
                              categoryProducts: argument.flow ?? '',
                            );
                          },
                        ),
                        const SizedBox(width: 15),
                        _customHeaderCell(
                          'Models',
                          flex: 2,
                          onTap: () {
                            searchController.getAllProductsV2ModelsSort(
                              categoryProducts: argument.flow ?? '',
                            );
                          },
                        ),
                        const SizedBox(width: 15),
                        _customHeaderCell(
                          'OEM Part Number',
                          flex: 2,
                          onTap: () {
                            searchController.getAllProductsOEMPartNumberSort(
                              categoryProducts: argument.flow ?? '',
                            );
                          },
                        ),
                        const SizedBox(width: 15),
                        _customHeaderCell(
                          'Core Type',
                          flex: 2,
                          onTap: () {
                            searchController.getAllProductsIndustrySort(
                              categoryProducts: argument.flow ?? '',
                            );
                          },
                        ),
                        const SizedBox(width: 15),
                        _customHeaderCell(
                          'Material Type',
                          flex: 2,
                          onTap: () {
                            searchController.getAllProductsMaterialTypeSort(
                              categoryProducts: argument.flow ?? '',
                            );
                          },
                        ),
                        const SizedBox(width: 15),
                        // Kolom terakhir menggunakan Flex: 5 agar mendapat ruang lebih luas
                        _customHeaderCell(
                          'OVER TANK DIMENSION "A"',
                          flex: 2,
                          onTap: () {
                            searchController
                                .getAllProductsDescriptionApplicationSort(
                                  categoryProducts: argument.flow ?? '',
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
                          bottom: BorderSide(
                            color: Color(0xFFE0E0E0),
                            width: 1,
                          ),
                        ),
                      ),
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
                          _customDataCell(item.coreType, flex: 2),
                          const SizedBox(width: 15),
                          _customDataCell(item.materialType, flex: 2),
                          const SizedBox(width: 15),
                          // Kolom terakhir menggunakan Flex: 5 menyesuaikan headernya
                          _customDataCell(item.tankDimension, flex: 2),
                        ],
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

    Widget buildTableRadiatorSealCatalogList(List<ProductModel> data) {
      return Container(
        margin: const EdgeInsets.only(left: 60, right: 60),
        color: Colors.black,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          children: [
            // tableTitle(),
            const SizedBox(height: 16),

            // 1. BARIS TOMBOL FILTER

            // 2. CUSTOM TABLE MENGGUNAKAN ROW & EXPANDED
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
                          'Catalogue Number',
                          flex: 2,
                          onTap: () {
                            searchController
                                .getAllProductsV2CatalogueNumberSortSpecialSeal(
                                  categoryProducts: argument.flow ?? '',
                                );
                          },
                        ),
                        _customHeaderCell(
                          'Makes',
                          flex: 2,

                          onTap: () {
                            searchController.getAllProductsMakesSortSpecial(
                              categoryProducts: argument.flow ?? '',
                            );
                          },
                        ),
                        _customHeaderCell(
                          'Equipment Type',
                          flex: 2,

                          onTap: () {
                            searchController
                                .getAllProductsV2EquipmentTypeSortSpecialSeal(
                                  categoryProducts: argument.flow ?? '',
                                );
                          },
                        ),
                        _customHeaderCell(
                          'Models',
                          flex: 2,

                          onTap: () {
                            searchController
                                .getAllProductsV2ModelsSortSpecialSeal(
                                  categoryProducts: argument.flow ?? '',
                                );
                          },
                        ),
                        _customHeaderCell(
                          'OEM Part Number',
                          flex: 2,

                          onTap: () {
                            searchController
                                .getAllProductsOEMPartNumberSortSpecialSeal(
                                  categoryProducts: argument.flow ?? '',
                                );
                          },
                        ),
                        _customHeaderCell(
                          'Seal type',
                          flex: 2,

                          onTap: () {
                            searchController
                                .getAllProductsIndustrySortSpecialSeal(
                                  categoryProducts: argument.flow ?? '',
                                );
                          },
                        ),
                        _customHeaderCell(
                          'Material Type',
                          flex: 2,

                          onTap: () {
                            searchController
                                .getAllProductsMaterialTypeSortSpecial(
                                  categoryProducts: argument.flow ?? '',
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
                          bottom: BorderSide(
                            color: Color(0xFFE0E0E0),
                            width: 1,
                          ),
                        ),
                      ),
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
                          _customDataCell(item.sealType, flex: 2),
                          const SizedBox(width: 15),
                          _customDataCell(item.materialType, flex: 2),
                          const SizedBox(width: 15),
                        ],
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

    Widget dropDowns({
      required String hint,
      required String? value,
      required List<dynamic> items,
      required String Function(dynamic) labelBuilder,
      required void Function(String?) onChanged,
    }) {
      return Container(
        width: double.infinity, // ⬅️ ini pengganti Expanded
        margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 6),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            isDense: true,
            value: value,
            hint: Text(hint),
            isExpanded: true, // ⬅️ ini tetap boleh
            icon: const Icon(
              Icons.keyboard_arrow_down,
              color: Colors.red,
              size: 20,
            ),
            items: items.map((item) {
              return DropdownMenuItem<String>(
                value: item?.name.toString(),
                child: Text(
                  labelBuilder(item),
                  style: const TextStyle(fontSize: 14),
                ),
              );
            }).toList(),
            onChanged: onChanged,
          ),
        ),
      );
    }

    Widget caterpillarTube(SearchProductController controller) {
      return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(top: 80, left: 60, right: 60),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: kBlackColor,
              ),
              padding: EdgeInsets.all(24),
              child: Column(
                children: [
                  Text(
                    '${argument.flow} CATALOGUE',
                    style: whiteTextStyle.copyWith(fontSize: 48),
                  ),
                  SizedBox(height: 30),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 40),
                              padding: EdgeInsets.all(10),
                              child: TextFormField(
                                onChanged: (value) {
                                  Get.find<SearchProductController>()
                                      .setTypedPlatNumber(value);
                                },
                                decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  suffixIcon: Icon(Icons.search),
                                  border: InputBorder.none,
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.blueGrey,
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(8),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.blue),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(8),
                                    ),
                                  ),
                                  hint: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          'Part Number Search',
                                          style: blackTextStyle.copyWith(
                                            fontSize: 10.sp,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 16),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 40),
                              child: ElevatedButton.icon(
                                onPressed: () async {
                                  await controller.getDatabyPartNumber(
                                    value: controller.typedPlatNumber,
                                    catalogueType: argument.flow,
                                  );
                                  controller.scrollToTable();
                                },
                                icon: const Icon(Icons.search),
                                label: Text(
                                  "SEARCH P/N",
                                  style: whiteTextStyle,
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xffF15E00),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 120,
                        width: 2,
                        decoration: BoxDecoration(
                          color: kWhiteColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            dropDowns(
                              hint: "Select a makes",
                              value: controller.selectedMake,
                              items: controller.makeList,
                              labelBuilder: (item) => item?.name ?? '',
                              onChanged: (val) =>
                                  controller.setSelectedMake(val ?? ''),
                            ),
                            dropDowns(
                              hint: "Select a produt type design",
                              value: controller.selectedProductTypeDesign,
                              items: controller.productDesignList,
                              labelBuilder: (item) => item?.name ?? '',
                              onChanged: (val) => controller
                                  .setSelectedProductTypeDesign(val ?? ''),
                            ),
                          ],
                        ),
                      ),

                      Expanded(
                        child: Column(
                          children: [
                            dropDowns(
                              hint: "Select a model",
                              value: controller.selectedModel,
                              items: controller.modelList,
                              labelBuilder: (item) => item?.name ?? '',
                              onChanged: (val) =>
                                  controller.setSelectedModel(val ?? ''),
                            ),
                            dropDowns(
                              hint: "Select an industry",
                              value: controller.selectedIndustry,
                              items: controller.industryList,
                              labelBuilder: (item) => item?.name ?? '',
                              onChanged: (val) =>
                                  controller.setSelectedIndustry(val ?? ''),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            dropDowns(
                              hint: "Select an equipment",
                              value: controller.selectedEquipmentType,
                              items: controller.equipmentTypeList,
                              labelBuilder: (item) => item?.name ?? '',
                              onChanged: (val) => controller
                                  .setSelectedEquipmentType(val ?? ''),
                            ),
                            SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                buttonSort(controller),

                                const SizedBox(width: 12),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            buttonShowAll(controller),
            SizedBox(height: 20),
            buildTableCaterpillarTubeAndShellOil(controller.productModel),

            SizedBox(height: 15.h),
          ],
        ),
      );
    }

    Widget radiatorsCapAndAdapter(SearchProductController controller) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 80, left: 60, right: 60),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: kBlackColor,
            ),
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Text(
                  '${argument.flow} CATALOGUE',
                  style: whiteTextStyle.copyWith(fontSize: 48),
                ),

                const SizedBox(height: 30),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // =========================
                    // LEFT - PART NUMBER SEARCH
                    // =========================
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 40),
                            padding: const EdgeInsets.all(10),
                            child: TextFormField(
                              onChanged: (value) {
                                controller.setTypedPlatNumber(value);
                              },
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                suffixIcon: const Icon(Icons.search),
                                border: InputBorder.none,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.blueGrey,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.blue,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                hint: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        'Part Number Search',
                                        style: blackTextStyle.copyWith(
                                          fontSize: 10.sp,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 16),

                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 40),
                            child: ElevatedButton.icon(
                              onPressed: () async {
                                await controller.getDatabyPartNumber(
                                  value: controller.typedPlatNumber,
                                  catalogueType: argument.flow,
                                );

                                controller.scrollToTable();
                              },
                              icon: const Icon(Icons.search),
                              label: Text("SEARCH P/N", style: whiteTextStyle),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xffF15E00),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // =========================
                    // DIVIDER
                    // =========================
                    Container(
                      height: 120,
                      width: 2,
                      decoration: BoxDecoration(
                        color: kWhiteColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),

                    const SizedBox(width: 30),

                    Expanded(
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: dropDowns(
                                  hint: "Select a size",
                                  value: controller.selectedSize,
                                  items: controller.sizeList,
                                  labelBuilder: (item) => item?.name ?? '',
                                  onChanged: (val) {
                                    controller.setSelectedSize(val ?? '');
                                  },
                                ),
                              ),

                              const SizedBox(width: 16),

                              // EQUIPMENT
                              Expanded(
                                child: dropDowns(
                                  hint: "Select an pressure rating",
                                  value: controller.selectedPressureRating,
                                  items: controller.pressureRatingList,
                                  labelBuilder: (item) => item?.name ?? '',
                                  onChanged: (val) {
                                    controller.setSelectedPressureRating(
                                      val ?? '',
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 16),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              buttonSort(controller),

                              const SizedBox(width: 12),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          buttonShowAll(controller),
          SizedBox(height: 20),

          buildTableRadiatorAndCap(controller.productModel),

          SizedBox(height: 15.h),
        ],
      );
    }

    Widget resetButton({required VoidCallback onPressed}) {
      return ElevatedButton.icon(
        onPressed: onPressed,
        icon: const Icon(Icons.undo, size: 18, color: Colors.black),
        label: const Text(
          'RESET',
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFFFD600),
          foregroundColor: Colors.black,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      );
    }

    Widget caterPillarCoreReplacement(SearchProductController controller) {
      return Container(
        width: double.infinity,
        color: Colors.grey.shade200, // background halaman
        padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 100),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: kBlackColor, // hitam hanya area content
            borderRadius: BorderRadius.circular(4),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'CATERPILLAR® RADIATOR CORE REPLACEMENT',
                style: whiteTextStyle.copyWith(fontSize: 48, fontWeight: bold),
              ),

              const SizedBox(height: 27),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RadiatorCoreElement(
                    img: AppImages().foldedCore,
                    title: 'FOLDED CORE',
                  ),

                  const SizedBox(width: 40),

                  RadiatorCoreElement(
                    img: AppImages().amocsCore,
                    title: 'AMOCS CORE',
                  ),
                ],
              ),

              const SizedBox(height: 47),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RadiatorCoreElement(
                    img: AppImages().modularCore,
                    title: 'MODULAR CORE',
                  ),

                  const SizedBox(width: 40),

                  RadiatorCoreElement(
                    img: AppImages().ngmrCore,
                    title: 'NGMR CORE',
                  ),
                ],
              ),

              const SizedBox(height: 50),

              Container(
                margin: const EdgeInsets.symmetric(horizontal: 80),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'CATERPILLAR® RADIATOR CORE CATALOG LIST',
                      style: whiteTextStyle.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),

                    resetButton(
                      onPressed: () {
                        searchController.getDataNewCaterpillarRadiatorCore();
                      },
                    ),
                  ],
                ),
              ),

              buildTableRadiatorCoreCatalogList(controller.productModel),

              const SizedBox(height: 50),

              // garis pembatas
              SizedBox(
                width: double.infinity,
                child: Row(
                  children: List.generate(
                    200,
                    (index) => Container(
                      width: 5,
                      height: 3,
                      margin: const EdgeInsets.only(right: 2),
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 50),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ProductRadiatorCore(
                    img: AppImages().foldedSealCore,
                    title: 'FOLDED CORE SEAL',
                  ),
                  ProductRadiatorCore(
                    img: AppImages().amocsSealCore,
                    title: 'AMOCS CORE SEAL',
                  ),
                  ProductRadiatorCore(
                    img: AppImages().modularSealCore,
                    title: 'MODULAR CORE SEAL',
                  ),
                  ProductRadiatorCore(
                    img: AppImages().ngmrSealCore,
                    title: 'NGMR CORE SEAL',
                  ),
                ],
              ),

              const SizedBox(height: 30),

              Container(
                margin: const EdgeInsets.symmetric(horizontal: 80),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'CATERPILLAR® RADIATOR CORE SEAL CATALOG LIST',
                      style: whiteTextStyle.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),

                    resetButton(
                      onPressed: () {
                        searchController.getDataNewCaterpillarRadiatorCore(
                          isTableSeal: true,
                        );
                      },
                    ),
                  ],
                ),
              ),

              buildTableRadiatorSealCatalogList(
                controller.productModelSealSpecial,
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      );
    }

    return GetBuilder<SearchProductController>(
      initState: (state) async {
        await searchController.getProductsByCategoryForListFilterCatalog(
          category: argument.flow ?? '',
        );
        await searchController
            .getProductsByCategoryForListFilterProductTypeDescription(
              category: argument.flow ?? '',
            );
        await searchController
            .getProductsByCategoryForListFilterDescriptionApplication(
              category: argument.flow ?? '',
            );
        await searchController.getProductsByCategoryForListFilterAeomPartNumber(
          category: argument.flow ?? '',
        );
        await searchController.getProductsByCategoryForListFilterModels(
          category: argument.flow ?? '',
        );
        await searchController.getProductsByCategoryForListFilterEquipmentType(
          category: argument.flow ?? '',
        );
        await searchController.getProductsByCategoryForListFilterAeomPartNumber(
          category: argument.flow ?? '',
        );
        await searchController.getProductsByCategoryForListFilterIndustry(
          category: argument.flow ?? '',
        );
        await searchController.getProductsByCategoryForListFilterProductType(
          category: argument.flow ?? '',
        );
        await searchController
            .getProductsByCategoryForListFilterProductTypeDesign(
              category: argument.flow ?? '',
            );
        await searchController.getProductsByCategoryForListFilterPartNumber(
          category: argument.flow ?? '',
        );
        await searchController.getProductsByCategoryForListFilterPartNumber(
          category: argument.flow ?? '',
        );
        await searchController.getProductsByCategoryForListFilterMakes(
          category: argument.flow ?? '',
        );
        await searchController.getProductsByCategoryForListFilterPressureRating(
          category: argument.flow ?? '',
        );
        await searchController.getProductsByCategoryForListFilterApplication(
          category: argument.flow ?? '',
        );
        await searchController.getProductsByCategoryForListFilterSize(
          category: argument.flow ?? '',
        );
        await searchController.getProductsByCategoryForListFilterMaterial(
          category: argument.flow ?? '',
        );
        await searchController
            .getProductsByCategoryForListFilterDescriptionApplication(
              category: argument.flow ?? '',
            );

        await Get.find<SearchProductController>().getAllMake(
          category: argument.flow,
        );
        await Get.find<SearchProductController>().getAllProducts(
          category: argument.flow,
        );
        await Get.find<SearchProductController>().getAllModel(
          category: argument.flow,
        );
        await Get.find<SearchProductController>().getAllIndustry(
          category: argument.flow,
        );
        await Get.find<SearchProductController>().getAllEquipmentType(
          category: argument.flow,
        );
        await Get.find<SearchProductController>().getAllSize();
        await Get.find<SearchProductController>().getAllPressureRating();
        await Get.find<SearchProductController>().getAllProductTypeDesign(
          category: argument.flow,
        );
      },

      builder: (controller) {
        return Globalappbar(
          backgroundColor: backgroundgrey,

          pageWidget: SingleChildScrollView(
            child: (argument.flow == AppString().radiatorAndCoolers)
                ? Radiatorandcoolerswidget(controller: controller)
                : (argument.flow == AppString().radiatorCapAndAdapters)
                ? radiatorsCapAndAdapter(controller)
                : (argument.flow == AppString().caterpillarRadiatorCore)
                ? caterPillarCoreReplacement(controller)
                : (argument.flow == AppString().caterpilarTube)
                ? caterpillarTube(controller)
                : Container(),
          ),
        );
      },
    );
  }
}
