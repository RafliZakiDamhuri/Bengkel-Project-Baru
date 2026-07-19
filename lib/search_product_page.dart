import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/controller/globalController.dart';

import 'package:project/controller/searchProductController.dart';
import 'package:project/global%20widget/footer.dart';
import 'package:project/global%20widget/globalAppBar.dart';
import 'package:project/global%20widget/personalData.dart';
import 'package:project/model/allDataModel.dart';
import 'package:project/model/dropDownModel.dart';
import 'package:project/model/productModel.dart';
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

    print('Ini adalah argument ;;; ${argument.flow}');
  }

  @override
  Widget build(BuildContext context) {
    var globalController = Get.find<GlobalController>();
    var searchController = Get.find<Searchproductcontroller>();

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
                Icon(Icons.arrow_drop_down_outlined, color: Colors.white),
              ],
            ),
          ),
        ),
      );
    }

    Widget buttonSort(Searchproductcontroller controller) {
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
              }
              controller.scrollToTable();
            },
            label: Text("Sort", style: whiteTextStyle),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
          ),

          const SizedBox(width: 12),

          ElevatedButton.icon(
            onPressed: () async {
              await controller.reset(flow: argument.flow ?? '');
            },
            icon: const Icon(Icons.refresh),
            label: Text("Reset", style: whiteTextStyle),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
          ),
        ],
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
            child: DataTable(
              headingRowColor: WidgetStateProperty.all(darkGrey),
              dividerThickness: 2,
              columnSpacing: 90,
              columns: [
                tableHeader(
                  title: 'Catalogue Number',
                  onTap: searchController.getAllProductsV2CatalogueNumber,
                ),
                tableHeader(
                  title: 'Makes',
                  onTap: () {
                    searchController.getAllProductsV2(
                      categoryProducts: argument.flow ?? '',
                    );
                  },
                ),
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
                tableHeader(
                  title: 'Description / Application',
                  onTap: searchController.getAllProductsDescriptionApplication,
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
                    tableCell(item.descriptionApplication),
                  ],
                );
              }).toList(),
            ),
          ),
        ),
      );
    }

    Widget buildTableRadiatorAndCap(List<ProductModel> data) {
      return Card(
        elevation: 2,
        margin: const EdgeInsets.all(8),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical, // Scroll atas-bawah
          child: SingleChildScrollView(
            scrollDirection:
                Axis.horizontal, // Scroll kiri-kanan untuk kolom banyak
            child: DataTable(
              headingRowColor: WidgetStateProperty.all(darkGrey),
              dividerThickness: 2,
              columnSpacing: 90,
              columns: [
                tableHeader(
                  title: 'Part Number',
                  onTap: searchController.getAllProductsV2CatalogueNumber,
                ),
                tableHeader(
                  title: 'Makes',
                  onTap: () {
                    searchController.getAllProductsV2(
                      categoryProducts: argument.flow ?? '',
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
            ),
          ),
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

    Widget searchPerdataTile({String? title}) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title ?? '-', style: blackTextStyle),
          SizedBox(height: 5),
          Container(
            height: 2,
            width: 300,
            decoration: BoxDecoration(
              color: kBlackColor,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ],
      );
    }

    Widget searchPerData({
      String? browseTitle,
      required List<DropdownModel?> data,
      String? type,
    }) {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 80, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),

            Text(
              browseTitle ?? '-',
              style: blackTextStyle.copyWith(fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 20),

            Container(
              padding: EdgeInsets.only(top: 40, left: 20, bottom: 20),
              width: MediaQuery.sizeOf(context).width - 120,

              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: kWhiteColor,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    runSpacing: 40,
                    spacing: 20,
                    children: data
                        .map(
                          (e) => GestureDetector(
                            onTap: () async {
                              await searchController.getDatabyType(
                                e?.name,
                                browseTitle,
                              );
                              searchController.scrollToTable();
                            },
                            child: searchPerdataTile(title: e?.name),
                          ),
                        )
                        .toList(),
                  ),
                  SizedBox(height: 20),

                  GestureDetector(
                    onTap: () {
                      searchController.getAllProductsV2(
                        categoryProducts: argument.flow ?? '',
                      );
                      searchController.scrollToTable();
                    },
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        margin: EdgeInsets.only(right: 20),
                        child: Text(
                          'Shows All',
                          style: blackTextStyle.copyWith(
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    Widget radiatorAndCoolersWidget(Searchproductcontroller controller) {
      return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(top: 80, left: 60, right: 60),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: darkGrey,
              ),
              padding: EdgeInsets.all(24),
              child: Column(
                children: [
                  Text(
                    '${argument.flow} SEARCH PART',
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
                                  Get.find<Searchproductcontroller>()
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
                                    controller.typedPlatNumber,
                                  );
                                  controller.scrollToTable();
                                },
                                icon: const Icon(Icons.search),
                                label: Text(
                                  "SEARCH P/N",
                                  style: whiteTextStyle,
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
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
                              hint: "Select a maker",
                              value: controller.selectedMake,
                              items: controller.makeModel,
                              labelBuilder: (item) => item?.name ?? '',
                              onChanged: (val) =>
                                  controller.setSelectedMake(val ?? ''),
                            ),
                            dropDowns(
                              hint: "Select a produt type",
                              value: controller.selectedProduct,
                              items: controller.productList,
                              labelBuilder: (item) => item?.name ?? '',
                              onChanged: (val) =>
                                  controller.setSelectedProduct(val ?? ''),
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
                              items: controller.modelsModel,
                              labelBuilder: (item) => item?.name ?? '',
                              onChanged: (val) =>
                                  controller.setSelectedModel(val ?? ''),
                            ),
                            dropDowns(
                              hint: "Select an industry",
                              value: controller.selectedIndustry,
                              items: controller.industryModel,
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

            searchPerData(
              browseTitle: 'BROWSE PER EQUIPMENT TYPE',
              data: controller.equipmentTypeList,
            ),
            searchPerData(
              browseTitle: 'BROWSE PER MAKES',
              data: controller.makeModel,
            ),
            searchPerData(
              browseTitle: 'BROWSE PER PRODUCT TYPE',
              data: controller.productList,
            ),

            Container(
              key: controller.tableKey,
              child: buildTableRadiatorAndCoolers(controller.productModel),
            ),

            SizedBox(height: 15.h),
          ],
        ),
      );
    }

    Widget radiatorsCapAndAdapter(Searchproductcontroller controller) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 80, left: 60, right: 60),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: darkGrey,
            ),
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Text(
                  '${argument.flow} SEARCH PART',
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
                                  controller.typedPlatNumber,
                                );

                                controller.scrollToTable();
                              },
                              icon: const Icon(Icons.search),
                              label: Text("SEARCH P/N", style: whiteTextStyle),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
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

                    // =========================
                    // RIGHT - FILTER
                    // =========================
                    Expanded(
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // SIZE
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

          // =========================
          // TABLE
          // =========================
          buildTableRadiatorAndCap(controller.productModel),

          SizedBox(height: 15.h),
        ],
      );
    }

    return GetBuilder<Searchproductcontroller>(
      initState: (state) async {
        await Get.find<Searchproductcontroller>().getAllMake();
        await Get.find<Searchproductcontroller>().getAllProducts();
        await Get.find<Searchproductcontroller>().getAllModel();
        await Get.find<Searchproductcontroller>().getAllIndustry();
        await Get.find<Searchproductcontroller>().getAllEquipmentType();
        await Get.find<Searchproductcontroller>().getAllSize();
        await Get.find<Searchproductcontroller>().getAllPressureRating();
      },

      builder: (controller) {
        return Globalappbar(
          backgroundColor: backgroundgrey,
          pageWidget: SingleChildScrollView(
            child: (argument.flow == 'Radiators and Coolers')
                ? radiatorAndCoolersWidget(controller)
                : radiatorsCapAndAdapter(controller),
          ),
        );
      },
    );
  }
}
