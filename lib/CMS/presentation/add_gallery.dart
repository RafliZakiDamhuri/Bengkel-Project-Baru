import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:project/CMS/controller/blog_controller.dart';
import 'package:project/CMS/controller/gallery_controller.dart';
import 'package:project/CMS/global_widget/dropdown_global_widget.dart';
import 'package:project/CMS/global_widget/quill_field_data.dart';
import 'package:project/CMS/global_widget/textfield_widget.dart';
import 'package:project/global%20widget/customButton.dart';
import 'package:project/routes/routes_name.dart';

class AddGallery extends StatefulWidget {
  const AddGallery({super.key});

  @override
  State<AddGallery> createState() => _AddGalleryState();
}

class _AddGalleryState extends State<AddGallery> {
  final CMSGalleryController _controller = Get.find<CMSGalleryController>();
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
    return GetBuilder<CMSGalleryController>(
      builder: (controller) {
        return SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
            child: Column(
              children: [
                TextFieldData(
                  hintName: 'Title',
                  obsecureText: false,
                  textName: 'Title',
                  controller: titleController,
                ),
                TextFieldData(
                  hintName: 'Subtitle',
                  obsecureText: false,
                  textName: 'Subtitle',
                  controller: subTitleController,
                ),
                customBlueAppBarButton(
                  onTap: () async {
                    await controller.pickAndUploadImage();
                  },
                  title: 'Pilih Gambar',
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
                    _controller.uploadImageToSupabase(
                      title: titleController.text,
                      subtitle: subTitleController.text,
                    );
                  },
                  title: 'Submit Gambar',
                ),
                SizedBox(height: 20),

                customBlueAppBarButton(
                  onTap: () async {
                    Get.toNamed(AppRouteName.gallery);
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
