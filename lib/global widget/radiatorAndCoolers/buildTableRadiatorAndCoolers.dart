import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:project/controller/searchProductController.dart';
import 'package:project/global%20widget/radiatorAndCoolers/listOfButtonRadiatorAndCoolers.dart';
import 'package:project/model/productModel.dart';
import 'package:project/routes/routes_name.dart';
import 'package:project/theme/string.dart';
import 'package:project/theme/theme.dart';
import 'package:sizer/sizer.dart';

class BuildTableRadiatorAndCoolers extends StatelessWidget {
  final List<ProductModel> data;
  const BuildTableRadiatorAndCoolers({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    var searchController = Get.find<Searchproductcontroller>();

    Widget tableTitle() {
      return Container(
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
      );
    }

    DataCell tableCell(ProductModel item, String? text) {
      return DataCell(
        InkWell(
          onTap: () {
            Get.toNamed(
              AppRouteName.productDetailPage,
              parameters: {
                'id': item.id.toString(),
                'category': AppString().radiatorAndCoolers,
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
        label: GestureDetector(
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

    return Container(
      width: 80.w,
      color: Colors.black,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          tableTitle(),
          SizedBox(height: 16),

          ListOfButtonRadiatorAndCoolers(
            searchController: searchController,
            categoryProducts: AppString().radiatorAndCoolers,
          ),
          SizedBox(height: 16),
          Center(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: DataTable(
                  headingRowColor: WidgetStateProperty.all(
                    const Color(0xFFFF5A00),
                  ),
                  dataRowColor: WidgetStateProperty.all(Colors.white),
                  dividerThickness: 1,
                  columnSpacing: 30,

                  columns: [
                    tableHeader(
                      title: 'Catalogue Number',
                      onTap: () {
                        searchController.getAllProductsV2CatalogueNumberSort(
                          categoryProducts: AppString().radiatorAndCoolers,
                        );
                      },
                    ),
                    tableHeader(
                      title: 'Makes',
                      onTap: () {
                        searchController.getAllProductsMakesSort(
                          categoryProducts: AppString().radiatorAndCoolers,
                        );
                      },
                    ),
                    tableHeader(
                      title: 'Equipment Type',
                      onTap: () {
                        searchController.getAllProductsV2EquipmentTypeSort(
                          categoryProducts: AppString().radiatorAndCoolers,
                        );
                      },
                    ),
                    tableHeader(
                      title: 'Models',
                      onTap: () {
                        searchController.getAllProductsV2ModelsSort(
                          categoryProducts: AppString().radiatorAndCoolers,
                        );
                      },
                    ),
                    tableHeader(
                      title: 'OEM Part Number',
                      onTap: () {
                        searchController.getAllProductsOEMPartNumberSort(
                          categoryProducts: AppString().radiatorAndCoolers,
                        );
                      },
                    ),
                    tableHeader(
                      title: 'Industry',
                      onTap: () {
                        searchController.getAllProductsIndustrySort(
                          categoryProducts: AppString().radiatorAndCoolers,
                        );
                      },
                    ),
                    tableHeader(
                      title: 'Product Type',
                      onTap: () {
                        searchController.getAllProductsProductTypeSort(
                          categoryProducts: AppString().radiatorAndCoolers,
                        );
                      },
                    ),
                    tableHeader(
                      title: 'Description / Application',
                      onTap: () {
                        searchController
                            .getAllProductsDescriptionApplicationSort(
                              categoryProducts: AppString().radiatorAndCoolers,
                            );
                      },
                    ),
                  ],

                  rows: data.map((item) {
                    return DataRow(
                      cells: [
                        tableCell(item, item.catalogueNumber),
                        tableCell(item, item.makes),
                        tableCell(item, item.equipmentType),
                        tableCell(item, item.models),
                        tableCell(item, item.oemPartNumber),
                        tableCell(item, item.industry),
                        tableCell(item, item.productType),
                        tableCell(item, item.descriptionApplication),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
    ;
  }
}
