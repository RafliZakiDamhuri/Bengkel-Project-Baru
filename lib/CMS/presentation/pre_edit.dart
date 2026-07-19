import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/CMS/controller/cms_controller.dart';
import 'package:project/CMS/global_widget/textfield_widget.dart';
import 'package:project/CMS/presentation/edit_data.dart';
import 'package:project/controller/searchProductController.dart';
import 'package:project/global%20widget/customButton.dart';
import 'package:project/model/productModel.dart';
import 'package:project/routes/routes_name.dart';
import 'package:project/theme/theme.dart';

class PreEdit extends StatelessWidget {
  final String titleCategory;

  const PreEdit({super.key, required this.titleCategory});

  @override
  Widget build(BuildContext context) {
    var searchController = Get.find<Searchproductcontroller>();
    var cmsController = Get.find<CmsController>();

    DataCell tableCell(String? text) {
      return DataCell(
        Center(
          child: Text(
            text ?? '',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 14),
          ),
        ),
      );
    }

    DataColumn tableHeader({
      required String title,
      required VoidCallback onTap,
    }) {
      return DataColumn(
        label: Center(
          child: Container(
            margin: EdgeInsets.only(left: 40),
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
      );
    }

    Widget buildTableRadiatorAndCoolers(List<ProductModel> data) {
      return Card(
        elevation: 2,
        margin: const EdgeInsets.all(8),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical, // Scroll atas-bawah
          child: SingleChildScrollView(
            scrollDirection:
                Axis.horizontal, // Scroll kiri-kanan untuk kolom banyak
            child: Row(
              children: [
                DataTable(
                  headingRowColor: WidgetStateProperty.all(darkGrey),
                  dividerThickness: 2,

                  columns: [
                    tableHeader(
                      title: 'Catalogue Number',
                      onTap: searchController.getAllProductsV2CatalogueNumber,
                    ),
                    tableHeader(title: 'Makes ', onTap: () {}),
                    tableHeader(
                      title: 'Equipment Type',
                      onTap: searchController.getAllProductsV2EquipmentType,
                    ),
                    tableHeader(
                      title: 'Models ',
                      onTap: searchController.getAllProductsV2Models,
                    ),
                    tableHeader(
                      title: 'OEM Part Number',
                      onTap: searchController.getAllProductsOEMPartNumber,
                    ),
                    tableHeader(
                      title: 'Industry',
                      onTap: searchController.getAllProductsIndustry,
                    ),
                    tableHeader(
                      title: 'Product Type',
                      onTap: searchController.getAllProductsProductType,
                    ),
                    // tableHeader(
                    //   title: 'Product Type Design',
                    //   onTap: searchController.getAllProductsProductType,
                    // ),
                    // tableHeader(
                    //   title: 'Material',
                    //   onTap:
                    //       searchController.getAllProductsDescriptionApplication,
                    // ),
                    // tableHeader(
                    //   title: 'DESCRIPTION / APPLICATION',
                    //   onTap:
                    //       searchController.getAllProductsDescriptionApplication,
                    // ),
                    DataColumn(
                      label: GestureDetector(
                        onTap: () {},
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Action Type',
                              textAlign: TextAlign.center,
                              style: whiteTextStyle.copyWith(
                                fontWeight: FontWeight.w700,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                  rows: data.map((item) {
                    return DataRow(
                      cells: [
                        tableCell(item.catalogueNumber),
                        tableCell(item.makes),
                        tableCell(item.equipmentType),
                        tableCell(item.models),
                        tableCell(item.oemPartNumber),
                        tableCell(item.industry),
                        tableCell(item.productType),

                        DataCell(
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Get.toNamed(
                                      AppRouteName.editData,
                                      arguments: EditDataArgument(
                                        titleCategory: titleCategory,
                                        productModel: item,
                                      ),
                                    );
                                  },
                                  child: Icon(
                                    Icons.edit_calendar,
                                    color: kBlueColor,
                                  ),
                                ),
                                SizedBox(width: 10),
                                GestureDetector(
                                  onTap: () async {
                                    await cmsController.deleteProduct(item.id);
                                  },
                                  child: Icon(Icons.delete, color: Colors.red),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return GetBuilder<CmsController>(
      builder: (controller) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(top: 80, bottom: 20, left: 60),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    titleCategory,
                    style: blackTextStyle.copyWith(fontSize: 30),
                  ),
                  buildTableRadiatorAndCoolers(controller.productModel),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
