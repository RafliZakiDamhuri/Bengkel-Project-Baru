import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:project/Inquiry/controller/inquiry_controller.dart';
import 'package:project/Inquiry/model/inquiry_model.dart';
import 'package:sizer/sizer.dart';

class InquiryUsersData extends StatefulWidget {
  const InquiryUsersData({super.key});

  @override
  State<InquiryUsersData> createState() => _InquiryUsersDataState();
}

class _InquiryUsersDataState extends State<InquiryUsersData> {
  final InquiryController _controller = Get.find<InquiryController>();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  TextEditingController titleController = TextEditingController();
  TextEditingController subTitleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final tableWidth = 80.w - 48; // 24 kiri + 24 kanan
    const totalFlex = 11;

    final catalogueWidth = tableWidth * 1.5 / totalFlex;
    final makesWidth = tableWidth * 1.0 / totalFlex;
    final equipmentWidth = tableWidth * 1.5 / totalFlex;
    final modelsWidth = tableWidth * 1.2 / totalFlex;
    final oemWidth = tableWidth * 1.5 / totalFlex;
    final industryWidth = tableWidth * 1.0 / totalFlex;
    final productTypeWidth = tableWidth * 1.3 / totalFlex;
    DataColumn _tableColumn(String title, double width) {
      return DataColumn(
        label: SizedBox(
          width: width,
          child: Text(
            title,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      );
    }

    DataCell _tableDataCell(String? value, double width) {
      return DataCell(
        InkWell(
          onTap: () {
            _controller.downloadFile(url: value ?? '-');
          },
          child: SizedBox(
            width: width,
            child: Text(
              value ?? '-',
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      );
    }

    Widget buildTableInquiry(List<UserDataModel> data) {
      return Container(
        width: 80.w,
        color: Colors.black,
        padding: const EdgeInsets.fromLTRB(24, 14, 24, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(3),
              child: DataTable(
                headingRowColor: WidgetStateProperty.all(
                  const Color(0xFFFF5A00),
                ),
                dataRowColor: WidgetStateProperty.all(Colors.white),
                dividerThickness: 1,

                // Hilangkan spacing bawaan DataTable
                horizontalMargin: 0,
                columnSpacing: 0,

                headingTextStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),

                dataTextStyle: const TextStyle(
                  color: Colors.black,
                  fontSize: 9,
                ),

                columns: [
                  _tableColumn('Name', catalogueWidth),
                  _tableColumn('Company Name', makesWidth),
                  _tableColumn('Position', equipmentWidth),
                  _tableColumn('Location', modelsWidth),
                  _tableColumn('Email', oemWidth),
                  _tableColumn('Phone Number', industryWidth),
                  _tableColumn('Attachment File', industryWidth),
                  _tableColumn('Description / Application', catalogueWidth),
                ],

                rows: data.map((item) {
                  return DataRow(
                    cells: [
                      _tableDataCell(item.name, catalogueWidth),
                      _tableDataCell(item.companyName, makesWidth),
                      _tableDataCell(item.position, equipmentWidth),
                      _tableDataCell(item.location, modelsWidth),
                      _tableDataCell(item.email, oemWidth),
                      _tableDataCell(item.phoneNumber, industryWidth),
                      _tableDataCell(item.attachmentUrl, industryWidth),
                      _tableDataCell(item.description, industryWidth),
                    ],
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      );
    }

    return GetBuilder<InquiryController>(
      builder: (controller) {
        return SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
            child: Column(
              children: [buildTableInquiry(controller.userDataModel)],
            ),
          ),
        );
      },
    );
  }
}
