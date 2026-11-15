import 'package:flutter/material.dart';
import 'package:project/global_widget/app_asset_image.dart';
import 'package:get/get.dart';
import 'package:project/controller/mainProductController.dart';
import 'package:project/global_widget/globalAppBar.dart';
import 'package:project/theme/app_images.dart';
import 'package:project/theme/string.dart';
import 'package:project/theme/theme.dart';
import 'package:project/product/product_widgets.dart';

const String _loremShort =
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit.';

const String _lorem =
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.';

class CatterpillarTubeAndShell extends StatelessWidget {
  const CatterpillarTubeAndShell({super.key});

  @override
  Widget build(BuildContext context) {
    return Globalappbar(pageWidget: const _CaterpillarTubeAndShell());
  }
}

class _CaterpillarTubeAndShell extends StatelessWidget {
  const _CaterpillarTubeAndShell();

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
            _buildDescription(horizontal, contentWidth, isWide),
            _buildBundleRemovableOilCooler(horizontal, contentWidth, isWide),
            _buildKeyFeatures(horizontal, contentWidth, isWide),
            _buildBundleOilCooler(horizontal, contentWidth, isWide),
            _buildKeyFeaturesCustom(horizontal, contentWidth, isWide),
          ],
        );
      },
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
                AppImages().caterpillarTubeAndShellProduct,
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
                          'Caterpillar® Tube & Shell Oil Cooler',
                          style: blackTextStyle.copyWith(
                            fontSize: titleSize,
                            fontWeight: bold,
                            height: 1.12,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'A tube & shell oil cooler is a heat exchanger designed to regulate oil temperature by transferring heat between oil and a cooling medium, typically water or air. It consists of a bundle of tubes enclosed within a shell, where one fluid flows through the tubes while the other flows around them, enabling efficient heat exchange.',
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
                              AppString().caterpillarTubeAndShellPdfUrl,
                              pdfName:
                                  'Caterpillar® Tube & Shell Oil Cooler Brochure.pdf',
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
        AppImages().caterpillarTubeAndShellSubproduct,
        width: cardWidth,
        fit: BoxFit.contain,
      ),
    );
  }

  Widget _buildDescription(
    double horizontal,
    double contentWidth,
    bool isWide,
  ) {
    return Container(
      width: double.infinity,
      color: const Color(0xFFF6F8FB),
      padding: EdgeInsets.symmetric(
        horizontal: horizontal,
        vertical: isWide ? 64 : 40,
      ),
      child: Column(
        children: [
          const ProductSectionHeading(text: 'PRODUCT DESCRIPTION'),
          const SizedBox(height: 28),
          Text(
            'Tube & shell oil coolers are widely used in heavy-duty and industrial applications due to their robust construction, high heat transfer capability, and suitability for demanding operating conditions. Depending on the design, these coolers may utilize copper or copper-nickel tubes, along with various joint and sealing methods to ensure reliable performance.\n\nThere are different construction types available, including fixed tube bundle designs, which are commonly used in standard OEM applications, as well as removable tube bundle designs, which allow for easier maintenance, cleaning, and extended service life.Indocool can provide both fixed and removable tube bundle tube & shell oil cooler solutions, tailored to meet specific operational and maintenance requirements.',
            textAlign: isWide ? TextAlign.center : TextAlign.left,
            style: blackTextStyle.copyWith(
              fontSize: isWide ? 15 : 13,
              height: 1.8,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF47515F),
            ),
          ),

          const SizedBox(height: 36),
          AppAssetImage(
            AppImages().caterpillarTubeAndShellProductDescription,
            width: contentWidth,
            height: isWide ? 420 : 230,
            fit: BoxFit.contain,
          ),
        ],
      ),
    );
  }

  Widget _buildKeyFeatures(
    double horizontal,
    double contentWidth,
    bool isWide,
  ) {
    final columns = contentWidth >= 900
        ? 3
        : contentWidth >= 560
        ? 2
        : 1;
    final cardWidth = columns == 1
        ? contentWidth
        : (contentWidth - (24 * (columns - 1))) / columns;

    final features = <ProductFeatureData>[
      const ProductFeatureData(
        title: '100% Serviceable Design:',
        description:
            'Features a removable, floating tube bundle that can be removed, cleaned, resealed, and reused, allowing individual parts to be repaired without replacing the whole unit and enabling remanufacturing with original Caterpillar casings.',
        label: 'Removable Tube Image',
      ),
      const ProductFeatureData(
        title: 'Superior Strength & Reliability:',
        description:
            'Built with 100% copper-nickel tubes and mechanical expansion joints (instead of rubber bonding) to deliver maximum structural strength, corrosion resistance, and leak-free reliability unaffected by coolant quality.',
        label: 'On-Site Repair Image',
      ),
      const ProductFeatureData(
        title: 'Vibration Stress Protection:',
        description:
            'The mechanical expansion joints and floating bundle design allow for natural thermal expansion and contraction while absorbing severe engine vibrations, preventing structural failures and significantly extending service life.',
        label: 'Warranty Badge Image',
      ),
    ];

    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: EdgeInsets.symmetric(
        horizontal: horizontal,
        vertical: isWide ? 64 : 40,
      ),
      child: Column(
        children: [
          const ProductSectionHeading(text: 'KEY FEATURES & BENEFITS'),
          const SizedBox(height: 32),
          Wrap(
            spacing: 24,
            runSpacing: 24,
            children: features.asMap().entries.map((feature) {
              var stringImage = '';

              if (feature.key == 0) {
                stringImage = AppImages().caterpillarTubeAndShell1;
              } else if (feature.key == 1) {
                stringImage = AppImages().caterpillarTubeAndShell2;
              } else if (feature.key == 2) {
                stringImage = AppImages().caterpillarTubeAndShell3;
              }
              return SizedBox(
                width: cardWidth,
                child: ProductFeatureCard(
                  title: feature.value.title,
                  description: feature.value.description,
                  label: feature.value.label,
                  imageHeight: isWide ? 350 : 190,
                  imageAssets:
                      stringImage, // Replace with actual image asset if available
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildTubeVariations(
    double horizontal,
    double contentWidth,
    bool isWide,
  ) {
    final columns = contentWidth >= 900
        ? 3
        : contentWidth >= 560
        ? 2
        : 1;
    final cardWidth = columns == 1
        ? contentWidth
        : (contentWidth - (24 * (columns - 1))) / columns;

    const variations = <String>[
      'RADMAX® Copper M-Tube',
      'RADMAX® Copper V-Tube',
      'RADMAX® Copper H-Tube',
      'RADMAX® Square Wave Fin Design',
      'RADMAX® Alumunium Tube Design',
      'RADMAX® Brass Tube Design',
    ];

    return Container(
      width: double.infinity,
      color: const Color(0xFFF6F8FB),
      padding: EdgeInsets.symmetric(
        horizontal: horizontal,
        vertical: isWide ? 64 : 40,
      ),
      child: Column(
        children: [
          const ProductSectionHeading(text: 'TUBE VARIATIONS'),
          const SizedBox(height: 32),
          Wrap(
            spacing: 24,
            runSpacing: 24,

            children: variations.asMap().entries.map((variation) {
              var stringImage = '';
              if (variation.key == 0) {
                stringImage = AppImages().removeableTubeRadiatorVariations1;
              } else if (variation.key == 1) {
                stringImage = AppImages().removeableTubeRadiatorVariations2;
              } else if (variation.key == 2) {
                stringImage = AppImages().removeableTubeRadiatorVariations3;
              } else if (variation.key == 3) {
                stringImage = AppImages().removeableTubeRadiatorVariations4;
              } else if (variation.key == 4) {
                stringImage = AppImages().removeableTubeRadiatorVariations5;
              } else if (variation.key == 5) {
                stringImage = AppImages().removeableTubeRadiatorVariations6;
              }
              return SizedBox(
                width: cardWidth,
                child: ProductLabeledCard(
                  title: variation.value,
                  description: _loremShort,
                  imageAssets: stringImage,
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildBundleRemovableOilCooler(
    double horizontal,
    double contentWidth,
    bool isWide,
  ) {
    return _CoolantSection(
      horizontal: horizontal,
      contentWidth: contentWidth,
      isWide: isWide,
      backgroundColor: const Color(0xFFF6F8FB),
      imageAsset: AppImages().caterpillarTubeAndShellRemovableBundleOilCooler,
      title: 'MAXLIFE REMOVABLE BUNDLE OIL COOLER',
      paragraphs: const [
        'MAXLIFE oil coolers feature a removable tube bundle design, making them 100% serviceable and repairable. The unit uses 100% copper-nickel tubes for superior strength, durability, and corrosion resistance.\n\nThe design uses mechanical expansion joints instead of rubber bonding, providing a stronger, more reliable seal unaffected by coolant quality and able to withstand extreme operating conditions. These joints also allow for thermal expansion and contraction, improving durability and extending service life.\n\nWith a floating bundle design, MAXLIFE coolers minimize failures caused by vibration and thermal stress. The bundle can be removed, cleaned, resealed, and reused, significantly reducing maintenance costs.\n\nAdditionally, MAXLIFE oil coolers CAN utilize original Caterpillar casings (reman concept), offering a cost-effective solution.',
      ],
    );
  }

  Widget _buildKeyFeaturesCustom(
    double horizontal,
    double contentWidth,
    bool isWide,
  ) {
    final columns = contentWidth >= 900
        ? 3
        : contentWidth >= 560
        ? 2
        : 1;
    final cardWidth = columns == 1
        ? contentWidth
        : (contentWidth - (24 * (columns - 1))) / columns;

    final features = <ProductFeatureData>[
      const ProductFeatureData(
        title: 'Integrated & Compact Design:',
        description:
            'Features a fixed tube bundle construction with copper or copper-nickel tubes permanently bonded to the tube sheet, providing a standardized configuration for baseline engine operations.',
        label: 'Removable Tube Image',
      ),
      const ProductFeatureData(
        title: 'Simplified Replacement Setup:',
        description:
            'Operates as a single sealed assembly, making initial installation straightforward without the need to manage individual internal service components or bundle alignments.',
        label: 'On-Site Repair Image',
      ),
      const ProductFeatureData(
        title: 'Standardized Operational Results:',
        description:
            'Built for heavy-duty machinery and extreme applications, its strong construction ensures high reliability where performance matters most. It offers better durability and long life-time.',
        label: 'Warranty Badge Image',
      ),
    ];

    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: EdgeInsets.symmetric(
        horizontal: horizontal,
        vertical: isWide ? 64 : 40,
      ),
      child: Column(
        children: [
          const ProductSectionHeading(text: 'KEY FEATURES & BENEFITS'),
          const SizedBox(height: 32),
          for (var start = 0; start < features.length; start += columns)
            Padding(
              padding: EdgeInsets.only(
                bottom: start + columns < features.length ? 24 : 0,
              ),
              child: IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    for (var i = 0; i < columns; i++) ...[
                      if (i > 0) const SizedBox(width: 24),
                      SizedBox(
                        width: cardWidth,
                        child: start + i < features.length
                            ? _buildKeyFeatureCard(
                                features[start + i],
                                start + i,
                                isWide,
                              )
                            : const SizedBox(),
                      ),
                    ],
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildKeyFeatureCard(
    ProductFeatureData feature,
    int index,
    bool isWide,
  ) {
    var stringImage = '';

    if (index == 0) {
      stringImage = AppImages().caterpillarTubeAndShellApplications1;
    } else if (index == 1) {
      stringImage = AppImages().caterpillarTubeAndShellApplications2;
    } else if (index == 2) {
      stringImage = AppImages().caterpillarTubeAndShellApplications3;
    }

    return ProductFeatureCard(
      title: feature.title,
      description: feature.description,
      label: feature.label,
      imageHeight: isWide ? 350 : 190,
      imageAssets: stringImage,
    );
  }

  Widget _buildBundleOilCooler(
    double horizontal,
    double contentWidth,
    bool isWide,
  ) {
    return _CoolantSection(
      horizontal: horizontal,
      contentWidth: contentWidth,
      isWide: isWide,
      backgroundColor: const Color(0xFFF6F8FB),
      imageAsset: AppImages().caterpillarTubeAndShellBundleOilCooler,
      title: 'FIX BUNDLE OIL COOLER',
      paragraphs: const [
        'A standard OEM tube & shell oil cooler features a fixed tube bundle construction, where the tubes are permanently bonded to the tube sheet using rubberized (vulcanized) joints. This design typically uses copper or copper-nickel tubes, depending on the model.\n\nThe fixed bundle configuration means the cooler is non-serviceable, as the tube bundle cannot be removed for cleaning or repair. Maintenance is therefore limited, and in cases of contamination or failure, full replacement of the unit is often required.\n\nThe rubber bonding used in the tube sheet joints is sensitive to coolant quality and operating conditions, which may lead to deterioration over time. This can result in reduced service life, potential leakage, and decreased cooling efficiency.\n\nOverall, the OEM tube & shell oil cooler is designed for standard operation but offers limited serviceability and shorter life cycle performance compared to removable bundle designs.',
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

class _CoolantSection extends StatelessWidget {
  final double horizontal;
  final double contentWidth;
  final bool isWide;
  final Color backgroundColor;
  final String imageAsset;
  final String title;
  final List<String> paragraphs;

  const _CoolantSection({
    required this.horizontal,
    required this.contentWidth,
    required this.isWide,
    required this.backgroundColor,
    required this.imageAsset,
    required this.title,
    required this.paragraphs,
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
      ],
    );
  }
}
