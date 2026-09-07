import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:project/CMS/controller/resources_controller.dart';
import 'package:project/CMS/global_widget/dropdown_global_widget.dart';
import 'package:project/global_widget/customButton.dart';
import 'package:project/routes/routes_name.dart';

class AddResources extends StatefulWidget {
  const AddResources({super.key});

  @override
  State<AddResources> createState() => _AddResourcesState();
}

class _AddResourcesState extends State<AddResources> {
  final ResourcesController _controller = Get.find<ResourcesController>();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  TextEditingController blogTitleController = TextEditingController();
  TextEditingController blogWriterController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ResourcesController>(
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
                  title: 'Pilih Resources',
                ),
                SizedBox(height: 20),
                controller.bytes != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Text('${controller.fileName}'),
                      )
                    : Container(),
                SizedBox(height: 20),

                customBlueAppBarButton(
                  onTap: () async {
                    _controller.uploadResourcesToSupabase();
                  },
                  title: 'Submit Resources',
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
    );
  }
}
