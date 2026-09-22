import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:get/get.dart';
import 'package:project/Auth/controller/auth_controller.dart';
import 'package:project/CMS/controller/blog_controller.dart';
import 'package:project/Utility/date_time_helper.dart';
import 'package:project/blog/model/blog_model.dart';
import 'package:project/global_widget/globalAppBar.dart';
import 'package:project/routes/routes_name.dart';

class BlogListPage extends StatefulWidget {
  const BlogListPage({super.key});

  @override
  State<BlogListPage> createState() => _BlogListPageState();
}

class _BlogListPageState extends State<BlogListPage> {
  final BlogController _controller = Get.find<BlogController>();

  Document _justifiedDocument(List<dynamic> content) {
    final justifiedContent = content.map((op) {
      if (op is Map<String, dynamic>) {
        final attrs = Map<String, dynamic>.from(op['attributes'] ?? {});
        attrs['align'] = 'justify';
        return {'insert': op['insert'], 'attributes': attrs};
      }
      return op;
    }).toList();

    return Document.fromJson(justifiedContent);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BlogController>(
      initState: (state) async {
        await _controller.getBlogsbyFilter();
      },
      builder: (controller) {
        return Globalappbar(
          isNeedInquiryPage: false,
          pageWidget: LayoutBuilder(
            builder: (context, constraints) {
              // Gunakan ukuran layar sebenarnya
              final width = MediaQuery.of(context).size.width;

              final horizontalPadding = width >= 1200
                  ? 24.0
                  : width >= 800
                  ? 20.0
                  : 16.0;

              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // =====================================================
                    // HERO
                    // =====================================================
                    _buildHero(width),

                    // =====================================================
                    // CONTENT
                    // =====================================================
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: horizontalPadding,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 16),

                          // =================================================
                          // HEADER + FILTER
                          // =================================================
                          _buildHeaderAndFilter(width),

                          const SizedBox(height: 14),

                          // =================================================
                          // BLOG GRID
                          // =================================================
                          _buildBlogGrid(width),

                          const SizedBox(height: 20),

                          // =================================================
                          // PAGINATION
                          // =================================================
                          _buildPagination(),

                          const SizedBox(height: 30),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  // ============================================================
  // HERO
  // ============================================================

  Widget _buildHero(double width) {
    return Container(
      width: double.infinity,
      height: width >= 800 ? 300 : 160,
      decoration: const BoxDecoration(color: Color(0xFFE5E5E5)),
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/blog-header.webp'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  // ============================================================
  // HEADER + FILTER
  // ============================================================

  Widget _buildHeaderAndFilter(double width) {
    final isMobile = width < 700;

    if (isMobile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Indocool Insight and News',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 12),

          _buildFilters(),
        ],
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Expanded(
          child: Text(
            'Indocool Insight and News',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),

        _buildFilters(),
      ],
    );
  }

  // ============================================================
  // FILTERS
  // ============================================================

  Widget _buildFilters() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        // CONTENT
        _buildDropdown(
          width: 120,
          hint: 'Select a content',
          value: _controller.selectedContent,
          items: const ['Company News', 'Product Insight'],
          onChanged: _controller.setContentType,
        ),

        // MONTH
        _buildDropdown(
          width: 90,
          hint: 'Month',
          value: _controller.selectedMonth == null
              ? null
              : [
                  'January',
                  'February',
                  'March',
                  'April',
                  'May',
                  'June',
                  'July',
                  'August',
                  'September',
                  'October',
                  'November',
                  'December',
                ][_controller.selectedMonth! - 1],
          items: const [
            'January',
            'February',
            'March',
            'April',
            'May',
            'June',
            'July',
            'August',
            'September',
            'October',
            'November',
            'December',
          ],
          onChanged: _controller.setMonth,
        ),

        // YEAR
        _buildDropdown(
          width: 75,
          hint: 'Year',
          value: _controller.selectedYear?.toString(),
          items: const ['2026', '2025', '2024', '2023'],
          onChanged: _controller.setYear,
        ),
      ],
    );
  }

  // ============================================================
  // DROPDOWN
  // ============================================================

  Widget _buildDropdown({
    required double width,
    required String hint,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return SizedBox(
      width: width,
      height: 30,
      child: DropdownButtonFormField<String>(
        value: value,
        isExpanded: true,

        icon: const Icon(Icons.keyboard_arrow_down, size: 14),

        style: const TextStyle(fontSize: 9, color: Colors.black),

        decoration: InputDecoration(
          hintText: hint,

          hintStyle: const TextStyle(fontSize: 9, color: Colors.grey),

          contentPadding: const EdgeInsets.symmetric(horizontal: 8),

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(3),
            borderSide: const BorderSide(color: Color(0xFFD0D0D0)),
          ),

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(3),
            borderSide: const BorderSide(color: Color(0xFFD0D0D0)),
          ),

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(3),
            borderSide: const BorderSide(color: Colors.grey),
          ),
        ),

        items: items.map((item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item, maxLines: 1, overflow: TextOverflow.ellipsis),
          );
        }).toList(),

        onChanged: onChanged,
      ),
    );
  }

  // ============================================================
  // BLOG GRID
  // ============================================================

  Widget _buildBlogGrid(double width) {
    int crossAxisCount;

    // Desktop
    if (width >= 1000) {
      crossAxisCount = 3;
    }
    // Tablet
    else if (width >= 650) {
      crossAxisCount = 2;
    }
    // Mobile
    else {
      crossAxisCount = 1;
    }

    // ==========================================================
    // HITUNG LEBAR CARD
    // ==========================================================

    final horizontalPadding = width >= 1200
        ? 24.0
        : width >= 800
        ? 20.0
        : 16.0;

    final gridWidth = width - (horizontalPadding * 2);

    const crossAxisSpacing = 16.0;

    final cardWidth =
        (gridWidth - (crossAxisSpacing * (crossAxisCount - 1))) /
        crossAxisCount;

    // ==========================================================
    // HITUNG TINGGI GAMBAR
    // ==========================================================

    final imageHeight = cardWidth / 1.6;

    // ==========================================================
    // HITUNG TINGGI CARD
    // ==========================================================

    // Image
    // + SizedBox 8
    // + Category 36
    // + SizedBox 7
    // + Title 3 baris (18 * 1.25 * 3 = 67.5 ~ 70)
    // + Quill excerpt 3 baris (24 * 3 = 72)
    final cardHeight = imageHeight + 8 + 36 + 7 + 70 + 72;

    return GridView.builder(
      shrinkWrap: true,

      physics: const NeverScrollableScrollPhysics(),

      itemCount: _controller.blogs.length,

      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,

        crossAxisSpacing: crossAxisSpacing,

        mainAxisSpacing: 18,

        // Tinggi card mengikuti ukuran layar
        mainAxisExtent: cardHeight,
      ),

      itemBuilder: (context, index) {
        final blog = _controller.blogs[index];

        return _buildBlogCard(blog: blog);
      },
    );
  }

  // ============================================================
  // BLOG CARD
  // ============================================================

  Widget _buildBlogCard({required BlogModel blog}) {
    return InkWell(
      borderRadius: BorderRadius.circular(4),

      onTap: () {
        Get.toNamed(AppRouteName.blogDetail, parameters: {'id': blog.id});
      },

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ======================================================
          // IMAGE
          // ======================================================
          AspectRatio(
            aspectRatio: 1.6,

            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),

              child: _BlogImageOverlay(blog: blog),
            ),
          ),

          const SizedBox(height: 8),

          // ======================================================
          // CATEGORY + DATE
          // ======================================================
          SizedBox(
            height: 36,

            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),

              decoration: BoxDecoration(
                color: const Color(0xFFB9E0F8),
                borderRadius: BorderRadius.circular(20),
              ),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // ==================================================
                  // CATEGORY
                  // ==================================================
                  Flexible(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 6,
                      ),

                      decoration: BoxDecoration(
                        color: const Color(0xFF006FC9),
                        borderRadius: BorderRadius.circular(20),
                      ),

                      child: Text(
                        blog.type,

                        maxLines: 1,

                        overflow: TextOverflow.ellipsis,

                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 8),

                  // ==================================================
                  // DATE
                  // ==================================================
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10),

                      child: Text(
                        DateHelper.formatDate(blog.createdAt!),

                        maxLines: 1,

                        overflow: TextOverflow.ellipsis,

                        textAlign: TextAlign.right,

                        style: const TextStyle(
                          color: Colors.black87,
                          fontSize: 11,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ======================================================
          // TITLE + CONTENT
          // ======================================================
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 7),
                Text(
                  blog.title,

                  maxLines: 3,

                  overflow: TextOverflow.ellipsis,

                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    height: 1.25,
                  ),
                ),
                const SizedBox(height: 6),
                ClipRect(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      minHeight: 24,
                      maxHeight: 72,
                    ),
                    child: QuillEditor.basic(
                      controller: QuillController(
                        document: _justifiedDocument(blog.content),
                        selection: const TextSelection.collapsed(offset: 0),
                        readOnly: true,
                      ),
                      config: const QuillEditorConfig(
                        expands: false,
                        padding: EdgeInsets.zero,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // PAGINATION
  // ============================================================

  Widget _buildPagination() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        _paginationButton(icon: Icons.arrow_back_ios_new),

        _paginationButton(text: '1', selected: true),

        _paginationButton(text: '...'),

        _paginationButton(text: '1232'),

        _paginationButton(icon: Icons.arrow_forward_ios),
      ],
    );
  }

  // ============================================================
  // PAGINATION BUTTON
  // ============================================================

  Widget _paginationButton({
    String? text,
    IconData? icon,
    bool selected = false,
  }) {
    return Container(
      width: 28,

      height: 28,

      margin: const EdgeInsets.only(left: 4),

      decoration: BoxDecoration(
        color: selected ? Colors.black : Colors.white,

        border: Border.all(color: const Color(0xFFD0D0D0)),

        borderRadius: BorderRadius.circular(3),
      ),

      child: Center(
        child: icon != null
            ? Icon(
                icon,

                size: 11,

                color: selected ? Colors.white : Colors.black,
              )
            : Text(
                text ?? '',

                style: TextStyle(
                  fontSize: 9,

                  color: selected ? Colors.white : Colors.black,
                ),
              ),
      ),
    );
  }
}

class _BlogImageOverlay extends StatefulWidget {
  final BlogModel blog;

  const _BlogImageOverlay({required this.blog});

  @override
  State<_BlogImageOverlay> createState() => _BlogImageOverlayState();
}

class _BlogImageOverlayState extends State<_BlogImageOverlay> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isLoggedIn = Get.find<AuthController>().isLoggedIn();

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),

      child: Stack(
        fit: StackFit.expand,
        children: [
          CachedNetworkImage(
            imageUrl: widget.blog.imageUrl,

            fit: BoxFit.cover,

            placeholder: (_, __) {
              return const Center(child: CircularProgressIndicator());
            },

            errorWidget: (_, __, ___) {
              return const Center(
                child: Icon(Icons.broken_image, size: 55, color: Colors.grey),
              );
            },
          ),

          if (isLoggedIn && _isHovered)
            Container(
              color: Colors.black.withValues(alpha: 0.45),

              child: Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _overlayActionButton(
                      icon: Icons.edit,
                      color: Colors.blue,
                      onTap: () {
                        Get.toNamed(
                          AppRouteName.editBlog,
                          parameters: {'id': widget.blog.id},
                        );
                      },
                    ),
                    const SizedBox(width: 20),
                    _overlayActionButton(
                      icon: Icons.delete,
                      color: Colors.redAccent,
                      onTap: () => _confirmDelete(),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _overlayActionButton({
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,

      child: Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.3),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Icon(icon, color: color, size: 22),
      ),
    );
  }

  void _confirmDelete() {
    Get.dialog(
      AlertDialog(
        title: const Text('Delete Blog'),
        content: Text(
          'Apakah Anda yakin ingin menghapus "${widget.blog.title}"?',
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Batal')),
          TextButton(
            onPressed: () async {
              Get.back();
              await Get.find<BlogController>().deleteBlogById(widget.blog.id);
            },
            child: const Text('Hapus', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
