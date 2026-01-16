import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:project/controller/searchProductController.dart';
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
      return Expanded(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 40),
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
              isExpanded: true,
              icon: const Icon(
                Icons.keyboard_arrow_down,
                color: Colors.red,
                size: 20,
              ),
              // Map otomatis dari list model ke DropdownMenuItem
              items: items.map((item) {
                return DropdownMenuItem<String>(
                  value: item?.id.toString(),
                  child: Text(
                    labelBuilder(item), // Mengambil nama field secara dinamis
                    style: const TextStyle(fontSize: 14),
                  ),
                );
              }).toList(),
              onChanged: onChanged,
            ),
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
        return Scaffold(
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Bengkelku Spare Part',
                    style: blackTextStyle.copyWith(
                      fontWeight: bold,
                      fontSize: 32,
                    ),
                  ),
                  SizedBox(height: 20),

                  Text(
                    "Suku cadang yang dapat dikonsumsi berkisar dari filter oli hingga filter udara, bantalan rem, dan oli / bahan kimia. Bengkelku merekomendasikan suku cadang asli.\nMereka dirancang untuk Bengkelku dan sepenuhnya diuji untuk memaksimalkan kinerja dan masa pakai. ",
                    textAlign: TextAlign.center,
                    style: blackTextStyle.copyWith(fontWeight: semiBold),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                    padding: EdgeInsets.all(10),
                    child: TextFormField(
                      onChanged: (value) {
                        Get.find<Searchproductcontroller>().setTypedPlatNumber(
                          value,
                        );
                      },
                      decoration: InputDecoration(
                        suffixIcon: Icon(Icons.search),
                        border: InputBorder.none,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blueGrey),
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        hint: Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Cari berdasarkan plat number',
                                style: blackTextStyle.copyWith(fontSize: 10.sp),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 5.h),

                  ElevatedButton.icon(
                    onPressed: () async {
                      await controller.getDatabyPlatNumber(
                        controller.typedPlatNumber,
                      );
                    },
                    icon: const Icon(Icons.search),
                    label: const Text("Cari Berdasarkan Plat Number"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    "OR",
                    style: blackTextStyle.copyWith(
                      fontSize: 20.sp,
                      // Ukuran font responsif
                      fontWeight: bold,
                    ),
                  ),
                  SizedBox(height: 5.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      dropDowns(
                        hint: "Pilih Make",
                        value: controller.selectedMake,
                        items: controller.makeModel,
                        labelBuilder: (item) => item?.makeName ?? '',
                        onChanged: (val) =>
                            controller.setSelectedMake(val ?? ''),
                      ),

                      const SizedBox(height: 10),

                      // 2. Dropdown Application
                      dropDowns(
                        hint: "Pilih Application",
                        value: controller.selectedApplication,
                        items: controller.applicationModel,
                        labelBuilder: (item) => item?.applicationName ?? '',
                        onChanged: (val) =>
                            controller.setSelectedApplication(val ?? ''),
                      ),

                      const SizedBox(height: 10),

                      // 3. Dropdown Material
                      dropDowns(
                        hint: "Pilih Model",
                        value: controller.selectedModel,
                        items: controller.modelModel,
                        labelBuilder: (item) => item?.modelName ?? '',
                        onChanged: (val) =>
                            controller.setSelectedModel(val ?? ''),
                      ),
                    ],
                  ),
                  SizedBox(height: 5.h),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        dropDowns(
                          hint: "Pilih Material",
                          value: controller.selectedMaterial,
                          items: controller.materialModel,
                          labelBuilder: (item) => item?.materialName ?? '',
                          onChanged: (val) =>
                              controller.setSelectedMaterial(val ?? ''),
                        ),

                        const SizedBox(height: 10),

                        // 2. Dropdown Application
                        const SizedBox(height: 10),

                        // 3. Dropdown Material
                        dropDowns(
                          hint: "Pilih Core Type",
                          value: controller.selectedCoreType,
                          items: controller.coreTypeModel,
                          labelBuilder: (item) => item?.coreType ?? '',
                          onChanged: (val) =>
                              controller.setSelectedCoreType(val ?? ''),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 5.h),

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
                        label: const Text("Reset"), // Teks otomatis di kanan
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 5.h),
                  buildTable(controller.allDataModel),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
