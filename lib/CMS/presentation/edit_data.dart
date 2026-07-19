import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/CMS/controller/cms_controller.dart';
import 'package:project/CMS/global_widget/textfield_widget.dart';
import 'package:project/controller/searchProductController.dart';
import 'package:project/global%20widget/customButton.dart';
import 'package:project/model/productModel.dart';
import 'package:project/theme/theme.dart';

class EditDataArgument {
  final ProductModel? productModel;
  final String titleCategory;
  EditDataArgument({this.productModel, required this.titleCategory});
}

class EditData extends StatefulWidget {
  const EditData({super.key});

  @override
  State<EditData> createState() => _EditDataState();
}

class _EditDataState extends State<EditData> {
  late EditDataArgument item;
  var cmsController = Get.find<CmsController>();

  @override
  void initState() {
    super.initState();

    item = Get.arguments as EditDataArgument;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      cmsController.fillTextEditinControllerRadiatorAndCoolers(
        item.productModel,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
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

    return GetBuilder<CmsController>(
      builder: (controller) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(left: 40, top: 80, bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    item.titleCategory,
                    style: blackTextStyle.copyWith(fontSize: 30),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          TextFieldData(
                            hintName: 'CATALOGUE NUMBER',
                            obsecureText: false,
                            textName: 'CATALOGUE NUMBER',
                            controller: controller.catalogueNumberController,
                          ),
                          TextFieldData(
                            hintName: 'MAKES',
                            obsecureText: false,
                            textName: 'MAKES',
                            controller: controller.makesController,
                          ),
                          TextFieldData(
                            hintName: 'EQUIPMENT TYPE',
                            obsecureText: false,
                            textName: 'EQUIPMENT TYPE',
                            controller: controller.equipmentTypeController,
                          ),
                          TextFieldData(
                            hintName: 'MODELS',
                            obsecureText: false,
                            textName: 'MODELS',
                            controller: controller.modelsController,
                          ),
                          TextFieldData(
                            hintName: 'OEM PART NUMBER',
                            obsecureText: false,
                            textName: 'OEM PART NUMBER',
                            controller: controller.oemPartcontroller,
                          ),
                          TextFieldData(
                            hintName: 'INDUSTRY',
                            obsecureText: false,
                            textName: 'INDUSTRY',
                            controller: controller.industryController,
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFieldData(
                            hintName: 'PRODUCT TYPE',
                            obsecureText: false,
                            textName: 'PRODUCT TYPE',
                            controller: controller.productTypeController,
                          ),
                          TextFieldData(
                            hintName: 'PRODUCT TYPE DESIGN',
                            obsecureText: false,
                            textName: 'PRODUCT TYPE DESIGN',
                            controller: controller.productTypeDesignController,
                          ),
                          TextFieldData(
                            hintName: 'MATERIAL TYPE',
                            obsecureText: false,
                            textName: 'MATERIAL TYPE',
                            controller: controller.materialTypeController,
                          ),
                          TextFieldData(
                            hintName: 'DESCRIPTION / APPLICATION',
                            obsecureText: false,
                            textName: 'DESCRIPTION / APPLICATION',
                            controller: controller.descriptionController,
                          ),
                          SizedBox(height: 20),
                          customBlueAppBarButton(
                            onTap: () async {
                              await controller.updateProductRadiatorAndCoolers(
                                id: item.productModel?.id ?? 0,
                              );
                            },
                            title: 'Update Data',
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
