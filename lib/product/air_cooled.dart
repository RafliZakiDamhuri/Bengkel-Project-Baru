import 'package:flutter/material.dart';
import 'package:project/global_widget/app_asset_image.dart';
import 'package:get/get.dart';
import 'package:project/controller/mainProductController.dart';
import 'package:project/global_widget/globalAppBar.dart';
import 'package:project/theme/app_images.dart';
import 'package:project/theme/string.dart';
import 'package:project/theme/theme.dart';
import 'package:project/product/product_widgets.dart';

class AirCooled extends StatelessWidget {
  const AirCooled({super.key});

  @override
  Widget build(BuildContext context) {
    return Globalappbar(pageWidget: const _AirCooled());
  }
}

class _AirCooled extends StatelessWidget {
  const _AirCooled();

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
                AppImages().airCooledProductProduct,
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
                          'Air Cooled Heat Exchanger',
                          style: blackTextStyle.copyWith(
                            fontSize: titleSize,
                            fontWeight: bold,
                            height: 1.12,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Air Cooled Heat Exchanger (ACHE) is a heat rejection equipment where the excess process heat is rejected to the atmosphere. It works on the principle of convection and conduction to dissipate heat from process fluid to air. ',
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
                              AppString().airCooledPdfUrl,
                              pdfName:
                                  'Air Cooled Heat Exchanger Brochure.pdf',
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
            'Engineered for industrial-grade thermal management, Indocool Air Cooled Heat Exchanger (ACHE) provides efficient heat rejection for demanding process environments. Designed to transfer excess heat directly from process fluids into ambient air, it operates on principles of convection and conduction without requiring cooling water, making it a reliable, eco-efficient solution for continuous heavy-duty operations.\n\nAir Cooled Heat Exchanger (ACHE) is a heat rejection equipment where the excess process heat is rejected to the atmosphere. It works on the principle of convection and conduction to dissipate heat from process fluid to air. Designed for continuous duty in heavy industrial plants, power stations, and processing facilities. RADMAX offers maximum cooling efficiency, low operational costs, and dependable performance backed by Indocool Group.',
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
            AppImages().airCooledProductSubproduct,
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
        title: 'Water-Free Eco-Efficiency:',
        description:
            'Dissipates process heat directly into ambient air through convection and conduction without needing cooling water, eliminating water consumption costs and scaling risks.',
        label: 'Removable Tube Image',
      ),
      const ProductFeatureData(
        title: 'Built for Continuous Heavy Duty:',
        description:
            'Engineered for continuous-duty operation across heavy industrial plants, power stations, and processing facilities under demanding environmental loads',
        label: 'On-Site Repair Image',
      ),
      const ProductFeatureData(
        title: 'Low Operational Overhead: ',
        description:
            'Delivers efficient heat rejection with lower operating costs and reliable performance, backed by the industrial manufacturing standards of Indocool Group and RADMAX.',
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
                stringImage = AppImages().airCooledKeyAndBenefits1;
              } else if (feature.key == 1) {
                stringImage = AppImages().airCooledKeyAndBenefits2;
              } else if (feature.key == 2) {
                stringImage = AppImages().airCooledKeyAndBenefits3;
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
      'MINERAL PROCESSING',
      'POWER PLANT',
      'OIL AND GAS INDUSTRY',
      'PETROCHEMICAL INDUSTRY',
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
            'An Air Cooled Heat Exchanger (ACHE) is engineered for continuous, high-performance thermal management in heavy-duty industrial operations where water availability is restricted, environmentally regulated, or costly. By transferring excess heat directly from process fluids into ambient air through convection and conduction, the Indocool ACHE delivers maximum heat rejection efficiency without relying on external cooling water systems.\n\nWhenever water scarcity, environmental sustainability, high continuous uptime, and reduced maintenance costs are driving factors, the Indocool Air Cooled Heat Exchanger (ACHE) provides the ideal industrial-grade cooling architecture for severe-duty installations.',
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
                stringImage = AppImages().airCooledApplications1;
              } else if (application.key == 1) {
                stringImage = AppImages().removeableTubeApplications3;
              } else if (application.key == 2) {
                stringImage = AppImages().airCooledApplications3;
              } else if (application.key == 3) {
                stringImage = AppImages().airCooledApplications4;
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
