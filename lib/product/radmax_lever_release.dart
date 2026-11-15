import 'package:flutter/material.dart';
import 'package:project/global_widget/app_asset_image.dart';
import 'package:get/get.dart';
import 'package:project/controller/mainProductController.dart';
import 'package:project/global_widget/globalAppBar.dart';
import 'package:project/theme/app_images.dart';
import 'package:project/theme/string.dart';
import 'package:project/theme/theme.dart';
import 'package:project/product/product_widgets.dart';

class RadmaxLeverRelease extends StatelessWidget {
  const RadmaxLeverRelease({super.key});

  @override
  Widget build(BuildContext context) {
    return Globalappbar(pageWidget: const _RadmaxLeverRelease());
  }
}

class _RadmaxLeverRelease extends StatelessWidget {
  const _RadmaxLeverRelease();

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
                AppImages().radmaxLevelReleaseroductProduct,
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
                          'RADMAX® Lever Release Safety Radiator Cap',
                          style: blackTextStyle.copyWith(
                            fontSize: titleSize,
                            fontWeight: bold,
                            height: 1.12,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'RADMAX® Lever Release Safety Radiator Cap is radiator cap featuring a metal lever designed to safely vent pressurized coolant vapors before the cap is removed. It allows you to release pressure into the overflow system, reducing the risk of scalding and preventing the danger of removing the cap while the engine is hot.',
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
                              AppString().radmaxLeverReleasePdfUrl,
                              pdfName:
                                  'Radmax Lever Release Safety Radiator Cap Brochure.pdf',
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
            ' Designed with an integrated metal lift-lever and a physical locking tab, the RADMAX® Safety Cap allows maintenance technicians and equipment operators to safely vent pressurized coolant steam into the overflow system before the cap can be unscrewed. By eliminating dangerous upward pressure eruptions, RADMAX® significantly mitigates the risk of scalding and severe steam burns during routine checks or emergency servicing.\n\nBeyond operator protection, the RADMAX® Safety Cap enhances overall engine efficiency through superior thermal sealing. Its precision seal minimizes coolant vaporization and fluid loss, extending coolant service life while reducing overall maintenance frequency and operational costs. Suitable for heavy machinery, mining fleets, and industrial engine radiators, it is not just a standard cap it is a critical safety investment for continuous, heavy-duty operations. ',
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
            AppImages().radmaxLevelReleaseSubproduct,
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
        title: 'Integrated Safety Release Lever:',
        description:
            'Lifting the metal lever opens an internal vent valve that safely routes trapped pressure and hot steam through the overflow tube before removal.',
        label: 'Removable Tube Image',
      ),
      const ProductFeatureData(
        title: 'Enhanced System Sealing:',
        description:
            'Delivers a tight pressure seal that reduces fluid evaporation, stabilizes operating temperatures, and extends coolant life.',
        label: 'On-Site Repair Image',
      ),
      const ProductFeatureData(
        title: 'Heavy-Duty Construction:',
        description:
            'Built with corrosion-resistant materials to withstand extreme vibrations, high operating pressures, and harsh working environments.',
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
                stringImage = AppImages().radmaxLevelReleaseKeyAndBenefits1;
              } else if (feature.key == 1) {
                stringImage = AppImages().radmaxLevelReleaseKeyAndBenefits2;
              } else if (feature.key == 2) {
                stringImage = AppImages().radmaxLevelReleaseKeyAndBenefits3;
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
      'MINI-AUTOMOTIVE CAP 40mm',
      'INDUSTRIAL CAP 55mm',
      'INDUSTRIAL CAP 70mm',
      'INDUSTRIAL CAP 100mm',
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
            'The RADMAX® Lever Release Safety Radiator Cap is engineered for high-pressure, heavy-duty cooling systems found in vehicles that operate under continuous heavy load and harsh conditions, where standard caps pose significant scalding risks. The lever-release allows immediate venting of pressurized steam, preventing dangerous eruptions.\n\nTypical fits include large diesel engines in construction equipment, multi-vehicle commercial fleets, and localized industrial operations with critical cooling. They are indispensable safety upgrades in sectors demanding both maximum uptime and enhanced operator-protection. It’s not just a small component of the radiator; it’s a safety feature that protects the operator from burns caused by hot steam or coolant.',
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
                stringImage = AppImages().radmaxLevelReleaseApplications1;
              } else if (application.key == 1) {
                stringImage = AppImages().radmaxLevelReleaseApplications2;
              } else if (application.key == 2) {
                stringImage = AppImages().radmaxLevelReleaseApplications3;
              } else if (application.key == 3) {
                stringImage = AppImages().radmaxLevelReleaseApplications4;
              }
              return SizedBox(
                width: cardWidth,
                child: ProductApplicationCard(
                  title: application.value,
                  imageHeight: isWide ? 280 : 180,
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
