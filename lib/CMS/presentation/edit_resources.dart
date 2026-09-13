import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/CMS/controller/resources_controller.dart';
import 'package:project/CMS/global_widget/dropdown_global_widget.dart';
import 'package:project/global_widget/customButton.dart';
import 'package:project/routes/routes_name.dart';

class EditResources extends StatefulWidget {
  const EditResources({super.key});

  @override
  State<EditResources> createState() => _EditResourcesState();
}

class _EditResourcesState extends State<EditResources> {
  final ResourcesController _controller = Get.find<ResourcesController>();
  String? resourceId;

  @override
  void initState() {
    super.initState();
    resourceId = Get.parameters['id'];

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (resourceId != null) {
        await _controller.getResourceById(resourceId!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Resources'),
        backgroundColor: const Color(0xFFFF6A00),
        foregroundColor: Colors.white,
      ),
      body: GetBuilder<ResourcesController>(
        builder: (controller) {
          return SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: Column(
                children: [
                  DropdownFieldData(
                    hintName: 'Select Resources Type',
                    textName: 'Blog Type',
                    value: controller.type,
                    items: const [
                      'Booklet',
                      'Brochure',
                      'Company Certification',
                      'Company Profile',
                      'Presentation',
                      'Product Data Sheet',
                      'Safety Data Sheet',
                      'Technical Video',
                    ],
                    onChanged: (value) {
                      controller.type = value ?? '-';
                      controller.update();
                    },
                  ),

                  SizedBox(height: 20),
                  customBlueAppBarButton(
                    onTap: () async {
                      await controller.pickAndUploadFile();
                    },
                    title: 'Pilih Resources (Opsional)',
                  ),
                  SizedBox(height: 20),
                  controller.fileName != null && controller.fileName!.isNotEmpty
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Text('${controller.fileName}'),
                        )
                      : Container(),
                  SizedBox(height: 20),

                  customBlueAppBarButton(
                    onTap: () async {
                      if (resourceId != null) {
                        await _controller.updateResource(resourceId!);
                        Get.back();
                      }
                    },
                    title: 'Update Resources',
                  ),
                  SizedBox(height: 20),

                  customBlueAppBarButton(
                    onTap: () async {
                      Get.toNamed(AppRouteName.resources);
                    },
                    title: 'Preview',
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}