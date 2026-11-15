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

class RadmaxRemovableTubeRadiator extends StatelessWidget {
  const RadmaxRemovableTubeRadiator({super.key});

  @override
  Widget build(BuildContext context) {
    return Globalappbar(pageWidget: const _RadmaxContent());
  }
}

class _RadmaxContent extends StatelessWidget {
  const _RadmaxContent();

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
            _buildKeyFeatures(horizontal, contentWidth, isWide),
            _buildTubeVariations(horizontal, contentWidth, isWide),
            _buildSpareParts(horizontal, contentWidth, isWide),
            _buildApplications(horizontal, contentWidth, isWide),
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
                AppImages().removeableTubeRadiatorProductProduct,
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
                          'RADMAX® Removable Tube Radiator',
                          style: blackTextStyle.copyWith(
                            fontSize: titleSize,
                            fontWeight: bold,
                            height: 1.12,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'A removable tube radiator (not MESABI®) is a type of radiator with individual cooling tubes that can be removed and replaced without disassembling the entire radiator. This makes them a good choice for applications where serviceability is important, such as in the mining, oil and gas, and power generation industries.',
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
                              AppString().removableTubeRadiatorPdfUrl,
                              pdfName:
                                  'Radmax Removable Tube Radiator Brochure.pdf',
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
        AppImages().removeableTubeRadiatorProductSubproduct,
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
            'RADMAX® Removable Tube Radiator (not MESABI®) is a type of radiator with individual cooling tubes that can be removed and replaced without disassembling the entire radiator like the conventional one. RADMAX is radiator that designed to minimize equipment downtime across several heavy industries, including mining, manufacturing, drilling, oil and gas, power generations, and geophysics operations. \n\nRADMAX® Removable Tube Radiator are consisting of a series of parallel tubes held in place by rubber seals. The tubes are not soldered together, which makes them easier to repair if a tube is damaged. The individual tubes in a removable tube radiator are typically made of copper or aluminum and are held in place by rubber seals. The tubes are not soldered together, which makes them easier to remove and replace.',
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
            AppImages().removeableTubeRadiatorProductDescription,
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
        title: 'Removable Tube Covering',
        description:
            'Features individual cooling tubes secured in headers using rubber seals rather than soldered seams, eliminating risks associated with seam cracking or leakage.',
        label: 'Removable Tube Image',
      ),
      const ProductFeatureData(
        title: 'Detailed On-Site Repair',
        description:
            'Damaged tubes can be removed and replaced individually without needing to disassemble the radiator from the equipment, allowing full restoration to original cooling capacity.',
        label: 'On-Site Repair Image',
      ),
      const ProductFeatureData(
        title: '24 Month Warranty',
        description:
            'Long-Term Value: Includes a 24-month warranty against seal leakage and provides a low total cost of ownership over time. We confident that our product can perform last long.',
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
                stringImage = AppImages().removeableTubeRadiatorKeyAndBenefits1;
              } else if (feature.key == 1) {
                stringImage = AppImages().removeableTubeRadiatorKeyAndBenefits2;
              } else if (feature.key == 2) {
                stringImage = AppImages().removeableTubeRadiatorKeyAndBenefits3;
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
          const SizedBox(height: 48),
          AppAssetImage(
            AppImages().removeableTubeRadiatorTables,
            width: contentWidth,
            fit: BoxFit.contain,
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

  Widget _buildSpareParts(double horizontal, double contentWidth, bool isWide) {
    final columns = contentWidth >= 900
        ? 3
        : contentWidth >= 560
        ? 2
        : 1;
    final cardWidth = columns == 1
        ? contentWidth
        : (contentWidth - (24 * (columns - 1))) / columns;

    const spareParts = <String>[
      '(1) Individual Removable Tube',
      '(2) Rubber Seal',
      '(3) Clip Tube',
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
          const ProductSectionHeading(text: 'SPARE PARTS'),
          const SizedBox(height: 24),
          Text(
            'The RADMAX® Removable Tube Radiator is highly suited for heavy industries because its core design completely changes how maintenance is handled in the field. By replacing a rigid, soldered core with individual tubes held by rubber seals, the design directly addresses the massive financial cost of equipment downtime.\n\nThe RADMAX® Removable Tube Radiator, its flexible rubber seals absorb heavy shock, vibration, and thermal expansion to prevent the metal fatigue and cracking common in traditional soldered joints. Additionally, because repairs require no welding or soldering, this design completely eliminates hazardous "hot work," improving workplace safety while drastically minimizing equipment downtime.',
            textAlign: isWide ? TextAlign.center : TextAlign.left,
            style: blackTextStyle.copyWith(
              fontWeight: FontWeight.w900,
              fontSize: isWide ? 15 : 13,
              height: 1.8,
            ),
          ),
          const SizedBox(height: 32),
          Wrap(
            spacing: 24,
            runSpacing: 24,
            children: spareParts.asMap().entries.map((part) {
              var stringImage = '';
              if (part.key == 0) {
                stringImage = AppImages().removeableTubeRadiatorSpareParts1;
              } else if (part.key == 1) {
                stringImage = AppImages().removeableTubeRadiatorSpareParts2;
              } else if (part.key == 2) {
                stringImage = AppImages().removeableTubeRadiatorSpareParts3;
              }
              return SizedBox(
                width: cardWidth,
                child: ProductLabeledCard(
                  title: part.value,
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

  Widget _buildApplications(
    double horizontal,
    double contentWidth,
    bool isWide,
  ) {
    final columns = contentWidth >= 900
        ? 4
        : contentWidth >= 560
        ? 2
        : 1;
    final cardWidth = columns == 1
        ? contentWidth
        : (contentWidth - (20 * (columns - 1))) / columns;

    const applications = <String>[
      'Offshore',
      'POWER GENERATION',
      'Industrial',
      'Marine',
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
          const ProductSectionHeading(text: 'APPLICATIONS'),
          const SizedBox(height: 24),
          Text(
            'The RADMAX® Removable Tube Radiator is highly suited for heavy industries because its core design completely changes how maintenance is handled in the field. By replacing a rigid, soldered core with individual tubes held by rubber seals, the design directly addresses the massive financial cost of equipment downtime.\n\nThe RADMAX® Removable Tube Radiator, its flexible rubber seals absorb heavy shock, vibration, and thermal expansion to prevent the metal fatigue and cracking common in traditional soldered joints. Additionally, because repairs require no welding or soldering, this design completely eliminates hazardous "hot work," improving workplace safety while drastically minimizing equipment downtime.',
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
                stringImage = AppImages().removeableTubeApplications1;
              } else if (application.key == 1) {
                stringImage = AppImages().removeableTubeApplications2;
              } else if (application.key == 2) {
                stringImage = AppImages().removeableTubeApplications3;
              } else if (application.key == 3) {
                stringImage = AppImages().removeableTubeApplications4;
              }
              return SizedBox(
                width: cardWidth,
                child: ProductApplicationCard(
                  title: application.value,
                  imageHeight: isWide ? 190 : 180,
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
}
