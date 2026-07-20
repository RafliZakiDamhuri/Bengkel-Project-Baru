import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/CMS/controller/cms_controller.dart';
import 'package:project/CMS/global_widget/build_add_data_layout.dart';
import 'package:project/CMS/global_widget/textfield_widget.dart';
import 'package:project/controller/searchProductController.dart';
import 'package:project/global%20widget/customButton.dart';
import 'package:project/model/productModel.dart';
import 'package:project/theme/string.dart';
import 'package:project/theme/theme.dart';

class EditData extends StatefulWidget {
  const EditData({super.key});

  @override
  State<EditData> createState() => _EditDataState();
}

class _EditDataState extends State<EditData> {
  var cmsController = Get.find<CmsController>();
  String titleCategory = '';
  @override
  void initState() {
    super.initState();

    titleCategory = Get.parameters['category'] ?? '';
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      var productId = int.parse(Get.parameters['id']!);
      await cmsController.getProductById(productId);
      cmsController.fillTextEditinControllerRadiatorAndCoolers(
        cmsController.productModelSingle,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget radiatorsAndCoolers(CmsController controller) {
      return buildAddDataLayout(
        title: titleCategory,

        leftFields: [
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

        rightFields: [
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
        ],

        onSubmit: () async {
          await controller.updateProductRadiatorAndCoolers(
            id: controller.productModelSingle?.id ?? 0,
          );
        },
      );
    }

    Widget radiatorsCapAndAdapter(CmsController controller) {
      return buildAddDataLayout(
        title: titleCategory,

        leftFields: [
          TextFieldData(
            hintName: 'PART NUMBER',
            obsecureText: false,
            textName: 'PART NUMBER',
            controller: controller.partNumberController,
          ),

          TextFieldData(
            hintName: 'MAKES',
            obsecureText: false,
            textName: 'MAKES',
            controller: controller.makesController,
          ),

          TextFieldData(
            hintName: 'APPLICATION',
            obsecureText: false,
            textName: 'APPLICATION',
            controller: controller.applicationController,
          ),

          TextFieldData(
            hintName: 'SIZE',
            obsecureText: false,
            textName: 'SIZE',
            controller: controller.sizeController,
          ),
        ],

        rightFields: [
          TextFieldData(
            hintName: 'PRESSURE RATING',
            obsecureText: false,
            textName: 'PRESSURE RATING',
            controller: controller.pressureRatinController,
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
        ],

        onSubmit: () async {
          await controller.updateProductRadiatorAndCoolers(
            id: controller.productModelSingle?.id ?? 0,
          );
        },
      );
    }

    return GetBuilder<CmsController>(
      builder: (controller) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(left: 40, top: 80, bottom: 20),
              child: (titleCategory == AppString().radiatorAndCoolers)
                  ? radiatorsAndCoolers(controller)
                  : titleCategory == AppString().radiatorCapAndAdapters
                  ? radiatorsCapAndAdapter(controller)
                  : Container(),
            ),
          ),
        );
      },
    );
  }
}
