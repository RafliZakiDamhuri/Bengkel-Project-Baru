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
        await _controller.fetchFilterOptions();
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
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                child: _GalleryFilterRow(),
              ),
              SizedBox(height: 40),

              if (controller.isLoading)
                const Padding(
                  padding: EdgeInsets.all(32),
                  child: CircularProgressIndicator(),
                )
              else if (controller.gallery.isEmpty)
                const Padding(
                  padding: EdgeInsets.all(32),
                  child: Text(
                    'No gallery found',
                    style: TextStyle(color: Colors.grey),
                  ),
                )
              else
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 150),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 20,
                    childAspectRatio: 0.8,
                  ),
                  itemCount: controller.gallery.length,
                  itemBuilder: (context, index) {
                    final item = controller.gallery[index];
                    final imageUrl = item['image_url']?.toString();
                    final title = item['title']?.toString() ?? '';
                    final subTitle = item['sub_title']?.toString() ?? '';

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Topic ($title) - Products ($subTitle)',

                          overflow: TextOverflow.ellipsis,
                          style: blackTextStyle.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 14),
                            child: imageUrl == null || imageUrl.isEmpty
                                ? const _DummyImagePlaceholder()
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.network(
                                      imageUrl,
                                      fit: BoxFit.cover,
                                      loadingBuilder:
                                          (context, child, loadingProgress) {
                                            if (loadingProgress == null) {
                                              return child;
                                            }

                                            return const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            );
                                          },
                                      errorBuilder: (context, error, stackTrace) {
                                        return const _DummyImagePlaceholder();
                                      },
                                    ),
                                  ),
                          ),
                        ),
                      ],
                    );
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
    final controller = Get.find<GalleryController>();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            _buildDropdown(
              hint: 'Topic',
              value: controller.selectedTopic,
              items: ['All Topics', ...controller.topics],
              onChanged: (value) {
                controller.setTopic(value == 'All Topics' ? null : value);
              },
              width: 150,
            ),
            const SizedBox(width: 8),
            _buildDropdown(
              hint: 'Products',
              value: controller.selectedProduct,
              items: ['All Products', ...controller.products],
              onChanged: (value) {
                controller.setProduct(value == 'All Products' ? null : value);
              },
              width: 170,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDropdown({
    required String hint,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
    double width = 90,
  }) {
    return SizedBox(
      width: width,
      height: 32,
      child: DropdownButtonFormField<String>(
        initialValue: items.contains(value) ? value : null,
        isExpanded: true,
        icon: Icon(
          Icons.arrow_drop_down,
          color: Colors.grey.shade600,
          size: 16,
        ),
        style: TextStyle(color: Colors.grey.shade700, fontSize: 12),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey.shade600, fontSize: 12),
          contentPadding: const EdgeInsets.symmetric(horizontal: 8),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: BorderSide(color: Colors.grey.shade400),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: BorderSide(color: Colors.grey.shade400),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: BorderSide(color: Colors.grey.shade600),
          ),
        ),
        items: items.map((item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(
              item,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 12),
            ),
          );
        }).toList(),
        onChanged: onChanged,
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
