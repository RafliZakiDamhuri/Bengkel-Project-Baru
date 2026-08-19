import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:project/controller/searchProductController.dart';
import 'package:project/global%20widget/radiatorAndCoolers/buildTableRadiatorAndCoolers.dart';
import 'package:project/model/dropDownModel.dart';
import 'package:project/theme/string.dart';
import 'package:project/theme/theme.dart';
import 'package:sizer/sizer.dart';

class Radiatorandcoolerswidget extends StatelessWidget {
  final Searchproductcontroller controller;
  const Radiatorandcoolerswidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    Widget buttonShowAll(Searchproductcontroller controller) {
      return ElevatedButton.icon(
        onPressed: () async {
          controller.getProductsByCategory(
            category: AppString().radiatorAndCoolers,
          );
          controller.scrollToTable();
        },
        label: Text("Show All", style: whiteTextStyle),
        style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
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
                              await controller.getDatabyType(
                                e?.name,
                                browseTitle,
                              );
                              controller.scrollToTable();
                            },
                            child: searchPerdataTile(title: e?.name),
                          ),
                        )
                        .toList(),
                  ),
                  SizedBox(height: 20),

                  GestureDetector(
                    onTap: () {
                      controller.getAllProductsMakes(
                        categoryProducts: AppString().radiatorAndCoolers,
                      );
                      controller.scrollToTable();
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

    Widget buttonSort(Searchproductcontroller controller) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ElevatedButton.icon(
            onPressed: () async {
              if (AppString().radiatorAndCoolers == 'Radiators and Coolers') {
                await controller.getDataNewRadiatorAndCoolers(
                  categoryProducts: AppString().radiatorAndCoolers,
                );
              } else if (AppString().radiatorAndCoolers ==
                  'Radiator Cap and Adapter') {
                await controller.getDataNewRadiatorCapAndAdapter(
                  categoryProducts: AppString().radiatorAndCoolers,
                );
              } else if (AppString().radiatorAndCoolers ==
                  AppString().caterpilarTube) {
                await controller.getDataNewCatapillarTubeAndShellOilCooler(
                  categoryProducts: AppString().radiatorAndCoolers,
                );
              }
              controller.scrollToTable();
            },
            label: Text("Sort", style: whiteTextStyle),
            style: ElevatedButton.styleFrom(backgroundColor: Color(0xffF15E00)),
          ),

          const SizedBox(width: 12),

          ElevatedButton.icon(
            onPressed: () async {
              await controller.reset(flow: AppString().radiatorAndCoolers);
            },
            icon: const Icon(Icons.refresh, color: Colors.grey),
            label: Text("Reset", style: greyTextStyle),
            style: ElevatedButton.styleFrom(backgroundColor: kBlackColor),
          ),
        ],
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

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(top: 80, left: 60, right: 60),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: kBlackColor,
            ),
            padding: EdgeInsets.all(24),
            child: Column(
              children: [
                Text(
                  '${AppString().radiatorAndCoolers} SEARCH PART',
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
                                  value: controller.typedPlatNumber,
                                  catalogueType: AppString().radiatorAndCoolers,
                                );
                                controller.scrollToTable();
                              },
                              // icon: const Icon(Icons.search),
                              label: Text("SEARCH P/N", style: whiteTextStyle),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xffF15E00),
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
                            items: controller.makeList,
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
                            items: controller.modelList,
                            labelBuilder: (item) => item?.name ?? '',
                            onChanged: (val) =>
                                controller.setSelectedModel(val ?? ''),
                          ),
                          dropDowns(
                            hint: "Select an industry",
                            value: controller.selectedIndustry,
                            items: controller.industryList,
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
                            onChanged: (val) =>
                                controller.setSelectedEquipmentType(val ?? ''),
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
          SizedBox(height: 20),
          buttonShowAll(controller),
          SizedBox(height: 20),
          searchPerData(
            browseTitle: 'BROWSE PER EQUIPMENT TYPE',
            data: controller.equipmentTypeList,
          ),
          searchPerData(
            browseTitle: 'BROWSE PER MAKES',
            data: controller.makeList,
          ),
          searchPerData(
            browseTitle: 'BROWSE PER PRODUCT TYPE',
            data: controller.productList,
          ),

          Container(
            key: controller.tableKey,
            child: BuildTableRadiatorAndCoolers(data: controller.productModel),
          ),

          SizedBox(height: 15.h),
        ],
      ),
    );
  }
}
