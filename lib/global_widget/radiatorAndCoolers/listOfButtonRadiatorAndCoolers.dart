import 'package:flutter/material.dart';
import 'package:project/controller/searchProductController.dart';
import 'package:project/theme/theme.dart';

class ListOfButtonRadiatorAndCoolers extends StatelessWidget {
  final SearchProductController searchController;
  final String categoryProducts;

  const ListOfButtonRadiatorAndCoolers({
    super.key,
    required this.searchController,
    required this.categoryProducts,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildFilterButton(
          flex: 2,
          title: 'Catalogue Number',
          items: searchController.productModelForListFilterCatalogNumber
              .map((e) => e.catalogueNumber ?? '-')
              .toList(),
          onSelected: (val) => searchController.getDataByFilter(
            val,
            'Catalogue Number',
            categoryProducts: categoryProducts,
          ),
        ),
        const SizedBox(width: 15),

        _buildFilterButton(
          flex: 3,
          title: 'Makes',
          items: searchController.productModelForListFilterMakes
              .map((e) => e.makes ?? '-')
              .toList(),
          onSelected: (val) => searchController.getDataByFilter(
            val,
            'Makes',
            categoryProducts: categoryProducts,
          ),
        ),
        const SizedBox(width: 15),

        _buildFilterButton(
          flex: 3,
          title: 'Equipment Type',
          items: searchController.productModelForListFilterCatalogEquipmenType
              .map((e) => e.equipmentType ?? '-')
              .toList(),
          onSelected: (val) => searchController.getDataByFilter(
            val,
            'Equipment Type',
            categoryProducts: categoryProducts,
          ),
        ),
        const SizedBox(width: 15),

        _buildFilterButton(
          flex: 2,
          title: 'Models',
          items: searchController.productModelForListFilterCatalogModels
              .map((e) => e.models ?? '-')
              .toList(),
          onSelected: (val) => searchController.getDataByFilter(
            val,
            'Models',
            categoryProducts: categoryProducts,
          ),
        ),
        const SizedBox(width: 15),

        _buildFilterButton(
          flex: 2,
          title: 'OEM Part No',
          items: searchController.productModelForListFilterCatalogOemPartNumber
              .map((e) => e.oemPartNumber ?? '-')
              .toList(),
          onSelected: (val) => searchController.getDataByFilter(
            val,
            'OEM Part Number',
            categoryProducts: categoryProducts,
          ),
        ),
        const SizedBox(width: 15),

        _buildFilterButton(
          flex: 2,
          title: 'Industry',
          items: searchController.productModelForListFilterCatalogIndystry
              .map((e) => e.industry ?? '-')
              .toList(),
          onSelected: (val) => searchController.getDataByFilter(
            val,
            'Industry',
            categoryProducts: categoryProducts,
          ),
        ),
        const SizedBox(width: 15),

        _buildFilterButton(
          flex: 3,
          title: 'Product Type',
          items: searchController.productModelForListFilterCatalogProductType
              .map((e) => e.productType ?? '-')
              .toList(),
          onSelected: (val) => searchController.getDataByFilter(
            val,
            'Product Type',
            categoryProducts: categoryProducts,
          ),
        ),
        const SizedBox(width: 15), // JANGAN LUPA INI! Harus sama dengan tabel

        _buildFilterButton(
          flex: 5,
          title: 'Description',
          items: searchController.productModelForListFilterCatalogDescription
              .map((e) => e.descriptionApplication ?? '-')
              .toList(),
          onSelected: (val) => searchController.getDataByFilter(
            val,
            'Description',
            categoryProducts: categoryProducts,
          ),
        ),
      ],
    );
  }

  // Helper widget agar kode lebih rapi dan terbaca
  Widget _buildFilterButton({
    required int flex,
    required String title,
    required List<String> items,
    required Function(String) onSelected,
  }) {
    return Expanded(
      flex: flex,
      child: PopupMenuButton<String>(
        offset: const Offset(0, 25),
        padding: EdgeInsets.zero,
        onSelected: onSelected,
        itemBuilder: (context) {
          return List.generate(
            items.length,
            (index) => PopupMenuItem<String>(
              value: items[index],
              child: Text(items[index]),
            ),
          );
        },
        child: Container(
          height: 22,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(2),
          ),
          child: Text(
            title,
            style: blackTextStyle,
            overflow:
                TextOverflow.ellipsis, // Supaya text tidak error jika kekecilan
          ),
        ),
      ),
    );
  }
}
