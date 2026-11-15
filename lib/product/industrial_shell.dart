import 'package:flutter/material.dart';
import 'package:project/global_widget/app_asset_image.dart';
import 'package:get/get.dart';
import 'package:project/controller/mainProductController.dart';
import 'package:project/global_widget/globalAppBar.dart';
import 'package:project/theme/app_images.dart';
import 'package:project/theme/string.dart';
import 'package:project/theme/theme.dart';
import 'package:project/product/product_widgets.dart';

class IndustrialShell extends StatelessWidget {
  const IndustrialShell({super.key});

  @override
  Widget build(BuildContext context) {
    return Globalappbar(pageWidget: const _IndustrialShell());
  }
}

class _IndustrialShell extends StatelessWidget {
  const _IndustrialShell();

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

            _buildDescription(horizontal, contentWidth, isWide),
            _buildKeyFeatures(horizontal, contentWidth, isWide),

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
                AppImages().industrialShellroductProduct,
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
                          'Industrial Shell & Tube Oil Cooler',
                          style: blackTextStyle.copyWith(
                            fontSize: titleSize,
                            fontWeight: bold,
                            height: 1.12,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'A shell and tube heat exchanger is a common industrial device used to transfer thermal energy between two fluids at different temperatures without mixing them. It consists of a large cylindrical shell containing a bundle of tubes; one fluid flows inside the tubes (tube-side) while the other flows outside, inside the shell (shell-side).',
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
                              AppString().industrialShellPdfUrl,
                              pdfName:
                                  'Industrial Shell & Tube Oil Cooler Brochure.pdf',
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
            'The Indocool Shell & Tube Heat Exchanger is a heavy-duty pressure vessel designed to deliver reliable thermal management across high-pressure and high-temperature industrial environments. Operating on a dual-circuit mechanism, one process fluid flows inside a bundle of parallel metal tubes (tube-side) while the second fluid circulates around the outer tube surfaces within a sealed cylindrical shell (shell-side).\n\nEngineered with precision components including a heavy-duty outer shell, high-surface-area tube bundle, perforated tube sheets, and flow-directing headers, the Indocool Shell & Tube Heat Exchanger effectively dissipates excess heat generated during heavy operations. By maintaining optimal unit temperatures, it prevents thermal stress and overheating, ensuring consistent application, peak efficiency, and extended service life for engines.',
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
            AppImages().industrialShellSubproduct,
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
        title: 'High Pressure and Temperature:',
        description:
            'Designed as a heavy-duty pressure vessel, the dual-circuit mechanism efficiently routes one process fluid through the internal tube bundle while the second fluid circulates around the sealed cylindrical shell.',
        label: 'Removable Tube Image',
      ),
      const ProductFeatureData(
        title: 'Peak Thermal Efficiency:',
        description:
            'Engineered with a high-surface-area tube bundle, perforated tube sheets, and flow-directing headers, the system effectively dissipates excess heat during heavy operations.',
        label: 'On-Site Repair Image',
      ),
      const ProductFeatureData(
        title: 'Extended Engine Service Life: ',
        description:
            'By consistently maintaining optimal unit temperatures during continuous heavy-duty cycles, the heat exchanger protects core engine components from thermal fatigue.',
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
                stringImage = AppImages().industrialShellKeyAndBenefits1;
              } else if (feature.key == 1) {
                stringImage = AppImages().industrialShellKeyAndBenefits2;
              } else if (feature.key == 2) {
                stringImage = AppImages().industrialShellKeyAndBenefits3;
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
      'CHEMICAL AND PETROCHEMICAL',
      'POWER GENERATION',
      'INDUSTRIAL MANUFACTURING',
      'MARINE AND ENGINES',
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
            'The Indocool Shell & Tube Heat Exchanger is engineered to support demanding thermal management across a wide array of heavy industrial sectors, including oil and petrochemical processing where it reliably cools process streams, hydraulic fluids, and lubricating oils. In power generation and marine applications, these robust pressure vessels act as critical lube oil coolers, steam condensers, feedwater heaters, and engine jacket water coolers.\n\nAdditionally, the exchanger provides dependable thermal regulation for general industrial manufacturing, chemical processing lines, and heavy-duty HVAC and refrigeration systems. By maintaining precise fluid temperatures under high-pressure conditions, it safeguards critical machinery and reduces maintenance downtime',
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
                stringImage = AppImages().platedApplications3;
              } else if (application.key == 1) {
                stringImage = AppImages().removeableTubeApplications3;
              } else if (application.key == 2) {
                stringImage = AppImages().industrialShellApplications3;
              } else if (application.key == 3) {
                stringImage = AppImages().industrialShellApplications4;
              }
              return SizedBox(
                width: cardWidth,
                child: ProductApplicationCard(
                  title: application.value,
                  imageHeight: isWide ? 190 : 180,
                  imageAssets: stringImage,
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
