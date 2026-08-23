import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:project/CMS/controller/blog_controller.dart';
import 'package:project/CMS/global_widget/dropdown_global_widget.dart';
import 'package:project/CMS/global_widget/quill_field_data.dart';
import 'package:project/CMS/global_widget/textfield_widget.dart';
import 'package:project/global%20widget/customButton.dart';
import 'package:project/routes/routes_name.dart';

class AddBlog extends StatefulWidget {
  const AddBlog({super.key});

  @override
  State<AddBlog> createState() => _AddBlogState();
}

class _AddBlogState extends State<AddBlog> {
  final BlogController _controller = Get.find<BlogController>();
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
    return GetBuilder<BlogController>(
      builder: (controller) {
        return SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
            child: Column(
              children: [
                TextFieldData(
                  hintName: 'Blog Title',
                  obsecureText: false,
                  textName: 'Blog Title',
                  controller: blogTitleController,
                ),
                TextFieldData(
                  hintName: 'Blog Writer',
                  obsecureText: false,
                  textName: 'Blog Writer',
                  controller: blogWriterController,
                ),
                DropdownFieldData(
                  hintName: 'Select Writer',
                  textName: 'Blog Writer',
                  value: controller.type,
                  items: const ['Company News', 'Product Insight'],
                  onChanged: (value) {
                    controller.type = value ?? '-';
                    controller.update();
                  },
                ),
                QuillFieldData(
                  textName: 'Content',
                  controller: _controller.quillController,
                ),
                SizedBox(height: 20),
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
                    await controller.createBlog(
                      title: blogTitleController.text,
                      writer: blogWriterController.text,
                    );
                  },
                  title: 'Submit Blog',
                ),
                SizedBox(height: 20),

                customBlueAppBarButton(
                  onTap: () async {
                    Get.toNamed(AppRouteName.blogList);
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
