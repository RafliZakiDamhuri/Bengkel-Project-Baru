import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart' show Get;
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:project/controller/searchProductController.dart';
import 'package:project/theme/theme.dart';

class ListOfButtonRadiatorAndCoolers extends StatelessWidget {
  final Searchproductcontroller searchController;
  final String categoryProducts;
  const ListOfButtonRadiatorAndCoolers({
    super.key,
    required this.searchController,
    required this.categoryProducts,
  });

  @override
  Widget build(BuildContext context) {
    var searchController = Get.find<Searchproductcontroller>();

    return Row(
      children: [
        Expanded(
          flex: 9,
          child: PopupMenuButton<String>(
            offset: const Offset(0, 25),
            padding: EdgeInsets.zero,

            onSelected: (value) {
              searchController.getDataByFilter(
                value,
                'Catalogue Number',
                categoryProducts: categoryProducts,
              );
            },

            itemBuilder: (context) {
              return List.generate(
                searchController.productModelForListFilterCatalogNumber.length,
                (index) {
                  final data = searchController
                      .productModelForListFilterCatalogNumber[index];

                  return PopupMenuItem<String>(
                    value: data.catalogueNumber,
                    child: Text(data.catalogueNumber ?? '-'),
                  );
                },
              );
            },

            child: Container(
              height: 22,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(2),
              ),
              child: Text('Catalogue Number', style: blackTextStyle),
            ),
          ),
        ),

        const SizedBox(width: 15),

        Expanded(
          flex: 9,
          child: PopupMenuButton<String>(
            offset: const Offset(0, 25),
            padding: EdgeInsets.zero,

            onSelected: (value) {
              searchController.getDataByFilter(
                value,
                'Makes',
                categoryProducts: categoryProducts,
              );
            },

            itemBuilder: (context) {
              return List.generate(
                searchController.productModelForListFilterMakes.length,
                (index) {
                  final data =
                      searchController.productModelForListFilterMakes[index];

                  return PopupMenuItem<String>(
                    value: data.makes,
                    child: Text(data.makes ?? '-'),
                  );
                },
              );
            },

            child: Container(
              height: 22,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(2),
              ),
              child: Text('Makes', style: blackTextStyle),
            ),
          ),
        ),

        const SizedBox(width: 15),

        Expanded(
          flex: 9,
          child: PopupMenuButton<String>(
            offset: const Offset(0, 25),
            padding: EdgeInsets.zero,

            onSelected: (value) {
              searchController.getDataByFilter(
                value,
                'Equipment Type',
                categoryProducts: categoryProducts,
              );
            },

            itemBuilder: (context) {
              return List.generate(
                searchController
                    .productModelForListFilterCatalogEquipmenType
                    .length,
                (index) {
                  final data = searchController
                      .productModelForListFilterCatalogEquipmenType[index];

                  return PopupMenuItem<String>(
                    value: data.equipmentType,
                    child: Text(data.equipmentType ?? '-'),
                  );
                },
              );
            },

            child: Container(
              height: 22,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(2),
              ),
              child: Text('Equipment Type', style: blackTextStyle),
            ),
          ),
        ),

        const SizedBox(width: 15),

        Expanded(
          flex: 9,
          child: PopupMenuButton<String>(
            offset: const Offset(0, 25),
            padding: EdgeInsets.zero,

            onSelected: (value) {
              searchController.getDataByFilter(
                value,
                'Models',
                categoryProducts: categoryProducts,
              );
            },

            itemBuilder: (context) {
              return List.generate(
                searchController.productModelForListFilterCatalogModels.length,
                (index) {
                  final data = searchController
                      .productModelForListFilterCatalogModels[index];

                  return PopupMenuItem<String>(
                    value: data.models,
                    child: Text(data.models ?? '-'),
                  );
                },
              );
            },

            child: Container(
              height: 22,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(2),
              ),
              child: Text('Models', style: blackTextStyle),
            ),
          ),
        ),

        const SizedBox(width: 15),
        Expanded(
          flex: 9,
          child: PopupMenuButton<String>(
            offset: const Offset(0, 25),
            padding: EdgeInsets.zero,

            onSelected: (value) {
              searchController.getDataByFilter(
                value,
                'OEM Part Number',
                categoryProducts: categoryProducts,
              );
            },

            itemBuilder: (context) {
              return List.generate(
                searchController
                    .productModelForListFilterCatalogOemPartNumber
                    .length,
                (index) {
                  final data = searchController
                      .productModelForListFilterCatalogOemPartNumber[index];

                  return PopupMenuItem<String>(
                    value: data.oemPartNumber,
                    child: Text(data.oemPartNumber ?? '-'),
                  );
                },
              );
            },

            child: Container(
              height: 22,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(2),
              ),
              child: Text('OEM Part Number', style: blackTextStyle),
            ),
          ),
        ),
        const SizedBox(width: 15),
        Expanded(
          flex: 9,
          child: PopupMenuButton<String>(
            offset: const Offset(0, 25),
            padding: EdgeInsets.zero,

            onSelected: (value) {
              searchController.getDataByFilter(
                value,
                'Industry',
                categoryProducts: categoryProducts,
              );
            },

            itemBuilder: (context) {
              return List.generate(
                searchController
                    .productModelForListFilterCatalogIndystry
                    .length,
                (index) {
                  final data = searchController
                      .productModelForListFilterCatalogIndystry[index];

                  return PopupMenuItem<String>(
                    value: data.industry,
                    child: Text(data.industry ?? '-'),
                  );
                },
              );
            },

            child: Container(
              height: 22,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(2),
              ),
              child: Text('Industry', style: blackTextStyle),
            ),
          ),
        ),

        const SizedBox(width: 15),

        Expanded(
          flex: 9,
          child: PopupMenuButton<String>(
            offset: const Offset(0, 25),
            padding: EdgeInsets.zero,

            onSelected: (value) {
              searchController.getDataByFilter(
                value,
                'Product Type',
                categoryProducts: categoryProducts,
              );
            },

            itemBuilder: (context) {
              return List.generate(
                searchController
                    .productModelForListFilterCatalogProductType
                    .length,
                (index) {
                  final data = searchController
                      .productModelForListFilterCatalogProductType[index];

                  return PopupMenuItem<String>(
                    value: data.productType,
                    child: Text(data.productType ?? '-'),
                  );
                },
              );
            },

            child: Container(
              height: 22,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(2),
              ),
              child: Text('Product Type', style: blackTextStyle),
            ),
          ),
        ),
        const SizedBox(width: 15),
        Expanded(
          flex: 9,
          child: PopupMenuButton<String>(
            offset: const Offset(0, 25),
            padding: EdgeInsets.zero,

            onSelected: (value) {
              searchController.getDataByFilter(
                value,
                'Description',
                categoryProducts: categoryProducts,
              );
            },

            itemBuilder: (context) {
              return List.generate(
                searchController
                    .productModelForListFilterCatalogDescription
                    .length,
                (index) {
                  final data = searchController
                      .productModelForListFilterCatalogDescription[index];

                  return PopupMenuItem<String>(
                    value: data.descriptionApplication,
                    child: Text(data.descriptionApplication ?? '-'),
                  );
                },
              );
            },

            child: Container(
              height: 22,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(2),
              ),
              child: Text('Description', style: blackTextStyle),
            ),
          ),
        ),
      ],
    );
  }
}
