import 'package:flutter/material.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/state_manager.dart';
import 'package:project/gallery/controller/gallery_controller.dart';
import 'package:project/global_widget/globalAppBar.dart';
import 'package:project/theme/theme.dart';

class IndocoolGalleryScreen extends StatelessWidget {
  IndocoolGalleryScreen({super.key});

  final GalleryController _controller = Get.find<GalleryController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GalleryController>(
      initState: (state) async {
        await _controller.fetchFilteredGallery();
      },
      builder: (controller) {
        return Globalappbar(
          backgroundColor: Color(0xffF4F4F4),
          isNeedInquiryPage: false,
          isNeedScrollButton: true,
          pageWidget: Column(
            children: [
              SizedBox(height: 40),
              Center(
                child: const Text(
                  'INDOCOOL GALLERY',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w900,
                    fontSize: 48,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: _GalleryFilterRow(),
              ),

              if (controller.isLoading)
                const Padding(
                  padding: EdgeInsets.all(32),
                  child: CircularProgressIndicator(),
                )
              else if (controller.groupedGallery.isEmpty)
                const Padding(
                  padding: EdgeInsets.all(32),
                  child: Text(
                    'No gallery found',
                    style: TextStyle(color: Colors.grey),
                  ),
                )
              else
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  itemCount: controller.groupedGallery.length,
                  itemBuilder: (context, index) {
                    // Karena groupedGallery adalah Map
                    final entry = controller.groupedGallery.entries.elementAt(
                      index,
                    );

                    final data = entry.value;

                    if (data.isEmpty) {
                      return const SizedBox.shrink();
                    }

                    return _GallerySectionWidget(data: data);
                  },
                ),

              const Padding(
                padding: EdgeInsets.all(16.0),
                child: _GalleryPaginationRow(),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _GalleryFilterRow extends StatelessWidget {
  const _GalleryFilterRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            _buildDropdown('Month'),
            const SizedBox(width: 8),
            _buildDropdown('Year'),
          ],
        ),
        _buildDropdown('Sort Date', width: 120),
      ],
    );
  }

  Widget _buildDropdown(String hint, {double width = 90}) {
    return Container(
      width: width,
      height: 32,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            hint,
            style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
          ),
          Icon(Icons.arrow_drop_down, color: Colors.grey.shade600, size: 16),
        ],
      ),
    );
  }
}

class _GalleryPaginationRow extends StatelessWidget {
  const _GalleryPaginationRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Info jumlah hasil
        Text(
          'Showing 1-6 of 10,777 Results',
          style: TextStyle(
            color: Colors.grey.shade700,
            fontSize: 12,
            fontStyle: FontStyle.italic,
          ),
        ),

        // Tombol Pagination
        Row(
          children: [
            _buildPageButton(Icons.arrow_back_ios_new, isIcon: true),
            const SizedBox(width: 4),
            _buildPageButton('1', isActive: true),
            const SizedBox(width: 4),
            _buildPageButton('...', isTextOnly: true),
            const SizedBox(width: 4),
            _buildPageButton('1232'),
            const SizedBox(width: 4),
            _buildPageButton(Icons.arrow_forward_ios, isIcon: true),
          ],
        ),
      ],
    );
  }

  Widget _buildPageButton(
    dynamic content, {
    bool isIcon = false,
    bool isActive = false,
    bool isTextOnly = false,
  }) {
    if (isTextOnly) {
      return Text(
        content.toString(),
        style: const TextStyle(color: Colors.black54),
      );
    }

    return Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Colors.transparent,
        border: Border.all(
          color: isActive ? Colors.grey.shade600 : Colors.grey.shade400,
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Center(
        child: isIcon
            ? Icon(content as IconData, size: 12, color: Colors.black87)
            : Text(
                content.toString(),
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                  color: Colors.black87,
                ),
              ),
      ),
    );
  }
}

class _GallerySectionWidget extends StatelessWidget {
  final List<Map<String, dynamic>> data;

  const _GallerySectionWidget({required this.data});

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) {
      return const SizedBox.shrink();
    }

    final first = data.first;

    final createdAt = DateTime.tryParse(first['created_at']?.toString() ?? '');

    final date = createdAt != null
        ? '${createdAt.day.toString().padLeft(2, '0')}/'
              '${createdAt.month.toString().padLeft(2, '0')}/'
              '${createdAt.year}'
        : '-';

    final title = first['title']?.toString() ?? '';
    final subTitle = first['sub_title']?.toString() ?? '';

    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ==========================
          // TITLE + DATE
          // ==========================
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  '$title - $subTitle',
                  style: blackTextStyle.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(width: 16),

              Text(
                date,
                style: const TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
            ],
          ),

          const SizedBox(height: 6),

          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 20,
              childAspectRatio: 1.0,
            ),
            itemCount: data.length,
            itemBuilder: (context, index) {
              final imageUrl = data[index]['image_url']?.toString();

              if (imageUrl == null || imageUrl.isEmpty) {
                return const _DummyImagePlaceholder();
              }

              return ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }

                    return const Center(child: CircularProgressIndicator());
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return const _DummyImagePlaceholder();
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _DummyImagePlaceholder extends StatelessWidget {
  const _DummyImagePlaceholder();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade400, width: 0.5),
      ),
      child: Center(
        child: Icon(
          Icons.image_outlined,
          color: Colors.grey.shade500,
          size: 24,
        ),
      ),
    );
  }
}
