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

class LightDutyRadiatorCore extends StatelessWidget {
  const LightDutyRadiatorCore({super.key});

  @override
  Widget build(BuildContext context) {
    return Globalappbar(pageWidget: const _LightDutyContent());
  }
}

class _LightDutyContent extends StatelessWidget {
  const _LightDutyContent();

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
                AppImages().lightDutyRadiatorProductProduct,
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
                          'Light-Duty Radiator Core Alumunium Tube & Fin',
                          style: blackTextStyle.copyWith(
                            fontSize: titleSize,
                            fontWeight: bold,
                            height: 1.12,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Alumunium tube & fin radiators are the most common type of radiator. They are made up of a series of tubes that are connected to a header at each end. The tubes are filled with a coolant, such as water or antifreeze, which absorbs heat from the engine. The coolant then flows through the radiator, where it is cooled by the airflow.',
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
                              AppString().lightDutyRadiatorPdfUrl,
                              pdfName:
                                  'Light-Duty Radiator Core Alumunium Tube & Fin Brochure.pdf',
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
        AppImages().lightDutyRadiatorProductSubproduct,
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
            'Light-Duty Alumunium Tube & Fin or known as conventional radiators are the most common type of radiator. They are made up of a series of tubes that are connected to a header at each end. The tubes are filled with a coolant, which absorbs heat from the engine. The coolant then flows through the radiator, where it is cooled by the airflow. One of the most remarkable benefits of Tube & Fin nets lies in their exceptional heat exchange capabilities.\n\nLight-Duty Radiator Core Alumunium Tube & Fin for industrial use is robust and designed to withstand harsh environments to ensure efficient heat transfer under high-temperature conditions. In industrial settings, conventional radiators play a vital role in providing efficient heating solutions. These radiators are commonly used in various industries, including mining, drilling, and offshore operations.',
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
            AppImages().lightDutyRadiatorProductDescription,
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
        title: 'Rapid Temperature Response:',
        description:
            'Tube & Fin nets swiftly absorb and dissipate heat. This feature makes them ideal for applications with ever-changing load conditions, particularly in the automotive/moving unit sector.',
        label: 'Removable Tube Image',
      ),
      const ProductFeatureData(
        title: 'Weight Efficiency:',
        description:
            'Compared to Bar & Plate nets of the same size, Tube & Fin nets weigh approximately 30% less. This weight reduction contributes to enhanced efficiency and overall performance.',
        label: 'On-Site Repair Image',
      ),
      const ProductFeatureData(
        title: 'Optimized Medium Flow:',
        description:
            'The rounded tubes in Tube & Fin nets facilitate optimal medium flow diversion. This design ensures efficient heat exchange by eliminating the constraints posed by hard edges.',
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
                stringImage = AppImages().lightDutyRadiatorKeyAndBenefits1;
              } else if (feature.key == 1) {
                stringImage = AppImages().lightDutyRadiatorKeyAndBenefits2;
              } else if (feature.key == 2) {
                stringImage = AppImages().lightDutyRadiatorKeyAndBenefits3;
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
      'MINING INDUSTRY',
      'POWER GENERATION',
      'AGRICULTURAL EQUIPMENT',
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
            'Tube & Fin radiator technology offers superior thermal efficiency and structural optimization compared to conventional cooling systems. Constructed with thin-walled channels attached to a central carrier plate, this design maximizes heat exchange surface area to enable rapid thermal absorption and dissipation. The rounded contour of the individual tubes ensures smooth, unrestricted coolant flow, eliminating the fluid drag and thermal bottlenecks often found in sharp-edged alternative designs.\n\nThese engineering advantages make Tube & Fin radiators particularly well-suited for demanding industrial applications across mining, power generation, agricultural equipment, and logistics.',
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
                stringImage = AppImages().lightDutyRadiatorApplications3;
              } else if (application.key == 3) {
                stringImage = AppImages().lightDutyRadiatorApplications4;
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
