import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill_extensions/flutter_quill_extensions.dart';

import 'package:get/get.dart';
import 'package:project/CMS/controller/blog_controller.dart';
import 'package:project/CMS/global_widget/dropdown_global_widget.dart';
import 'package:project/CMS/global_widget/quill_field_data.dart';
import 'package:project/CMS/global_widget/textfield_widget.dart';
import 'package:project/global_widget/customButton.dart';
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
    _controller.resetForm();
  }

  @override
  void dispose() {
    blogTitleController.dispose();
    blogWriterController.dispose();
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
                  hintName: 'Select Blog Type',
                  textName: 'Blog Type',
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
                  title: 'Edit Data',
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class QuillFieldData extends StatelessWidget {
  final String textName;
  final QuillController controller;

  // onImageInsert dihapus karena Anda sudah menggunakan Get.find di bawah

  const QuillFieldData({
    Key? key,
    required this.textName,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label untuk Editor (misal: Text textName) bisa ditaruh di sini

        // Toolbar
        QuillSimpleToolbar(
          controller: controller,
          config: QuillSimpleToolbarConfig(
            customButtons: [
              QuillToolbarCustomButtonOptions(
                icon: const Icon(Icons.image),
                tooltip: 'Tambah Gambar',
                onPressed: () async {
                  // Langsung panggil fungsi dari controller
                  final blogController = Get.find<BlogController>();
                  await blogController.pickAndInsertImageToQuill();
                },
              ),
            ],
          ),
        ),

        // Tambahkan sedikit jarak antara toolbar dan editor jika perlu
        const SizedBox(height: 8),

        // Editor
        Container(
          constraints: const BoxConstraints(
            minHeight: 200, // <-- Gunakan BoxConstraints di sini
          ),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.all(8),
          child: QuillEditor.basic(
            controller: controller,
            config: QuillEditorConfig(
              embedBuilders: [...FlutterQuillEmbeds.editorBuilders()],
            ),
          ),
        ),
      ],
    );
  }
}
