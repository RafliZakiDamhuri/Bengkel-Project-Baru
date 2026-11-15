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

class HeavyDutyCooler extends StatelessWidget {
  const HeavyDutyCooler({super.key});

  @override
  Widget build(BuildContext context) {
    return Globalappbar(pageWidget: const _HeavyDutyCooler());
  }
}

class _HeavyDutyCooler extends StatelessWidget {
  const _HeavyDutyCooler();

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
                AppImages().heavyDutyRadiatorProductProduct,
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
                          'Heavy-Duty Cooler Core Alumunium Plate & Bar',
                          style: blackTextStyle.copyWith(
                            fontSize: titleSize,
                            fontWeight: bold,
                            height: 1.12,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'The Aluminum Plate & Bar cooler is built for heavy-duty reliability. Designed to withstand the toughest conditions, it ensures optimal temperature control for your operations, Aluminum plate and bar can be applied in various cooling systems, such as radiators, charge air coolers, oil coolers, hydraulic oil coolers, and intercoolers.',
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
                              AppString().heavyDutyCoolerPdfUrl,
                              pdfName:
                                  'Heavy-Duty Cooler Core Alumunium Plate & Bar Brochure.pdf',
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
        AppImages().heavyDutyRadiatorProductSubproduct,
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
            'The Aluminum Plate & Bar cooler is built for heavy-duty efficiency and reliability. Designed to withstand the toughest conditions, it ensures optimal temperature control for your operations, delivering consistent performance in mining, construction, and industrial environments.\n\nFin geometries can be customized as per operation requirements to optimize heat transfer with minimal pressure drop in your operating conditions. Aluminium Plate & Bar also offers ambient air fin geometries that minimize dirt build-up and simplify cleaning in harsh operating conditions. Aluminum plate and bar can be applied in various cooling systems, such as radiators, charge air coolers, hydraulic oil coolers, intercoolers, and aftercoolers.',
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
            AppImages().heavyDutyRadiatorProductDescription,
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
        title: 'High-Pressure Capability:',
        description:
            'Because the pieces are permanently brazed instead of mechanically joined, they resist high operating pressures designed to 35 bar with test pressure to 35 bar and heavy vibrations.',
        label: 'Removable Tube Image',
      ),
      const ProductFeatureData(
        title: 'Durable for Harsh Environments:',
        description:
            'In sectors like mining and demanding industry, heavy-duty unit faces extreme conditions. Our Aluminum Plate & Bar is built to withstand pressure, high strain, and harsh environments.',
        label: 'On-Site Repair Image',
      ),
      const ProductFeatureData(
        title: 'Superior Heat Transfer:',
        description:
            'Crafted entirely of aluminum for optimal thermal efficiency, our composite matrix features a modular design customizable for engine coolants, oils, and high-pressure gases.',
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
                stringImage = AppImages().heavyDutyRadiatorKeyAndBenefits1;
              } else if (feature.key == 1) {
                stringImage = AppImages().heavyDutyRadiatorKeyAndBenefits2;
              } else if (feature.key == 2) {
                stringImage = AppImages().heavyDutyRadiatorKeyAndBenefits3;
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
      'MINING INDUSTRY',
      'POWER GENERATION',
      'OIL AND GAS INDUSTRY',
      'TRANSPORTATION & LOGISTIC',
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
            'Engineered to overcome the limitations of standard heat exchangers, our Aluminum Plate & Bar Coolers thrive in the most demanding operational environments. Designed specifically for high-vibration applications, extreme internal pressures, and heavily airborne dusty job sites.\n\nFeaturing customizable, clogging-resistant fin geometries, the coolers facilitate optimal airflow and prevent dust accumulation, making routine cleaning fast and effortless. This combination of high heat dissipation and low-maintenance reliability minimizes unplanned equipment downtime and extends service life across heavy-duty mining, power generation, and oil & gas operations worldwide.',
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
                stringImage = AppImages().removeableTubeApplications3;
              } else if (application.key == 2) {
                stringImage = AppImages().heavyDutyRadiatorApplications3;
              } else if (application.key == 3) {
                stringImage = AppImages().heavyDutyRadiatorApplications4;
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
