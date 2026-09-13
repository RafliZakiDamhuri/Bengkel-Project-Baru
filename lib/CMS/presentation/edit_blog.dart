import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:get/get.dart';
import 'package:project/CMS/controller/blog_controller.dart';
import 'package:project/CMS/global_widget/dropdown_global_widget.dart';
import 'package:project/CMS/global_widget/quill_field_data.dart';
import 'package:project/CMS/global_widget/textfield_widget.dart';
import 'package:project/global_widget/customButton.dart';
import 'package:project/routes/routes_name.dart';

class EditBlog extends StatefulWidget {
  const EditBlog({super.key});

  @override
  State<EditBlog> createState() => _EditBlogState();
}

class _EditBlogState extends State<EditBlog> {
  final BlogController _controller = Get.find<BlogController>();
  String? blogId;
  bool _isLoading = true;

  final TextEditingController blogTitleController = TextEditingController();
  final TextEditingController blogWriterController = TextEditingController();
  QuillController? _quillController;

  @override
  void initState() {
    super.initState();
    blogId = Get.parameters['id'];

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (blogId != null) {
        await _controller.getBlogById(blogId!);

        final blog = _controller.blog;
        if (blog != null && mounted) {
          blogTitleController.text = blog.title;
          blogWriterController.text = blog.writer;
          _controller.type = blog.type;

          _quillController = QuillController(
            document: Document.fromJson(blog.content),
            selection: const TextSelection.collapsed(offset: 0),
          );

          setState(() => _isLoading = false);
        } else if (mounted) {
          Get.back();
        }
      }
    });
  }

  @override
  void dispose() {
    blogTitleController.dispose();
    blogWriterController.dispose();
    _quillController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Blog'),
        backgroundColor: const Color(0xFFFF6A00),
        foregroundColor: Colors.white,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : GetBuilder<BlogController>(
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
                          controller: _quillController!,
                        ),
                        SizedBox(height: 20),
                        customBlueAppBarButton(
                          onTap: () async {
                            await controller.pickAndUploadImage();
                          },
                          title: 'Pilih Gambar (Opsional)',
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
                            : controller.blog?.imageUrl.isNotEmpty ?? false
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: CachedNetworkImage(
                                  imageUrl: controller.blog!.imageUrl,
                                  width: 300,
                                  height: 200,
                                  fit: BoxFit.contain,
                                ),
                              )
                            : Container(),
                        SizedBox(height: 20),

                        customBlueAppBarButton(
                          onTap: () async {
                            if (blogId != null) {
                              await _controller.updateBlog(
                                blogId!,
                                title: blogTitleController.text,
                                writer: blogWriterController.text,
                                content: _quillController!.document
                                    .toDelta()
                                    .toJson(),
                              );
                              Get.back();
                            }
                          },
                          title: 'Update Blog',
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
            ),
    );
  }
}