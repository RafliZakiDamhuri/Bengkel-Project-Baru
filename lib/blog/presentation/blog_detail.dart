import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/CMS/controller/blog_controller.dart';
import 'package:project/Utility/date_time_helper.dart';
import 'package:project/blog/model/blog_model.dart';

import 'package:project/global_widget/globalAppBar.dart';
import 'package:project/routes/routes_name.dart';

import 'package:project/theme/theme.dart';

class BlogDetail extends StatefulWidget {
  const BlogDetail({super.key});

  @override
  State<BlogDetail> createState() => _BlogDetailState();
}

class _BlogDetailState extends State<BlogDetail> {
  final BlogController _controller = Get.find<BlogController>();

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Globalappbar(
      isNeedScrollButton: true,
      isNeedInquiryPage: false,
      pageWidget: SingleChildScrollView(
        child: GetBuilder<BlogController>(
          initState: (state) async {
            final id = Get.parameters['id'];
            await _controller.getBlogById(id ?? '');
            await _controller.getTopBlogs(excludeId: id ?? '');
          },
          builder: (controller) {
            return _content();
          },
        ),
      ),
    );
  }

  Widget articleParagraph(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Text(
        text,
        textAlign: TextAlign.justify,
        style: GoogleFonts.inter(
          fontSize: 16,
          color: Colors.black87,
          height: 1.7,
        ),
      ),
    );
  }

  Widget articleQuote(String text) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        border: Border(left: BorderSide(color: kBlueColor, width: 4)),
      ),
      child: Text(
        text,
        textAlign: TextAlign.justify,
        style: GoogleFonts.inter(
          fontSize: 16,
          fontStyle: FontStyle.italic,
          color: Colors.black87,
          height: 1.7,
        ),
      ),
    );
  }

  Widget insightNewsSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Garis atas
          Container(width: double.infinity, height: 1, color: Colors.black),

          const SizedBox(height: 35),

          Text(
            'Indocool Insight and News',
            style: GoogleFonts.inter(
              fontSize: 28,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),

          const SizedBox(height: 40),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
              _controller.top3Blogs.length,
              (index) => Expanded(
                child: insightNewsCard(blog: _controller.top3Blogs[index]),
              ),
            ),
          ),

          const SizedBox(height: 50),

          // See More Content
          Center(
            child: GestureDetector(
              onTap: () {
                Get.toNamed(AppRouteName.blogList);
              },
              child: Container(
                width: 210,
                height: 55,
                decoration: BoxDecoration(
                  color: const Color(0xFFD6EEFF),
                  border: Border.all(color: Colors.black, width: 1),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'See More Content',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),

                    const SizedBox(width: 30),

                    const Icon(
                      Icons.arrow_forward,
                      size: 24,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget insightNewsCard({required BlogModel blog}) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(AppRouteName.blogDetail, parameters: {'id': blog.id});
      },
      child: Container(
        margin: const EdgeInsets.only(right: 35),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // IMAGE
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CachedNetworkImage(
                imageUrl: blog.imageUrl,
                fit: BoxFit.cover,
                height: 250,
                width: double.infinity,

                placeholder: (_, __) =>
                    const Center(child: CircularProgressIndicator()),
                errorWidget: (_, __, ___) => const Icon(
                  Icons.broken_image,
                  size: 55,
                  color: Colors.white,
                ),
              ),
            ),

            const SizedBox(height: 15),

            // CATEGORY + DATE
            Container(
              width: double.infinity,
              height: 40,
              decoration: BoxDecoration(
                color: const Color(0xFFC8E9FF),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    height: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: const Color(0xFF0864C5),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Text(
                      blog.type,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const Spacer(),

                  Padding(
                    padding: const EdgeInsets.only(right: 18),
                    child: Text(
                      blog.createdAt != null
                          ? DateHelper.formatDate(blog.createdAt!)
                          : '',
                      style: const TextStyle(color: Colors.black, fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 18),

            // TITLE
            Text(
              blog.title,
              style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                height: 1.2,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _content() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 40),
      color: const Color(0xffF4F4F4),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1500),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // TITLE
              Text(
                _controller.blog?.title ?? '',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),

              const SizedBox(height: 15),

              // IMAGE
              SizedBox(
                width: double.infinity,
                height: 750,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: CachedNetworkImage(
                    imageUrl: _controller.blog?.imageUrl ?? '',
                    fit: BoxFit.contain,
                    placeholder: (_, __) =>
                        const Center(child: CircularProgressIndicator()),
                    errorWidget: (_, __, ___) =>
                        const Icon(Icons.broken_image, size: 55),
                  ),
                ),
              ),

              const SizedBox(height: 38),

              // WRITER + DATE
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Written by: ${_controller.blog?.writer ?? '-'}',
                      style: blackTextStyle.copyWith(fontWeight: bold),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Released Date: ${DateHelper.formatDate(_controller.blog?.createdAt ?? DateTime.now())}',
                      textAlign: TextAlign.right,
                      style: blackTextStyle.copyWith(fontWeight: bold),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 38),

              // QUILL
              SizedBox(
                width: double.infinity,
                child: QuillEditor.basic(
                  controller: QuillController(
                    document: Document.fromJson(
                      _controller.blog?.content ?? [],
                    ),
                    selection: const TextSelection.collapsed(offset: 0),
                    readOnly: true,
                  ),
                  config: const QuillEditorConfig(
                    expands: false,
                    padding: EdgeInsets.zero,
                  ),
                ),
              ),

              const SizedBox(height: 40),

              insightNewsSection(),
            ],
          ),
        ),
      ),
    );
  }
}
