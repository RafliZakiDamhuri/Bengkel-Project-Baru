import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:project/controller/searchProductController.dart';
import 'package:project/global_widget/radiatorAndCoolers/listOfButtonRadiatorAndCoolers.dart';
import 'package:project/model/productModel.dart';
import 'package:project/routes/routes_name.dart';
import 'package:project/theme/string.dart';
import 'package:sizer/sizer.dart';

class BuildTableRadiatorAndCoolers extends StatelessWidget {
  final List<ProductModel> data;
  const BuildTableRadiatorAndCoolers({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    var searchController = Get.find<SearchProductController>();

    Widget tableTitle() {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 319,
            height: 31,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.black,
              border: Border.all(color: const Color(0xFFFF7800), width: 1),
              borderRadius: BorderRadius.circular(5),
            ),
            child: const Text(
              'RADIATORS AND COOLERS CATALOG LIST',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
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
          margin: const EdgeInsets.only(left: 10),
          constraints: const BoxConstraints(minHeight: 45),
          alignment: Alignment.center,
          child: Text(
            value ?? '-',
            style: const TextStyle(color: Colors.black),
            textAlign: TextAlign.left,
          ),
        ),
      );
    }

    return Container(
      width: 92.w, // Bisa diganti margin left right seperti contohmu jika perlu
      color: Colors.black,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          tableTitle(),
          const SizedBox(height: 16),

          // 1. BARIS TOMBOL FILTER (Dibungkus padding agar sejajar dengan isi tabel)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ListOfButtonRadiatorAndCoolers(
              searchController: searchController,
              categoryProducts: AppString().radiatorAndCoolers,
            ),
          ),
          const SizedBox(height: 16),

          // 2. TABEL TANPA SCROLL HORIZONTAL
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
                        flex: 3,
                        onTap: () {
                          searchController.getAllProductsMakesSort(
                            categoryProducts: AppString().radiatorAndCoolers,
                          );
                        },
                      ),
                      const SizedBox(width: 15),
                      _customHeaderCell(
                        'Equipment Type',
                        flex: 3,
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
                        flex: 3,
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
                          _customDataCell(item.makes, flex: 3),
                          const SizedBox(width: 15),
                          _customDataCell(item.equipmentType, flex: 3),
                          const SizedBox(width: 15),
                          _customDataCell(item.models, flex: 2),
                          const SizedBox(width: 15),
                          _customDataCell(item.oemPartNumber, flex: 2),
                          const SizedBox(width: 15),
                          _customDataCell(item.industry, flex: 2),
                          const SizedBox(width: 15),
                          _customDataCell(item.productType, flex: 3),
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
}
