import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:project/CMS/controller/cms_controller.dart';
import 'package:project/CMS/global_widget/custom_table.dart';
import 'package:project/CMS/global_widget/textfield_widget.dart';
import 'package:project/CMS/presentation/edit_data.dart';
import 'package:project/controller/searchProductController.dart';
import 'package:project/global%20widget/customButton.dart';
import 'package:project/model/productModel.dart';
import 'package:project/routes/routes_name.dart';
import 'package:project/theme/string.dart';
import 'package:project/theme/theme.dart';

class PreEdit extends StatefulWidget {
  final String titleCategory;

  const PreEdit({super.key, required this.titleCategory});

  @override
  State<PreEdit> createState() => _PreEditState();
}

class _PreEditState extends State<PreEdit> {
  var cmsController = Get.find<CmsController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var searchController = Get.find<Searchproductcontroller>();
    DataCell tableCell(String? value) {
      return DataCell(
        Center(
          child: SizedBox(
            width: 120,
            child: Text(
              value ?? '-',
              softWrap: true,
              textAlign: TextAlign.center,
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
            child: Container(
              margin: const EdgeInsets.only(left: 40),
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

    DataCell actionCell({
      required VoidCallback onEdit,
      required VoidCallback onDelete,
    }) {
      return DataCell(
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: onEdit,
                child: Icon(Icons.edit_calendar, color: kBlueColor),
              ),

              const SizedBox(width: 10),

              GestureDetector(
                onTap: onDelete,
                child: const Icon(Icons.delete, color: Colors.red),
              ),
            ],
          ),
        ),
      );
    }

    Widget buildTableRadiatorAndCoolers(List<ProductModel> data) {
      return CustomProductTable(
        columns: [
          tableHeader(
            title: 'Catalogue Number',
            onTap: searchController.getAllProductsV2CatalogueNumber,
          ),

          tableHeader(title: 'Makes', onTap: () {}),

          tableHeader(
            title: 'Equipment Type',
            onTap: searchController.getAllProductsV2EquipmentType,
          ),

          tableHeader(
            title: 'Models',
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

          tableHeader(title: 'Action Type', onTap: () {}),
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

              actionCell(
                onEdit: () {
                  Get.toNamed(
                    AppRouteName.editData,
                    parameters: {
                      'id': item.id.toString(),
                      'category': widget.titleCategory,
                    },
                  );
                },

                onDelete: () async {
                  await cmsController.deleteProduct(item.id);
                },
              ),
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
            onTap: searchController.getAllProductsV2CatalogueNumber,
          ),

          tableHeader(title: 'Makes', onTap: () {}),

          tableHeader(
            title: 'Equipment Type',
            onTap: searchController.getAllProductsV2EquipmentType,
          ),

          tableHeader(
            title: 'Models',
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

          tableHeader(title: 'Action Type', onTap: () {}),
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

              actionCell(
                onEdit: () {
                  Get.toNamed(
                    AppRouteName.editData,
                    parameters: {
                      'id': item.id.toString(),
                      'category': widget.titleCategory,
                    },
                  );
                },

                onDelete: () async {
                  await cmsController.deleteProduct(item.id);
                },
              ),
            ],
          );
        }).toList(),
      );
    }

    Widget buildTableCaterpillarRadiatorCore(List<ProductModel> data) {
      return CustomProductTable(
        columns: [
          tableHeader(
            title: 'Catalogue Number',
            onTap: searchController.getAllProductsV2CatalogueNumber,
          ),

          tableHeader(title: 'Makes', onTap: () {}),

          tableHeader(
            title: 'Equipment Type',
            onTap: searchController.getAllProductsV2EquipmentType,
          ),

          tableHeader(
            title: 'Models',
            onTap: searchController.getAllProductsV2Models,
          ),

          tableHeader(
            title: 'OEM Part Number',
            onTap: searchController.getAllProductsOEMPartNumber,
          ),

          tableHeader(
            title: 'Product Type',
            onTap: searchController.getAllProductsProductType,
          ),

          tableHeader(
            title: 'Core Type',
            onTap: searchController.getAllProductsProductType,
          ),

          tableHeader(
            title: 'Seal Type',
            onTap: searchController.getAllProductsProductType,
          ),

          tableHeader(
            title: 'Material Type',
            onTap: searchController.getAllProductsProductType,
          ),

          tableHeader(
            title: 'Over Tank Dimension',
            onTap: searchController.getAllProductsProductType,
          ),

          tableHeader(title: 'Action Type', onTap: () {}),
        ],

        rows: data.map((item) {
          return DataRow(
            cells: [
              tableCell(item.catalogueNumber),
              tableCell(item.makes),
              tableCell(item.equipmentType),
              tableCell(item.models),
              tableCell(item.oemPartNumber),
              tableCell(item.productType),
              tableCell(item.coreType),
              tableCell(item.sealType),
              tableCell(item.materialType),
              tableCell(item.tankDimension),

              actionCell(
                onEdit: () {
                  Get.toNamed(
                    AppRouteName.editData,
                    parameters: {
                      'id': item.id.toString(),
                      'category': widget.titleCategory,
                    },
                  );
                },
                onDelete: () async {
                  await cmsController.deleteProduct(item.id);
                },
              ),
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
            onTap: searchController.getAllProductsV2CatalogueNumber,
          ),

          tableHeader(
            title: 'Makes',
            onTap: () {
              searchController.getAllProductsV2(
                categoryProducts: widget.titleCategory,
              );
            },
          ),

          tableHeader(
            title: 'Application',
            onTap: searchController.getAllProductsV2EquipmentType,
          ),

          tableHeader(
            title: 'Size',
            onTap: searchController.getAllProductsV2Models,
          ),

          tableHeader(
            title: 'Pressure Rating',
            onTap: searchController.getAllProductsOEMPartNumber,
          ),

          tableHeader(
            title: 'Material',
            onTap: searchController.getAllProductsIndustry,
          ),

          tableHeader(
            title: 'Description Application',
            onTap: searchController.getAllProductsProductType,
          ),

          tableHeader(title: 'Action Type', onTap: () {}),
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

              actionCell(
                onEdit: () {
                  print('Ini adalah item partnumber : ${item.partNumber}');
                  Get.toNamed(
                    AppRouteName.editData,
                    parameters: {
                      'id': item.id.toString(),
                      'category': widget.titleCategory,
                    },
                  );
                },

                onDelete: () async {
                  await cmsController.deleteProduct(item.id);
                },
              ),
            ],
          );
        }).toList(),
      );
    }

    Widget loading() {
      return Center(
        child: LoadingAnimationWidget.staggeredDotsWave(
          color: kBlackColor,
          size: 100,
        ),
      );
    }

    return GetBuilder<CmsController>(
      builder: (controller) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(top: 80, bottom: 20, left: 20),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      widget.titleCategory,
                      style: blackTextStyle.copyWith(fontSize: 30),
                    ),
                    (controller.isLoading == true)
                        ? loading()
                        : (widget.titleCategory ==
                              AppString().radiatorAndCoolers)
                        ? buildTableRadiatorAndCoolers(controller.productModel)
                        : (widget.titleCategory ==
                              AppString().radiatorCapAndAdapters)
                        ? buildTableRadiatorAndCap(controller.productModel)
                        : (widget.titleCategory ==
                              AppString().caterpillarRadiatorCore)
                        ? buildTableCaterpillarRadiatorCore(
                            controller.productModel,
                          )
                        : (widget.titleCategory == AppString().caterpilarTube)
                        ? buildTableCaterpillarTube(controller.productModel)
                        : Container(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
