import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:project/controller/searchProductController.dart';
import 'package:project/global%20widget/footer.dart';
import 'package:project/global%20widget/globalAppBar.dart';
import 'package:project/global%20widget/personalData.dart';
import 'package:project/model/allDataModel.dart';
import 'package:project/model/makeModel.dart';
import 'package:project/theme/theme.dart';
import 'package:sizer/sizer.dart';

class SearchProductPage extends StatelessWidget {
  const SearchProductPage({super.key});

  // Data List untuk Dropdown
  final List<String> listJenisItem = const ["Spare Parts", "Aksesoris", "Oli"];
  final List<String> listJenisKendaraan = const ["Motor", "Mobil"];
  final List<String> listModel = const ["Satria FU", "NEX II", "GSX-R150"];

  // State Manager menggunakan ValueNotifier agar bisa berubah di StatelessWidget
  static final ValueNotifier<String?> selectedJenisItem = ValueNotifier(
    "Spare Parts",
  );
  static final ValueNotifier<String?> selectedJenisKendaraan = ValueNotifier(
    "Motor",
  );
  static final ValueNotifier<String?> selectedModel = ValueNotifier(null);

  @override
  Widget build(BuildContext context) {
    Get.put(Searchproductcontroller());
    Widget buildTable(List<AllDataModel> data) {
      return Card(
        elevation: 2,
        margin: const EdgeInsets.all(8),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical, // Scroll atas-bawah
          child: SingleChildScrollView(
            scrollDirection:
                Axis.horizontal, // Scroll kiri-kanan untuk kolom banyak
            child: DataTable(
              headingRowColor: WidgetStateProperty.all(Colors.grey.shade100),
              columnSpacing: 20,
              columns: const [
                DataColumn(
                  label: Text(
                    'ISC P/N',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'OEM P/N',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Make',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Application',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Material',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Model',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Application',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),

                DataColumn(
                  label: Text(
                    'Core Type',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Equip Type',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Compatible',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
              rows: data.map((item) {
                return DataRow(
                  cells: [
                    DataCell(Text(item.productCode ?? '-')),
                    DataCell(Text(item.platNumber?.platNumber ?? '-')),
                    DataCell(Text(item.make?.makeName ?? '-')),
                    DataCell(
                      Text(item.applicationRel?.applicationName ?? '-'),
                    ), // Dari relasi
                    DataCell(
                      Text(item.material?.materialName ?? '-'),
                    ), // Dari relasi
                    DataCell(Text(item.modelData?.modelName ?? '-')),
                    DataCell(Text(item.applicationRel?.applicationName ?? '-')),

                    DataCell(Text(item.coreTypeModel?.coreType ?? '-')),
                    DataCell(
                      Text(item.equipmentTypeModel?.equipmentType ?? '-'),
                    ),
                    DataCell(Text(item.compatible ?? '-')),
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
                value: item?.id.toString(),
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

    return GetBuilder<Searchproductcontroller>(
      initState: (state) async {
        await Get.find<Searchproductcontroller>().getAllMake();
        await Get.find<Searchproductcontroller>().getAllApplication();
        await Get.find<Searchproductcontroller>().getAllMaterial();
        await Get.find<Searchproductcontroller>().getAllModel();
        await Get.find<Searchproductcontroller>().getAllCoreType();
      },

      builder: (controller) {
        return Globalappbar(
          pageWidget: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  color: darkGrey,
                  padding: EdgeInsets.all(24),
                  child: Column(
                    children: [
                      Text(
                        'Search Part',
                        style: whiteTextStyle.copyWith(fontSize: 48),
                      ),
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
                                        borderSide: BorderSide(
                                          color: Colors.blue,
                                        ),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(8),
                                        ),
                                      ),
                                      hint: Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              'Cari berdasarkan plat number',
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
                                      await controller.getDatabyPlatNumber(
                                        controller.typedPlatNumber,
                                      );
                                    },
                                    icon: const Icon(Icons.search),
                                    label: const Text("SEARCH P/N"),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blue,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                dropDowns(
                                  hint: "Select a Maker",
                                  value: controller.selectedMake,
                                  items: controller.makeModel,
                                  labelBuilder: (item) => item?.makeName ?? '',
                                  onChanged: (val) =>
                                      controller.setSelectedMake(val ?? ''),
                                ),
                                dropDowns(
                                  hint: "Select core type",
                                  value: controller.selectedCoreType,
                                  items: controller.coreTypeModel,
                                  labelBuilder: (item) => item?.coreType ?? '',
                                  onChanged: (val) =>
                                      controller.setSelectedCoreType(val ?? ''),
                                ),
                              ],
                            ),
                          ),

                          //     // 3. Dropdown Material
                          //     dropDowns(
                          //       hint: "Pilih Model",
                          //       value: controller.selectedModel,
                          //       items: controller.modelModel,
                          //       labelBuilder: (item) => item?.modelName ?? '',
                          //       onChanged: (val) =>
                          //           controller.setSelectedModel(val ?? ''),
                          //     ),
                          //   ],
                          // ),
                          // SizedBox(height: 5.h),
                          // Center(
                          //   child: Row(
                          //     mainAxisAlignment: MainAxisAlignment.center,
                          //     children: [
                          //       dropDowns(
                          //         hint: "Pilih Material",
                          //         value: controller.selectedMaterial,
                          //         items: controller.materialModel,
                          //         labelBuilder: (item) => item?.materialName ?? '',
                          //         onChanged: (val) =>
                          //             controller.setSelectedMaterial(val ?? ''),
                          //       ),
                          Expanded(
                            child: Column(
                              children: [
                                dropDowns(
                                  hint: "Select a Model",
                                  value: controller.selectedModel,
                                  items: controller.modelModel,
                                  labelBuilder: (item) => item?.modelName ?? '',
                                  onChanged: (val) =>
                                      controller.setSelectedModel(val ?? ''),
                                ),
                                dropDowns(
                                  hint: "Select Material",
                                  value: controller.selectedMaterial,
                                  items: controller.materialModel,
                                  labelBuilder: (item) =>
                                      item?.materialName ?? '',
                                  onChanged: (val) =>
                                      controller.setSelectedMaterial(val ?? ''),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                dropDowns(
                                  hint: "Pilih Application",
                                  value: controller.selectedApplication,
                                  items: controller.applicationModel,
                                  labelBuilder: (item) =>
                                      item?.applicationName ?? '',
                                  onChanged: (val) => controller
                                      .setSelectedApplication(val ?? ''),
                                ),
                                SizedBox(height: 16),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ElevatedButton.icon(
                                      onPressed: () async {
                                        await controller.getData();
                                      },
                                      icon: const Icon(Icons.search),
                                      label: const Text("Cari"),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.blue,
                                      ),
                                    ),

                                    const SizedBox(width: 12),

                                    ElevatedButton.icon(
                                      onPressed: () {
                                        controller.selectedApplication = null;
                                        controller.selectedMake = null;
                                        controller.selectedMaterial = null;
                                      },
                                      icon: const Icon(
                                        Icons.refresh,
                                      ), // Ikon otomatis di kiri
                                      label: const Text(
                                        "Reset",
                                      ), // Teks otomatis di kanan
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.grey,
                                      ),
                                    ),
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

                SizedBox(height: 5.h),
                buildTable(controller.allDataModel),
                SizedBox(height: 15.h),
              ],
            ),
          ),
        );
      },
    );
  }
}
