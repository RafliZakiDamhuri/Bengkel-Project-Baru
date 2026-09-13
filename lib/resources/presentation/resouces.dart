import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/Auth/controller/auth_controller.dart';
import 'package:project/CMS/controller/resources_controller.dart';
import 'package:project/Utility/date_time_helper.dart';
import 'package:project/global_widget/globalAppBar.dart';
import 'package:project/resources/model/resource_model.dart';
import 'package:project/routes/routes_name.dart';
import 'package:project/theme/theme.dart';

class ResourceItem {
  final String fileName;
  final String resourceType;
  final String fileType;
  final String datePublished;

  const ResourceItem({
    required this.fileName,
    required this.resourceType,
    required this.fileType,
    required this.datePublished,
  });
}

class DownloadableResourcesPage extends StatefulWidget {
  const DownloadableResourcesPage({super.key});

  @override
  State<DownloadableResourcesPage> createState() =>
      _DownloadableResourcesPageState();
}

final ResourcesController _controller = Get.find<ResourcesController>();

class _DownloadableResourcesPageState extends State<DownloadableResourcesPage> {
  String selectedCategory = 'All';

  final List<String> categories = [
    'Booklet',
    'Brochure',
    'Company Certification',
    'Company Profile',
    'Presentation',
    'Product Data Sheet',
    'Safety Data Sheet',
    'Technical Video',
  ];

  final List<ResourceItem> resources = const [
    ResourceItem(
      fileName: 'Indocool Booklet 2026',
      resourceType: 'Booklet',
      fileType: 'PDF',
      datePublished: '29 July 2026',
    ),
    ResourceItem(
      fileName: 'Indocool All Product Line Up Brochure',
      resourceType: 'Brochure',
      fileType: 'PDF',
      datePublished: '29 July 2026',
    ),
    ResourceItem(
      fileName:
          'RADMAX® Radiator / Engine Coolant Water Base Premix Product Data Sheet',
      resourceType: 'Product Data Sheet',
      fileType: 'PDF',
      datePublished: '29 July 2026',
    ),
    ResourceItem(
      fileName: 'Indocool RADMAX® Removable Tube Salt Spray Test Video',
      resourceType: 'Technical Video',
      fileType: 'MP4',
      datePublished: '29 July 2026',
    ),
    ResourceItem(
      fileName: 'Indocool Company Profile 2026',
      resourceType: 'Company Profile',
      fileType: 'PDF',
      datePublished: '28 July 2026',
    ),
    ResourceItem(
      fileName: 'RADMAX Product Presentation',
      resourceType: 'Presentation',
      fileType: 'PDF',
      datePublished: '27 July 2026',
    ),
    ResourceItem(
      fileName: 'Company Certification ISO 9001',
      resourceType: 'Company Certification',
      fileType: 'PDF',
      datePublished: '25 July 2026',
    ),
    ResourceItem(
      fileName: 'Safety Data Sheet - Coolant',
      resourceType: 'Safety Data Sheet',
      fileType: 'PDF',
      datePublished: '24 July 2026',
    ),
  ];

  List<ResourceItem> get filteredResources {
    if (selectedCategory == 'All') {
      return resources;
    }

    return resources
        .where((item) => item.resourceType == selectedCategory)
        .toList();
  }

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _controller.getResources();
    });

    super.initState();
  }

  // backgroundColor: const Color(0xFF000000),
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ResourcesController>(
      builder: (controller) {
        return Globalappbar(
          isNeedInquiryPage: false,
          pageWidget: Container(
            margin: EdgeInsets.only(left: 50, right: 50, bottom: 10, top: 10),
            color: const Color(0xFF000000),

            child: SafeArea(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    child: Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 1200),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 30,
                            vertical: 18,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              _buildTitle(),
                              const SizedBox(height: 20),
                              _buildCategoryFilter(),
                              const SizedBox(height: 20),
                              _buildResourceHeader(),
                              const SizedBox(height: 14),
                              _buildTable(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTitle() {
    return Container(
      height: 48,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFFF6A00), width: 2),
        borderRadius: BorderRadius.circular(5),
      ),
      child: const Text(
        'INDOCOOL DOWNLOADABLE RESOURCES',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: 25,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.3,
        ),
      ),
    );
  }

  Widget _buildCategoryFilter() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(3),
      ),
      child: Column(
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              final isMobile = constraints.maxWidth < 600;

              if (isMobile) {
                return Column(
                  children: [
                    ...categories.map(
                      (category) => _buildCategoryItem(category),
                    ),
                  ],
                );
              }

              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: categories.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: constraints.maxWidth < 850 ? 2 : 4,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 12,
                  childAspectRatio: 4.8,
                ),
                itemBuilder: (context, index) {
                  return _buildCategoryItem(categories[index]);
                },
              );
            },
          ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerRight,
            child: InkWell(
              onTap: () {
                _controller.getResources();
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 2, vertical: 5),
                child: Text(
                  'Shows All',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 10,
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryItem(String category) {
    final bool isSelected = selectedCategory == category;

    return InkWell(
      onTap: () {
        selectedCategory = category;
        _controller.getResourcesByType(type: category);
        _controller.update();
      },
      child: Container(
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isSelected
                  ? const Color(0xFFFF6A00)
                  : const Color(0xFF888888),
              width: isSelected ? 2 : 1,
            ),
          ),
        ),
        child: Text(
          category,
          style: TextStyle(
            color: Colors.black,
            fontSize: 11,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w400,
          ),
        ),
      ),
    );
  }

  Widget _buildResourceHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const Expanded(
          child: Text(
            'DOWNLOADABLE RESOURCE LIST',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        Flexible(
          child: Text(
            'the data that is shown in the column below is clickable and downloadable',
            textAlign: TextAlign.right,
            style: TextStyle(
              color: Colors.white,
              fontSize: 8,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTable() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildColumnLabels(constraints),
            const SizedBox(height: 7),
            _buildTableContent(constraints),
          ],
        );
      },
    );
  }

  static const int _columnFlex = 2;
  static const double _columnGap = 15;

  Widget _buildColumnLabels(BoxConstraints constraints) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(flex: _columnFlex, child: _topLabel('File Name')),
          const SizedBox(width: _columnGap),
          Expanded(flex: _columnFlex, child: _topLabel('Resource Type')),
          const SizedBox(width: _columnGap),
          Expanded(flex: _columnFlex, child: _topLabel('File Type')),
          const SizedBox(width: _columnGap),
          Expanded(flex: _columnFlex, child: _topLabel('Date Published')),
        ],
      ),
    );
  }

  bool get isLoggedIn => Get.find<AuthController>().isLoggedIn();

  Widget _topLabel(String text) {
    return PopupMenuButton<String>(
      offset: const Offset(0, 25),
      padding: EdgeInsets.zero,
      onSelected: (value) {
        _controller.getDataByFilter(value, text);
      },
      itemBuilder: (context) {
        return List.generate(_controller.fileNames.length, (index) {
          if (text == 'File Name') {
            return PopupMenuItem<String>(
              value: _controller.fileName,
              child: Text(_controller.fileNames[index]),
            );
          } else {
            return PopupMenuItem<String>(
              value: _controller.types[index],
              child: Text(_controller.types[index]),
            );
          }
        });
      },
      child: Container(
        height: 22,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(2),
        ),
        child: Text(text, style: blackTextStyle),
      ),
    );
  }

  Widget _buildTableContent(BoxConstraints constraints) {
    final bool isMobile = constraints.maxWidth < 650;

    if (isMobile) {
      return _buildMobileList();
    }

    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(3)),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          _buildTableHeader(),
          ...List.generate(_controller.resources.length, (index) {
            return _buildTableRow(_controller.resources[index], index);
          }),
        ],
      ),
    );
  }

  Widget _buildTableHeader() {
    return Container(
      color: const Color(0xFFFF6500),
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      child: Row(
        children: [
          const Expanded(
            flex: 2,
            child: Center(
              child: Text(
                'File Name',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(width: _columnGap),
          const Expanded(
            flex: 2,
            child: Center(
              child: Text(
                'Resource Type',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(width: _columnGap),
          const Expanded(
            flex: 2,
            child: Center(
              child: Text(
                'File Type',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(width: _columnGap),
          const Expanded(
            flex: 2,
            child: Center(
              child: Text(
                'Date Published',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          if (isLoggedIn) ...[
            const SizedBox(width: _columnGap),
            const Expanded(
              flex: 2,
              child: Center(
                child: Text(
                  'Edit',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildTableRow(ResourceModel item, int index) {
    return Material(
      color: index.isEven ? const Color(0xFFF1F1F1) : Colors.white,
      child: InkWell(
        onTap: () {
          debugPrint('Download: ${item.fileName}');
          _controller.downloadFile(url: item.fileUrl!, fileName: item.fileName);
        },
        child: Container(
          constraints: const BoxConstraints(minHeight: 45),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Color(0xFFE0E0E0), width: 1),
            ),
          ),
          child: Row(
            children: [
              Expanded(flex: _columnFlex, child: _rowText(item.fileName)),
              const SizedBox(width: _columnGap),
              Expanded(flex: _columnFlex, child: _rowText(item.type ?? '-')),
              const SizedBox(width: _columnGap),
              Expanded(
                flex: _columnFlex,
                child: _rowText(item.fileExtention ?? '-'),
              ),
              const SizedBox(width: _columnGap),
              Expanded(
                flex: _columnFlex,
                child: _rowText(
                  DateHelper.formatDate(item.createdAt ?? DateTime.now()),
                ),
              ),
              if (isLoggedIn) ...[
                const SizedBox(width: _columnGap),
                Expanded(flex: _columnFlex, child: _buildEditActions(item)),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _rowText(String text) {
    return Center(
      child: Text(
        text,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          color: Color(0xFF444444),
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  Widget _buildEditActions(ResourceModel item) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () {
            Get.toNamed(
              AppRouteName.editResources,
              parameters: {'id': item.id},
            );
          },
          icon: const Icon(Icons.edit, size: 18, color: Color(0xFFFF6A00)),
          tooltip: 'Edit',
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
        ),
        const SizedBox(width: 10),
        IconButton(
          onPressed: () => _controller.deleteResourceById(item.id),
          icon: const Icon(Icons.delete, size: 18, color: Colors.red),
          tooltip: 'Delete',
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
        ),
      ],
    );
  }

  Widget _buildMobileList() {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(3)),
      child: Column(
        children: [
          _buildTableHeader(),
          ...List.generate(filteredResources.length, (index) {
            final item = filteredResources[index];

            return Material(
              color: index.isEven ? const Color(0xFFF1F1F1) : Colors.white,
              child: InkWell(
                onTap: () {
                  debugPrint('Download: ${item.fileName}');
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 12,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _rowText(item.fileName),
                      const SizedBox(height: 5),
                      _rowText(
                        '${item.resourceType} • ${item.fileType} • ${item.datePublished}',
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
