import 'package:flutter/material.dart';
import 'package:project/global_widget/app_asset_image.dart';
import 'package:get/get.dart';
import 'package:project/controller/mainProductController.dart';
import 'package:project/global_widget/globalAppBar.dart';
import 'package:project/theme/app_images.dart';
import 'package:project/theme/string.dart';
import 'package:project/theme/theme.dart';

class CatterpillarReplacement extends StatelessWidget {
  const CatterpillarReplacement({super.key});

  @override
  Widget build(BuildContext context) {
    return Globalappbar(pageWidget: const _CatterpillarReplacement());
  }
}

class _CatterpillarReplacement extends StatelessWidget {
  const _CatterpillarReplacement();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final horizontal = width >= 1200
            ? (width - 1200) / 2
            : width >= 900
            ? 48.0
            : 20.0;
        final contentWidth = width - (horizontal * 2);
        final isWide = contentWidth >= 800;

        return Column(
          children: [
            _buildHero(isWide),
            _buildShowcase(horizontal, contentWidth, isWide),
            _buildAmocsCoreRadiator(horizontal, contentWidth, isWide),
            _buildFoldedCoreRadiator(horizontal, contentWidth, isWide),
            _buildModularCoreRadiator(horizontal, contentWidth, isWide),
            _buildNgmrCoreRadiator(horizontal, contentWidth, isWide),

            _buildSpareParts(horizontal, contentWidth, isWide),
          ],
        );
      },
    );
  }

  Widget _buildSpareParts(double horizontal, double contentWidth, bool isWide) {
    final columns = contentWidth >= 900
        ? 4
        : contentWidth >= 560
        ? 2
        : 1;
    final cardWidth = columns == 1
        ? contentWidth
        : (contentWidth - (20 * (columns - 1))) / columns;

    const applications = <String>[
      'MINING INDUSTRY',
      'POWER GENERATION',
      'GENERAL INDUSTRY',
      'TRANSPORTATION & LOGISTIC',
    ];

    return Container(
      width: double.infinity,
      color: const Color(0xFFF6F8FB),
      padding: EdgeInsets.symmetric(horizontal: horizontal, vertical: 40),
      child: Column(
        children: [
          const _SectionHeading(text: 'APPLICATIONS'),
          const SizedBox(height: 24),
          Text(
            'The Indocool HT Series Radiator Core Seals (Core Seal Rubber) are engineered elastomeric sealing solutions specifically designed to cushion and protect heavy-duty modular radiator units, which are constructed from individual cores rather than a single mono-block structure. Installed directly between individual core headers and tanks, these specialized seals absorb severe mechanical vibrations and shock loads while allowing the individual metal core tubes to float, expand, and contract freely during extreme thermal cycling. By eliminating rigid metal stress points, they prevent structural joint fatigue, cracking, and fluid leaks under the demanding conditions of mining and heavy construction operations. To deliver complete cooling maintenance support, Indocool provides the full range of core rubber seals alongside our individual replacement cores across all major modular architectures.',
            textAlign: isWide ? TextAlign.center : TextAlign.left,
            style: blackTextStyle.copyWith(
              fontWeight: FontWeight.w900,
              fontSize: isWide ? 15 : 13,
              height: 1.8,
              color: const Color(0xFF47515F),
            ),
          ),
          const SizedBox(height: 32),
          Wrap(
            spacing: 20,
            runSpacing: 20,
            children: applications.asMap().entries.map((application) {
              var stringImage = '';
              if (application.key == 0) {
                stringImage = AppImages().catterpillarReplacementSpareParts1;
              } else if (application.key == 1) {
                stringImage = AppImages().catterpillarReplacementSpareParts2;
              } else if (application.key == 2) {
                stringImage = AppImages().catterpillarReplacementSpareParts3;
              } else if (application.key == 3) {
                stringImage = AppImages().catterpillarReplacementSpareParts4;
              }
              return SizedBox(
                width: cardWidth,
                child: _ApplicationCard(
                  title: application.value,
                  imageHeight: isWide ? 300 : 180,
                  imageAssets: stringImage,
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildShowcase(double horizontal, double contentWidth, bool isWide) {
    final cardWidth = isWide ? (contentWidth - 24) / 2 : contentWidth;

    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: EdgeInsets.symmetric(
        horizontal: horizontal,
        vertical: isWide ? 56 : 36,
      ),
      child: AppAssetImage(
        AppImages().catterpillarReplacementSubproduct,
        width: cardWidth,
        fit: BoxFit.contain,
      ),
    );
  }

  Widget _buildHero(bool isWide) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final mediaQuery = MediaQuery.of(context);
        final viewportHeight =
            mediaQuery.size.height - mediaQuery.padding.top - 100;
        final height = viewportHeight.clamp(420.0, double.infinity).toDouble();
        final titleSize = (width * 0.035).clamp(22.0, 40.0).toDouble();
        final bodySize = (width * 0.017).clamp(12.0, 16.0).toDouble();
        final contentWidth = isWide
            ? (width * 0.38).clamp(300.0, 460.0).toDouble()
            : width - 40;

        return SizedBox(
          width: double.infinity,
          height: height,
          child: Stack(
            fit: StackFit.expand,
            children: [
              AppAssetImage(
                AppImages().catterpillarReplacementProduct,
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
                alignment: Alignment.bottomCenter,
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: isWide ? width * 0.045 : 20,
                  right: 20,
                  top: isWide ? height * 0.12 : 24,
                ),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: SizedBox(
                    width: contentWidth,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Caterpillar® Replacement Radiator Core',
                          style: blackTextStyle.copyWith(
                            fontSize: titleSize,
                            fontWeight: bold,
                            height: 1.12,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Indocool supplies a comprehensive range of Caterpillar® replacement radiator cores. Our product range includes Folded Panel Cores, AMOCS (Advanced Modular Cooling System) Cores, Modular Cores, and Next Generation Modular Radiator (NGMR) Cores, engineered to deliver efficient heat transfer, cooling performance, and durability.',
                          style: blackTextStyle.copyWith(
                            fontSize: bodySize,
                            height: 1.55,
                            color: const Color(0xFF1F2933),
                          ),
                        ),
                        const SizedBox(height: 18),
                        ElevatedButton(
                          onPressed: () {
                            Get.find<MainProductController>().downloadPdfWeb(
                              AppString().catterpillarReplacementPdfUrl,
                              pdfName:
                                  'Caterpillar® Replacement Radiator Core Brochure.pdf',
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF0B6FD1),
                            foregroundColor: Colors.white,
                            elevation: 2,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 18,
                              vertical: 10,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                          child: const Text(
                            'DOWNLOAD BROCHURE',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.4,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAmocsCoreRadiator(
    double horizontal,
    double contentWidth,
    bool isWide,
  ) {
    return _CoolantSection(
      horizontal: horizontal,
      contentWidth: contentWidth,
      isWide: isWide,
      backgroundColor: const Color(0xFFF6F8FB),
      imageAsset: AppImages().catterpillarReplacement1,
      title: 'AMOCS CORE RADIATOR',
      paragraphs: const [
        'The Indocool AMOCS (Advanced Modular Cooling System) Radiator Core is an engineered, high-efficiency cooling solution built specifically for heavy-duty earthmoving equipment, dozers, and large loaders operating under severe thermal loads. Utilizing an advanced two-pass cooling circuit, coolant flows from the bottom tank up through the front side, over the top of the core, and back down along the engine side. This double-pass flow pattern increases thermal exchange efficiency compared to conventional single-pass designs, and ensuring optimal engine temperatures.',
      ],
      features: const [
        _FeatureData(
          title: 'Advanced Two-Pass Cooling:',
          description:
              'Routes coolant through the radiator core twice for maximum heat exchange and superior thermal dissipation under heavy engine loads.',
        ),
        _FeatureData(
          title: 'True Individual Core Modularity:',
          description:
              'Built using independent core modules rather than a mono-block assembly, allowing single damaged cores to be serviced or replaced independently.',
        ),
        _FeatureData(
          title: 'Drastic Cost & Downtime Savings:',
          description:
              'Eliminates the massive expense and lead time of replacing entire radiator assemblies by enabling quick, targeted field repairs.',
        ),
        _FeatureData(
          title: 'Vibration & Thermal Stress Absorption:',
          description:
              'Dedicated elastomeric core seals cushion each module, allowing metal core tubes to float, expand, and contract without joint cracking or leaks.',
        ),
        _FeatureData(
          title: 'Heavy-Duty Fleet Availability:',
          description:
              'Available as complete AMOCS radiator assemblies, individual replacement cores, and matching core rubber seals to support continuous fleet uptime.',
        ),
      ],
    );
  }

  Widget _buildFoldedCoreRadiator(
    double horizontal,
    double contentWidth,
    bool isWide,
  ) {
    return _CoolantSection(
      horizontal: horizontal,
      contentWidth: contentWidth,
      isWide: isWide,
      backgroundColor: Colors.white,
      imageAsset: AppImages().catterpillarReplacement2,

      title: 'FOLDED CORE RADIATOR',
      paragraphs: const [
        'The Indocool Folded Core Radiator is an engineered, high-efficiency aftermarket cooling solution designed specifically for heavy-duty earthmoving and mining machinery operating under aggressive environmental conditions. Featuring an innovative "folded" layout with individually angled radiator core modules, this design significantly expands total cooling surface area to deliver superior heat dissipation and maintain optimal engine operating temperatures. The structural geometry also enhances overall resistance against mechanical vibration and dust clogging.',
      ],
      features: const [
        _FeatureData(
          title: 'Folded Core Geometry:',
          description:
              'Individually angled radiator modules maximize surface area exposure, boosting thermal exchange while resisting dust accumulation and severe vibration.',
        ),
        _FeatureData(
          title: 'True Individual Core Modularity: ',
          description:
              'Constructed from independent core panels rather than a mono-block structure, allowing damaged modules to be serviced or swapped without taking the full unit offline.',
        ),
        _FeatureData(
          title: 'Minimized Downtime & Repair Costs:',
          description:
              'Drastically reduces maintenance overhead by eliminating the high cost and labor of replacing an entire radiator assembly when localized damage occurs.',
        ),
        _FeatureData(
          title: 'Corrosion-Resistant Construction:',
          description:
              'Built with heavy-duty, high-durability materials engineered to withstand chemical exposure, thermal stress, and aggressive ambient conditions.',
        ),
        _FeatureData(
          title: 'Comprehensive System Availability:',
          description:
              'Indocool provides complete folded radiator assemblies, individual replacement panel cores, and precision-fit core rubber seals to support full fleet maintenance.',
        ),
      ],
    );
  }

  Widget _buildModularCoreRadiator(
    double horizontal,
    double contentWidth,
    bool isWide,
  ) {
    return _CoolantSection(
      horizontal: horizontal,
      contentWidth: contentWidth,
      isWide: isWide,
      backgroundColor: const Color(0xFFF6F8FB),
      imageAsset: AppImages().catterpillarReplacement3,

      title: 'MODULAR CORE RADIATOR',
      paragraphs: const [
        'The Indocool Modular Core Radiator is an engineered cooling solution built to deliver high-efficiency thermal exchange across demanding fluid circulation systems. Featuring an advanced multi-row module design, it maximizes surface area contact to ensure rapid, effective heat dissipation even under continuous heavy-duty operation. Constructed with durable, high-grade materials tailored to specific environmental demands, this radiator system guarantees exceptional reliability, long service life, and sustained operational productivity.',
      ],
      features: const [
        _FeatureData(
          title: 'High-Efficiency Heat Dissipation:',
          description:
              'Multi-row module configuration maximizes cooling surface area contact for rapid thermal transfer under extreme engine loads.',
        ),
        _FeatureData(
          title: 'True Individual Core Modularity:',
          description:
              'Built using independent core sections rather than a rigid single block, allowing targeted replacement of damaged cores without replacing the full assembly.',
        ),
        _FeatureData(
          title: 'Minimized Repair Overhead & Downtime:',
          description:
              'Servicing individual core modules directly on-site eliminates massive replacement costs and keeps equipment operational in the field.',
        ),
        _FeatureData(
          title: 'Vibration & Thermal Stress Absorption:',
          description:
              'Precision-fit elastomeric core rubber seals allow metal tubes to float, expand, and contract freely, preventing structural joint cracks and fluid leaks.',
        ),
        _FeatureData(
          title: 'Tailored Material Options:',
          description:
              'Manufactured with high-grade, durable materials built to withstand aggressive ambient conditions, dust accumulation, and severe environmental stress.',
        ),
      ],
    );
  }

  Widget _buildNgmrCoreRadiator(
    double horizontal,
    double contentWidth,
    bool isWide,
  ) {
    return _CoolantSection(
      horizontal: horizontal,
      contentWidth: contentWidth,
      isWide: isWide,
      backgroundColor: const Color(0xFFF6F8FB),
      imageAsset: AppImages().catterpillarReplacement4,

      title: 'NGMR CORE RADIATOR',
      paragraphs: const [
        'The Indocool Next Generation Modular Radiator (NGMR) Core is an advanced thermal management solution for heavy-duty equipment to deliver superior cooling efficiency and structural durability beyond standard modular designs. Utilizing an optimized parallel flow arrangement across multiple individual cores as standard, it maximizes fluid heat dissipation during high-load, continuous operations. Every critical component, including the cores, header plates, tanks, and side sheets is precision-customized with specialized, high-effectiveness materials to ensure optimum heat transfer and overall system reliability under demanding working conditions..',
      ],
      features: const [
        _FeatureData(
          title: 'Advanced Parallel Flow Architecture: ',
          description:
              'Utilizes an optimized parallel flow arrangement across multiple individual cores as standard to maximize fluid heat dissipation and thermal exchange efficiency.',
        ),
        _FeatureData(
          title: 'True Individual Core Modularity: ',
          description:
              'Constructed using independent core modules rather than a rigid single block, allowing targeted replacement of damaged cores without replacing the full assembly.',
        ),
        _FeatureData(
          title: 'Precision-Customized Components:',
          description:
              'Every critical part—including the cores, header plates, tanks, and side sheets—is precision-customized with specialized, high-effectiveness materials for optimum reliability.',
        ),
        _FeatureData(
          title: 'Vibration & Thermal Stress Absorption:',
          description:
              'Dedicated elastomeric core seals cushion each module, allowing metal core tubes to float, expand, and contract freely to prevent joint cracking and leaks.',
        ),
        _FeatureData(
          title: 'Minimized Repair Overhead & Downtime:',
          description:
              'Servicing individual core modules directly on-site eliminates massive replacement costs.',
        ),
      ],
    );
  }
}

class _FeatureData {
  final String title;
  final String description;

  const _FeatureData({required this.title, required this.description});
}

class _CoolantSection extends StatelessWidget {
  final double horizontal;
  final double contentWidth;
  final bool isWide;
  final Color backgroundColor;
  final String imageAsset;
  final String title;
  final List<String> paragraphs;
  final List<_FeatureData> features;

  const _CoolantSection({
    required this.horizontal,
    required this.contentWidth,
    required this.isWide,
    required this.backgroundColor,
    required this.imageAsset,
    required this.title,
    required this.paragraphs,
    required this.features,
  });

  @override
  Widget build(BuildContext context) {
    final image = _ProductImage(label: imageAsset);
    final content = _buildContent();

    return Container(
      width: double.infinity,
      color: backgroundColor,
      padding: EdgeInsets.symmetric(
        horizontal: horizontal,
        vertical: isWide ? 64 : 40,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity,
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: blackTextStyle.copyWith(
                fontSize: isWide ? 24 : 20,
                fontWeight: FontWeight.w900,
                height: 1.2,
              ),
            ),
          ),
          SizedBox(height: isWide ? 32 : 24),
          if (isWide)
            LayoutBuilder(
              builder: (context, constraints) {
                final imageWidth = (constraints.maxWidth - 40) * 0.5;

                return Stack(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(width: imageWidth),
                        const SizedBox(width: 40),
                        Expanded(child: content),
                      ],
                    ),
                    Positioned(
                      left: 0,
                      top: 0,
                      bottom: 0,
                      width: imageWidth,
                      child: image,
                    ),
                  ],
                );
              },
            )
          else
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 220, child: image),
                const SizedBox(height: 24),
                content,
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...paragraphs.map(
          (paragraph) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Text(
              paragraph,
              style: blackTextStyle.copyWith(
                fontSize: isWide ? 14 : 13,
                height: 1.7,
                color: const Color(0xFF47515F),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Key Features & Benefits:',
          style: blackTextStyle.copyWith(
            fontSize: isWide ? 15 : 14,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 12),
        ...features.map(_buildFeatureRow),
      ],
    );
  }

  Widget _buildFeatureRow(_FeatureData feature) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '•  ',
            style: blackTextStyle.copyWith(
              fontSize: isWide ? 14 : 13,
              height: 1.65,
              fontWeight: FontWeight.w900,
              color: const Color(0xFF1565C0),
            ),
          ),
          Expanded(
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: '${feature.title} ',
                    style: blackTextStyle.copyWith(
                      fontSize: isWide ? 14 : 13,
                      height: 1.65,
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF1F2933),
                    ),
                  ),
                  TextSpan(
                    text: feature.description,
                    style: blackTextStyle.copyWith(
                      fontSize: isWide ? 14 : 13,
                      height: 1.65,
                      color: const Color(0xFF47515F),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionHeading extends StatelessWidget {
  final String text;

  const _SectionHeading({required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          text,
          textAlign: TextAlign.center,
          style: blackTextStyle.copyWith(
            fontSize: 28,
            fontWeight: FontWeight.w900,
            // letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }
}

class _ProductImage extends StatelessWidget {
  final String label;

  const _ProductImage({required this.label});

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(child: AppAssetImage(label, fit: BoxFit.contain));
  }
}

class _StoreBadge extends StatelessWidget {
  final IconData icon;

  const _StoreBadge({required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Icon(icon, size: 16, color: const Color(0xFF1565C0)),
    );
  }
}

class _PlaceholderImage extends StatelessWidget {
  final double? width;
  final double height;
  final String label;
  final bool showBorder;

  const _PlaceholderImage({
    this.width,
    required this.height,
    this.label = 'Image Placeholder',
    this.showBorder = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.infinity,
      height: height,
      decoration: BoxDecoration(
        color: const Color(0xFFE8ECF2),
        border: showBorder ? Border.all(color: const Color(0xFFC9D2DE)) : null,
        borderRadius: showBorder ? BorderRadius.circular(8) : null,
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.image_outlined,
              size: 36,
              color: Color(0xFF9AA7B8),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                label,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xFF7D8A9B),
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ApplicationCard extends StatelessWidget {
  final String title;
  final double imageHeight;
  final String? imageAssets;

  const _ApplicationCard({
    required this.title,
    required this.imageHeight,
    this.imageAssets,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        (imageAssets != null && imageAssets!.isNotEmpty)
            ? ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: AppAssetImage(
                  imageAssets!,
                  width: double.infinity,
                  height: imageHeight,
                  fit: BoxFit.cover,
                ),
              )
            : _PlaceholderImage(
                width: double.infinity,
                height: imageHeight,
                label: '$title Image',
              ),
        const SizedBox(height: 12),
        Text(
          title,
          textAlign: TextAlign.center,
          style: blackTextStyle.copyWith(fontSize: 14, fontWeight: semiBold),
        ),
      ],
    );
  }
}
