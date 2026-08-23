import 'package:flutter/material.dart';
import 'package:project/controller/searchProductController.dart';
import 'package:project/theme/theme.dart';

class ListOfButtonRadiatorAndCap extends StatelessWidget {
  final Searchproductcontroller searchController;

  const ListOfButtonRadiatorAndCap({super.key, required this.searchController});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // =========================
        // PART NUMBER
        // =========================
        Expanded(
          flex: 9,
          child: PopupMenuButton<String>(
            offset: const Offset(0, 25),
            padding: EdgeInsets.zero,
            onSelected: (value) {
              searchController.getDataByFilter(value, 'Part Number');
            },
            itemBuilder: (context) {
              return List.generate(
                searchController.productModelForListFilterPartNumber.length,
                (index) {
                  final data = searchController
                      .productModelForListFilterPartNumber[index];

                  return PopupMenuItem<String>(
                    value: data.partNumber,
                    child: Text(data.partNumber ?? '-'),
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
              child: Text('Part Number', style: blackTextStyle),
            ),
          ),
        ),

        const SizedBox(width: 15),

        // =========================
        // MAKES
        // =========================
        Expanded(
          flex: 7,
          child: PopupMenuButton<String>(
            offset: const Offset(0, 25),
            padding: EdgeInsets.zero,
            onSelected: (value) {
              searchController.getDataByFilter(value, 'Makes');
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

        // =========================
        // APPLICATION
        // =========================
        Expanded(
          flex: 9,
          child: PopupMenuButton<String>(
            offset: const Offset(0, 25),
            padding: EdgeInsets.zero,
            onSelected: (value) {
              searchController.getDataByFilter(value, 'Application');
            },
            itemBuilder: (context) {
              return List.generate(
                searchController.productModelForListFilterApplication.length,
                (index) {
                  final data = searchController
                      .productModelForListFilterApplication[index];

                  return PopupMenuItem<String>(
                    value: data.application,
                    child: Text(data.application ?? '-'),
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
              child: Text('Application', style: blackTextStyle),
            ),
          ),
        ),

        const SizedBox(width: 15),

        // =========================
        // SIZE
        // =========================
        Expanded(
          flex: 7,
          child: PopupMenuButton<String>(
            offset: const Offset(0, 25),
            padding: EdgeInsets.zero,
            onSelected: (value) {
              searchController.getDataByFilter(value, 'Size');
            },
            itemBuilder: (context) {
              return List.generate(
                searchController.productModelForListFilterSize.length,
                (index) {
                  final data =
                      searchController.productModelForListFilterSize[index];

                  return PopupMenuItem<String>(
                    value: data.size,
                    child: Text(data.size ?? '-'),
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
              child: Text('Size', style: blackTextStyle),
            ),
          ),
        ),

        const SizedBox(width: 15),

        // =========================
        // PRESSURE
        // =========================
        Expanded(
          flex: 7,
          child: PopupMenuButton<String>(
            offset: const Offset(0, 25),
            padding: EdgeInsets.zero,
            onSelected: (value) {
              searchController.getDataByFilter(value, 'Presure Ratting');
            },
            itemBuilder: (context) {
              return List.generate(
                searchController.productModelForListFilterPartPressure.length,
                (index) {
                  final data = searchController
                      .productModelForListFilterPartPressure[index];

                  return PopupMenuItem<String>(
                    value: data.pressureRating,
                    child: Text(data.pressureRating ?? '-'),
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
              child: Text('Pressure', style: blackTextStyle),
            ),
          ),
        ),

        const SizedBox(width: 15),

        // =========================
        // MATERIAL
        // =========================
        Expanded(
          flex: 9,
          child: PopupMenuButton<String>(
            offset: const Offset(0, 25),
            padding: EdgeInsets.zero,
            onSelected: (value) {
              searchController.getDataByFilter(value, 'Material');
            },
            itemBuilder: (context) {
              return List.generate(
                searchController.productModelForListFilterPartMaterial.length,
                (index) {
                  final data = searchController
                      .productModelForListFilterPartMaterial[index];

                  return PopupMenuItem<String>(
                    value: data.materialType,
                    child: Text(data.materialType ?? '-'),
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
              child: Text('Material', style: blackTextStyle),
            ),
          ),
        ),

        const SizedBox(width: 15),

        // =========================
        // DESCRIPTION
        // =========================
        Expanded(
          flex: 20,
          child: PopupMenuButton<String>(
            offset: const Offset(0, 25),
            padding: EdgeInsets.zero,
            onSelected: (value) {
              searchController.getDataByFilter(value, 'Description');
            },
            itemBuilder: (context) {
              return List.generate(
                searchController
                    .productModelForListFilterPartDescriptionApplication
                    .length,
                (index) {
                  final data = searchController
                      .productModelForListFilterPartDescriptionApplication[index];

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
              child: Text('Description / Application', style: blackTextStyle),
            ),
          ),
        ),
      ],
    );
  }
}
