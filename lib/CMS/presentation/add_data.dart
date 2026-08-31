import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'package:project/CMS/controller/cms_controller.dart';
import 'package:project/CMS/global_widget/textfield_widget.dart';
import 'package:project/CMS/presentation/test.dart';
import 'package:project/global%20widget/customButton.dart';
import 'package:project/theme/string.dart';
import 'package:project/theme/theme.dart';
import 'package:universal_html/html.dart' as html;

class AddData extends StatelessWidget {
  final String titleCategory;

  const AddData({super.key, required this.titleCategory});

  @override
  Widget build(BuildContext context) {
    Widget radiatorsAndCoolers(CmsController controller) {
      return Container(
        margin: EdgeInsets.only(left: 40, top: 80, bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(titleCategory, style: blackTextStyle.copyWith(fontSize: 30)),
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
                    Row(
                      children: [
                        customBlueAppBarButton(
                          onTap: () async {
                            await controller.pickAndUploadImage();
                          },
                          title: 'Pilih Gambar 2D',
                        ),
                        SizedBox(width: 30),
                        customBlueAppBarButton(
                          onTap: () async {
                            await controller.pickGlb();
                          },
                          title: 'Pilih Gambar 3D',
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        controller.bytes != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.memory(
                                  controller.bytes!,
                                  width: 300,
                                  height: 200,
                                  fit: BoxFit.contain,
                                ),
                              )
                            : Container(),
                        SizedBox(width: 20),

                        controller.glbBytes != null
                            ? SizedBox(
                                width: 300,
                                height: 300,
                                child: ModelViewer(
                                  backgroundColor: Color.fromARGB(
                                    0xFF,
                                    0xEE,
                                    0xEE,
                                    0xEE,
                                  ),

                                  src:
                                      'data:model/gltf-binary;base64,${base64Encode(controller.glbBytes!)}',
                                  alt: 'Model 3D Astronaut',
                                  cameraControls: true,
                                ),
                              )
                            : Container(),
                      ],
                    ),

                    SizedBox(height: 20),
                    customBlueAppBarButton(
                      onTap: () async {
                        await controller.saveProductRadiatorsAndCoolers(
                          categoryProducts: titleCategory,
                        );
                      },
                      title: 'Submit',
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      );
    }

    Widget radiatorsCapAndAdapter(CmsController controller) {
      return Container(
        margin: EdgeInsets.only(left: 40, top: 80, bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(titleCategory, style: blackTextStyle.copyWith(fontSize: 30)),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
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
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                    SizedBox(height: 20),
                    customBlueAppBarButton(
                      onTap: () async {
                        await controller.pickAndUploadImage();
                      },
                      title: 'Pilih Gambar 2D',
                    ),
                    SizedBox(height: 20),
                    controller.bytes != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.memory(
                              controller.bytes!,
                              width: 300,
                              height: 200,
                              fit: BoxFit.contain,
                            ),
                          )
                        : Container(),
                    SizedBox(height: 20),
                    customBlueAppBarButton(
                      onTap: () async {
                        await controller.saveProductRadiatorsAndCap(
                          categoryProducts: titleCategory,
                        );
                      },
                      title: 'Submit',
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      );
    }

    Widget caterpillarTubeAndShellOil(CmsController controller) {
      return Container(
        margin: EdgeInsets.only(left: 40, top: 80, bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(titleCategory, style: blackTextStyle.copyWith(fontSize: 30)),
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
                      hintName: 'APPLICATION',
                      obsecureText: false,
                      textName: 'APPLICATION',
                      controller: controller.applicationController,
                    ),
                    SizedBox(height: 20),
                    customBlueAppBarButton(
                      onTap: () async {
                        await controller.pickAndUploadImage();
                      },
                      title: 'Pilih Gambar 2D',
                    ),
                    SizedBox(height: 20),
                    controller.bytes != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.memory(
                              controller.bytes!,
                              width: 300,
                              height: 200,
                              fit: BoxFit.contain,
                            ),
                          )
                        : Container(),
                    SizedBox(height: 20),
                    customBlueAppBarButton(
                      onTap: () async {
                        await controller.savecaterpillarTubeAndShellOil(
                          categoryProducts: titleCategory,
                        );
                      },
                      title: 'Submit',
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      );
    }

    Widget catetpillarRadiatorCORE(CmsController controller) {
      return Container(
        margin: EdgeInsets.only(left: 40, top: 80, bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(titleCategory, style: blackTextStyle.copyWith(fontSize: 30)),
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
                      hintName: 'CORE TYPE',
                      obsecureText: false,
                      textName: 'CORE TYPE',
                      controller: controller.coretypeController,
                    ),

                    TextFieldData(
                      hintName: 'SEAL TYPE',
                      obsecureText: false,
                      textName: 'SEAL TYPE',
                      controller: controller.sealTypeController,
                    ),
                    TextFieldData(
                      hintName: 'MATERIAL TYPE',
                      obsecureText: false,
                      textName: 'MATERIAL TYPE',
                      controller: controller.materialTypeController,
                    ),
                    TextFieldData(
                      hintName: 'OVER TANK DIMENSION "A"',
                      obsecureText: false,
                      textName: 'OVER TANK DIMENSION "A"',
                      controller: controller.overTankController,
                    ),
                    SizedBox(height: 20),
                    customBlueAppBarButton(
                      onTap: () async {
                        await controller.savecaterpillarRadiatorCore(
                          categoryProducts: titleCategory,
                        );
                      },
                      title: 'Submit',
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      );
    }

    return GetBuilder<CmsController>(
      initState: (state) {
        Get.find<CmsController>().cleanTextEditingController();
      },
      builder: (controller) {
        return Scaffold(
          body: SingleChildScrollView(
            child: (titleCategory == 'Radiators and Coolers')
                ? radiatorsAndCoolers(controller)
                : (titleCategory == 'Radiator Cap and Adapter')
                ? radiatorsCapAndAdapter(controller)
                : (titleCategory == AppString().caterpilarTube)
                ? caterpillarTubeAndShellOil(controller)
                : (titleCategory == AppString().caterpillarRadiatorCore)
                ? catetpillarRadiatorCORE(controller)
                : Container(),
          ),
        );
      },
    );
  }
}
