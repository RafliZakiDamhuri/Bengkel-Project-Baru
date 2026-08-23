import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart' show Get;
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:project/controller/searchProductController.dart';
import 'package:project/theme/theme.dart';

class Listofbuttonradiatorandcatapillar extends StatelessWidget {
  final Searchproductcontroller searchController;
  const Listofbuttonradiatorandcatapillar({
    super.key,
    required this.searchController,
  });

  @override
  Widget build(BuildContext context) {
    var searchController = Get.find<Searchproductcontroller>();

    return Row(
      children: [
        Expanded(
          flex: 9,
          child: PopupMenuButton(
            offset: const Offset(0, 25),
            padding: EdgeInsets.zero,
            onSelected: (value) {
              searchController.getDataByFilter(value, 'Catalogue Number');
            },
            itemBuilder: (context) {
              return List.generate(
                searchController.productModelForListFilterCatalogNumber.length,
                (index) {
                  var data = searchController
                      .productModelForListFilterCatalogNumber[index];
                  return PopupMenuItem(
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
          flex: 7,
          child: PopupMenuButton(
            offset: const Offset(0, 25),
            padding: EdgeInsets.zero,
            onSelected: (value) {
              searchController.getDataByFilter(value, 'Makes');
            },
            itemBuilder: (context) {
              return List.generate(
                searchController.productModelForListFilterMakes.length,
                (index) {
                  var data =
                      searchController.productModelForListFilterMakes[index];
                  return PopupMenuItem(
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
          flex: 7,
          child: PopupMenuButton(
            offset: const Offset(0, 25),
            padding: EdgeInsets.zero,
            onSelected: (value) {
              searchController.getDataByFilter(value, 'Equipment Type');
            },
            itemBuilder: (context) {
              return List.generate(
                searchController
                    .productModelForListFilterCatalogEquipmenType
                    .length,
                (index) {
                  var data = searchController
                      .productModelForListFilterCatalogEquipmenType[index];
                  return PopupMenuItem(
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
          flex: 7,
          child: PopupMenuButton(
            offset: const Offset(0, 25),
            padding: EdgeInsets.zero,
            onSelected: (value) {
              searchController.getDataByFilter(value, 'Models');
            },
            itemBuilder: (context) {
              return List.generate(
                searchController.productModelForListFilterCatalogModels.length,
                (index) {
                  var data = searchController
                      .productModelForListFilterCatalogModels[index];
                  return PopupMenuItem(
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
          child: PopupMenuButton(
            offset: const Offset(0, 25),
            padding: EdgeInsets.zero,
            onSelected: (value) {
              searchController.getDataByFilter(value, 'OEM Part Number');
            },
            itemBuilder: (context) {
              return List.generate(
                searchController
                    .productModelForListFilterCatalogOemPartNumber
                    .length,
                (index) {
                  var data = searchController
                      .productModelForListFilterCatalogOemPartNumber[index];
                  return PopupMenuItem(
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
          flex: 7,
          child: PopupMenuButton(
            offset: const Offset(0, 25),
            padding: EdgeInsets.zero,
            onSelected: (value) {
              searchController.getDataByFilter(value, 'Industry');
            },
            itemBuilder: (context) {
              return List.generate(
                searchController
                    .productModelForListFilterCatalogIndystry
                    .length,
                (index) {
                  var data = searchController
                      .productModelForListFilterCatalogIndystry[index];
                  return PopupMenuItem(
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
          child: PopupMenuButton(
            offset: const Offset(0, 25),
            padding: EdgeInsets.zero,
            onSelected: (value) {
              searchController.getDataByFilter(value, 'Product Type');
            },
            itemBuilder: (context) {
              return List.generate(
                searchController
                    .productModelForListFilterCatalogProductType
                    .length,
                (index) {
                  var data = searchController.productModelForListFilter[index];
                  return PopupMenuItem(
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
          flex: 20,
          child: PopupMenuButton(
            offset: const Offset(0, 25),
            padding: EdgeInsets.zero,
            onSelected: (value) {
              searchController.getDataByFilter(value, 'Product Type Design');
            },
            itemBuilder: (context) {
              return List.generate(
                searchController
                    .productModelForListFilterCatalogProductTypeDesign
                    .length,
                (index) {
                  var data = searchController
                      .productModelForListFilterCatalogProductTypeDesign[index];
                  return PopupMenuItem(
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
              child: Text('Product Type Design', style: blackTextStyle),
            ),
          ),
        ),
      ],
    );
  }
}
