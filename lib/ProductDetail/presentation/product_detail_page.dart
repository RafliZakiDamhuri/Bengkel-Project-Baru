import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/state_manager.dart';
import 'package:project/CMS/controller/cms_controller.dart';
import 'package:project/CMS/global_widget/custom_table.dart';
import 'package:project/ProductDetail/controller/product_detail_controller.dart';
import 'package:project/controller/searchProductController.dart';
import 'package:project/global%20widget/globalAppBar.dart';
import 'package:project/ProductDetail/widget/product_detail_title.dart';
import 'package:project/model/productModel.dart';
import 'package:project/routes/routes_name.dart';
import 'package:project/theme/string.dart';
import 'package:project/theme/theme.dart';

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({super.key});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  var productDetailController = Get.find<ProductDetailController>();
  var searchController = Get.find<Searchproductcontroller>();

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
      }
    });
  }

  DataCell tableCell(String? value) {
    return DataCell(
      Center(
        child: Text(value ?? '-', softWrap: true, textAlign: TextAlign.center),
      ),
    );
  }

  DataColumn tableHeader({required String title, required VoidCallback onTap}) {
    return DataColumn(
      label: GestureDetector(
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

  Widget buildTableRadiatorAndCoolers(List<ProductModel> data) {
    return CustomProductTable(
      columns: [
        tableHeader(
          title: 'Catalogue Number',
          onTap: () {
            searchController.getAllProductsV2CatalogueNumber(
              categoryProducts: titleCategory,
            );
          },
        ),

        tableHeader(title: 'Makes', onTap: () {}),

        tableHeader(
          title: 'Equipment Type',
          onTap: () {
            searchController.getAllProductsV2EquipmentType(
              categoryProducts: titleCategory,
            );
          },
        ),

        tableHeader(
          title: 'Models',
          onTap: () {
            searchController.getAllProductsV2Models(
              categoryProducts: titleCategory,
            );
          },
        ),

        tableHeader(
          title: 'OEM Part Number',
          onTap: () {
            searchController.getAllProductsOEMPartNumber(
              categoryProducts: titleCategory,
            );
          },
        ),

        tableHeader(
          title: 'Industry',
          onTap: () {
            searchController.getAllProductsIndustry(
              categoryProducts: titleCategory,
            );
          },
        ),

        tableHeader(
          title: 'Product Type',
          onTap: () {
            searchController.getAllProductsProductType(
              categoryProducts: titleCategory,
            );
          },
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
          ],
        );
      }).toList(),
    );
  }

  Widget buildTableRadiatorAndCap(List<ProductModel> data) {
    return CustomProductTable(
      columns: [
        tableHeader(
          title: 'Part Number',
          onTap: () {
            searchController.getAllProductsV2CatalogueNumber(
              categoryProducts: titleCategory,
            );
          },
        ),
        tableHeader(
          title: 'Makes',
          onTap: () {
            searchController.getAllProductsMakes(
              categoryProducts: titleCategory,
            );
          },
        ),
        tableHeader(
          title: 'Application',
          onTap: () {
            searchController.getAllProductsV2EquipmentType(
              categoryProducts: titleCategory,
            );
          },
        ),
        tableHeader(
          title: 'Size',
          onTap: () {
            searchController.getAllProductsSize(
              categoryProducts: titleCategory,
            );
          },
        ),
        tableHeader(
          title: 'Pressure Rating',
          onTap: () {
            searchController.getAllProductsPersureRating(
              categoryProducts: titleCategory,
            );
          },
        ),
        tableHeader(
          title: 'Material',
          onTap: () {
            searchController.getAllProductsMaterialType(
              categoryProducts: titleCategory,
            );
          },
        ),
        tableHeader(
          title: 'Description Application',
          onTap: () {
            searchController.getAllProductsDescriptionApplication(
              categoryProducts: titleCategory,
            );
          },
        ),
      ],

      rows: data.map((item) {
        return DataRow(
          cells: [
            tableCell(item.partNumber),
            tableCell(item.makes),
            tableCell(item.application),
            tableCell(item.size),
            tableCell(item.pressureRating),
            tableCell(item.materialType),
            tableCell(item.descriptionApplication),
          ],
        );
      }).toList(),
    );
  }

  Widget buildTableCaterpillarTube(List<ProductModel> data) {
    // return Container();
    return CustomProductTable(
      columns: [
        tableHeader(
          title: 'Catalogue Number',
          onTap: () {
            searchController.getAllProductsV2CatalogueNumber(
              categoryProducts: titleCategory,
            );
          },
        ),

        tableHeader(title: 'Makes', onTap: () {}),

        tableHeader(
          title: 'Equipment Type',
          onTap: () {
            searchController.getAllProductsV2EquipmentType(
              categoryProducts: titleCategory,
            );
          },
        ),

        tableHeader(
          title: 'Models',
          onTap: () {
            searchController.getAllProductsV2Models(
              categoryProducts: titleCategory,
            );
          },
        ),

        tableHeader(
          title: 'OEM Part Number',
          onTap: () {
            searchController.getAllProductsOEMPartNumber(
              categoryProducts: titleCategory,
            );
          },
        ),

        tableHeader(
          title: 'Industry',
          onTap: () {
            searchController.getAllProductsIndustry(
              categoryProducts: titleCategory,
            );
          },
        ),

        tableHeader(
          title: 'Product Type',
          onTap: () {
            searchController.getAllProductsProductType(
              categoryProducts: titleCategory,
            );
          },
        ),
        tableHeader(
          title: 'Application',
          onTap: () {
            searchController.getAllProductsDescriptionApplication(
              categoryProducts: titleCategory,
            );
          },
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
            tableCell(item.application),
          ],
        );
      }).toList(),
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

              const SizedBox(height: 80),

              GestureDetector(
                onTap: () {
                  Get.toNamed(AppRouteName.searchProduct);
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

              GestureDetector(
                onTap: () {
                  Get.toNamed(AppRouteName.searchProduct);
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

              GestureDetector(
                onTap: () {
                  Get.toNamed(AppRouteName.searchProduct);
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
                    /// KIRI
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        data(controller),
                        // ProductDetailTitle(
                        //   title1: 'Catalog Number',
                        //   title2:
                        //       controller.productModelSingle?.catalogueNumber ??
                        //       '',
                        // ),
                        // ProductDetailTitle(title1: 'Makes', title2: 'Komatsu'),
                        // ProductDetailTitle(
                        //   title1: 'Equipment Type',
                        //   title2:
                        //       controller.productModelSingle?.equipmentType ??
                        //       '',
                        // ),
                        // ProductDetailTitle(
                        //   title1: 'Models',
                        //   title2: controller.productModelSingle?.models ?? '',
                        // ),
                        // ProductDetailTitle(
                        //   title1: 'Industry',
                        //   title2: controller.productModelSingle?.industry ?? '',
                        // ),
                        // ProductDetailTitle(
                        //   title1: 'OEM Part Number',
                        //   title2:
                        //       controller.productModelSingle?.oemPartNumber ??
                        //       '',
                        // ),
                        // ProductDetailTitle(
                        //   title1: 'Product Type',
                        //   title2:
                        //       controller.productModelSingle?.productType ?? '',
                        // ),
                        // ProductDetailTitle(
                        //   title1: 'Product Type Design',
                        //   title2:
                        //       controller
                        //           .productModelSingle
                        //           ?.productTypeDesign ??
                        //       '',
                        // ),
                        // ProductDetailTitle(
                        //   title1: 'Material Type',
                        //   title2:
                        //       controller.productModelSingle?.materialType ?? '',
                        // ),
                        // ProductDetailTitle(
                        //   title1: 'Description / Application',
                        //   title2:
                        //       controller
                        //           .productModelSingle
                        //           ?.descriptionApplication ??
                        //       '',
                        // ),

                        // const SizedBox(height: 80),

                        // GestureDetector(
                        //   onTap: () {
                        //     Get.toNamed(AppRouteName.searchProduct);
                        //   },

                        //   child: Container(
                        //     width: 280,
                        //     height: 67,
                        //     decoration: BoxDecoration(
                        //       image: DecorationImage(
                        //         image: AssetImage(
                        //           'assets/images/Rectangle 48_result.webp',
                        //         ),
                        //       ),
                        //     ),
                        //     child: Row(
                        //       mainAxisAlignment: MainAxisAlignment.center,
                        //       children: [
                        //         Text(
                        //           'REQUEST A QUOTE',
                        //           style: whiteTextStyle.copyWith(
                        //             fontSize: 14,
                        //             fontWeight: bold,
                        //           ),
                        //         ),
                        //         SizedBox(width: 8),
                        //         Container(
                        //           width: 20,
                        //           height: 17,
                        //           decoration: BoxDecoration(
                        //             image: DecorationImage(
                        //               image: AssetImage(
                        //                 'assets/images/Logo-SHop 1_result.webp',
                        //               ),
                        //             ),
                        //           ),
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),

                    const SizedBox(width: 120),

                    /// KANAN
                    Column(
                      children: [
                        CachedNetworkImage(
                          imageUrl:
                              controller.productModelSingle?.drawing2d ?? '',
                          width: 280,
                          height: 280,
                          fit: BoxFit.cover,
                          placeholder: (_, __) => const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                          errorWidget: (_, __, ___) =>
                              const Icon(Icons.person, size: 55),
                        ),

                        const SizedBox(height: 10),

                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     GestureDetector(
                        //       onTap: () {},
                        //       child: const Text(
                        //         '2D Drawing Front and Side View',
                        //         style: TextStyle(
                        //           color: Colors.blue,
                        //           fontWeight: FontWeight.bold,
                        //           decoration: TextDecoration.underline,
                        //         ),
                        //       ),
                        //     ),

                        //     const SizedBox(width: 25),

                        //     GestureDetector(
                        //       onTap: () {},
                        //       child: const Text(
                        //         '3D Drawing',
                        //         style: TextStyle(color: Colors.grey),
                        //       ),
                        //     ),
                        //   ],
                        // ),
                      ],
                    ),
                  ],
                ),

                (titleCategory == 'Radiators and Coolers')
                    ? buildTableRadiatorAndCoolers(controller.productModel)
                    : (titleCategory == 'Radiator Cap and Adapter')
                    ? buildTableRadiatorAndCap(controller.productModel)
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
