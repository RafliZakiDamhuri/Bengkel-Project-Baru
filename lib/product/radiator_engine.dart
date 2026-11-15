import 'package:flutter/material.dart';
import 'package:project/global_widget/app_asset_image.dart';
import 'package:get/get.dart';
import 'package:project/controller/mainProductController.dart';
import 'package:project/global_widget/globalAppBar.dart';
import 'package:project/theme/app_images.dart';
import 'package:project/theme/string.dart';
import 'package:project/theme/theme.dart';

class RadiatorEngine extends StatelessWidget {
  const RadiatorEngine({super.key});

  @override
  Widget build(BuildContext context) {
    return Globalappbar(pageWidget: const _RadiatorEngine());
  }
}

class _RadiatorEngine extends StatelessWidget {
  const _RadiatorEngine();

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

            _buildWaterBased(horizontal, contentWidth, isWide),
            _buildPropyleneGlycol(horizontal, contentWidth, isWide),
            _buildEthyleneGlycol(horizontal, contentWidth, isWide),
            _buildRadiatorFlushCooling(horizontal, contentWidth, isWide),

            _buildApplications(horizontal, contentWidth, isWide),
          ],
        );
      },
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
      'GENERAL INDUSTRY',
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
          const _SectionHeading(text: 'APPLICATIONS'),
          const SizedBox(height: 24),
          Text(
            'Tube & Fin radiator technology offers superior thermal efficiency and structural optimization compared to conventional cooling systems. Constructed with thin-walled channels attached to a central carrier plate, this design maximizes heat exchange surface area to enable rapid thermal absorption and dissipation. The rounded contour of the individual tubes ensures smooth, unrestricted coolant flow, eliminating the fluid drag and thermal bottlenecks often found in sharp-edged alternative designs.\n\nThese engineering advantages make Tube & Fin radiators particularly well-suited for demanding industrial applications across mining, oil and gas, power generation, and logistics.',
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
                stringImage = AppImages().radiatorEngineApplications3;
              } else if (application.key == 3) {
                stringImage = AppImages().heavyDutyCooperApplications4;
              }
              return SizedBox(
                width: cardWidth,
                child: _ApplicationCard(
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
                AppImages().radiatorEngineProduct,
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
                          'RADMAX® ',
                          style: blackTextStyle.copyWith(
                            fontSize: titleSize,
                            fontWeight: bold,
                            height: 1.12,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'RADMAX® Radiator Coolant are liquid coolant brand from Indocool. Produced and engineered in Indocool own blending facility with high quality material and OAT Inhibitor. Coolants that contain only organic additive technology (OAT) inhibitors that are virtually non-depleting, offering extended life corrosion protection benefits.',

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
                              AppString().radmaxRadiatorCoolantPdfUrl,
                              pdfName:
                                  'Radmax Radiator Engine Coolant Brochure.pdf',
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

  Widget _buildWaterBased(double horizontal, double contentWidth, bool isWide) {
    return _CoolantSection(
      horizontal: horizontal,
      contentWidth: contentWidth,
      isWide: isWide,
      backgroundColor: const Color(0xFFF6F8FB),
      imageAsset: AppImages().radiatorEngine1,
      title: 'RADMAX® RADIATOR ENGINE COOLANT ECO-FRIENDLY WATER-BASED',
      paragraphs: const [
        'Upgrade your cooling system with RADMAX Propylene Glycol Premix—the ready-to-use coolant engineered for extreme durability and superior heat transfer. Driven by cutting-edge Organic Additive Technology (OAT), this premium formula safeguards all cooling system metals corrosion.\nRADMAX offers up to 8 years of continuous, worry-free protection. Its biodegradable propylene glycol base makes it a safer, environmentally conscious choice without sacrificing an ounce of performance.',
      ],
      features: const [
        _FeatureData(
          title: 'Extended Service Life:',
          description:
              'Protects passenger cars and light commercial vehicles for up to 8 years or 250,000 km, and heavy-duty engines for up to 8 years, 1,250,000 km, or 24,000 hours.',
        ),
        _FeatureData(
          title: 'Enhanced Thermal Efficiency:',
          description:
              'Delivers up to 25–40% superior heat transfer compared to conventional glycol-based coolants.',
        ),
        _FeatureData(
          title: 'Broad OEM Compatibility:',
          description:
              'Suitable for a wide range of automotive, diesel, and natural gas OEM engines.',
        ),
        _FeatureData(
          title: 'Superior Engine Safety:',
          description:
              'Provides high-temperature corrosion protection and is completely non-flammable.',
        ),
        _FeatureData(
          title: 'Eco-Conscious Formula:',
          description:
              'Carbon neutral, readily biodegradable, and free from nitrites, amines, phosphates, silicates (NAPS), borates, and heavy metals.',
        ),
        _FeatureData(
          title: 'Cost-Effective Maintenance:',
          description:
              'Extended fluid life lowers waste treatment costs and reduces maintenance downtime.',
        ),
      ],
    );
  }

  Widget _buildPropyleneGlycol(
    double horizontal,
    double contentWidth,
    bool isWide,
  ) {
    return _CoolantSection(
      horizontal: horizontal,
      contentWidth: contentWidth,
      isWide: isWide,
      backgroundColor: Colors.white,
      imageAsset: AppImages().radiatorEngine2,

      title: 'RADMAX® RADIATOR ENGINE COOLANT PROPYLENE GLYCOL',
      paragraphs: const [
        'Upgrade your cooling system with RADMAX Propylene Glycol Premix—the ready-to-use coolant engineered for extreme durability and superior heat transfer. Driven by cutting-edge Organic Additive Technology (OAT), this premium formula safeguards all cooling system metals against severe high-temperature corrosion.\nWhether running light commercial vehicles or heavy-duty fleets, RADMAX offers up to 8 years of continuous, worry-free protection. Its biodegradable propylene glycol base makes it a safer, environmentally conscious choice without sacrificing an ounce of performance.',
      ],
      features: const [
        _FeatureData(
          title: 'Ready-to-Use Convenience:',
          description:
              ' Pre-mixed formula allows for immediate, hassle-free top-ups and complete flushes.',
        ),
        _FeatureData(
          title: 'Extra Long Service Life: ',
          description:
              'Protects passenger cars and light commercial vehicles for up to 8 years or 250,000 km, and heavy-duty engines for up to 8 years, 1,250,000 km, or 24,000 hours.',
        ),
        _FeatureData(
          title: 'Superior Heat Transfer:',
          description:
              'Optimized propylene glycol formulation ensures rapid heat dissipation under extreme engine loads.',
        ),
        _FeatureData(
          title: 'Complete Metal Protection:',
          description:
              ' Advanced OAT corrosion inhibitors provide all-metal safety, protecting aluminum, copper, brass, cast iron, and steel components.',
        ),
        _FeatureData(
          title: 'Eco-Friendly Formula:',
          description:
              'Formulated with propylene glycol for enhanced environmental safety and rapid biodegradability compared to conventional coolants.',
        ),
      ],
    );
  }

  Widget _buildEthyleneGlycol(
    double horizontal,
    double contentWidth,
    bool isWide,
  ) {
    return _CoolantSection(
      horizontal: horizontal,
      contentWidth: contentWidth,
      isWide: isWide,
      backgroundColor: const Color(0xFFF6F8FB),
      imageAsset: AppImages().radiatorEngine3,

      title: 'RADMAX® RADIATOR ENGINE COOLANT ETHYLENE GLYCOL',
      paragraphs: const [
        'Conquer extreme cold and heavy engine loads with RADMAX PG-30 Premix. Powered by advanced Organic Additive Technology (OAT) in a ready-to-use ethylene glycol formulation, this premium antifreeze and coolant keeps engines running safely in sub-zero climates while providing maximum thermal dissipation.\n\nDesigned to protect every metal in your cooling system against corrosion, RADMAX PG-30 offers up to 8 years of extended protection for daily passenger vehicles and heavy-duty commercial fleets alike.',
      ],
      features: const [
        _FeatureData(
          title: 'Sub-Zero Climate Performance:',
          description:
              'Highly recommended for freezing conditions, acting as an effective antifreeze to prevent engine freeze-up.',
        ),
        _FeatureData(
          title: 'Ready-to-Use Formula:',
          description:
              'Pre-mixed and ready to pour for quick, convenient maintenance and complete flushes.',
        ),
        _FeatureData(
          title: 'Extra Long Service Life:',
          description:
              'Protects passenger cars and light commercial vehicles for up to 8 years or 250,000 km, and heavy-duty engines for up to 8 years, 1,250,000 km, or 24,000 hours.',
        ),
        _FeatureData(
          title: 'Superior Thermal Efficiency: ',
          description:
              'Ethylene glycol base coupled with OAT technology ensures efficient heat dissipation under severe operating conditions.',
        ),
        _FeatureData(
          title: 'All-Metal Compatibillity:',
          description:
              'Safe for all metals in the cooling system, preventing high-temperature corrosion and rust.',
        ),
      ],
    );
  }

  Widget _buildRadiatorFlushCooling(
    double horizontal,
    double contentWidth,
    bool isWide,
  ) {
    return _CoolantSection(
      horizontal: horizontal,
      contentWidth: contentWidth,
      isWide: isWide,
      backgroundColor: const Color(0xFFF6F8FB),
      imageAsset: AppImages().radiatorEngine4,

      title: 'RADMAX® RADIATOR FLUSH COOLING SYSTEM CLEANER',
      paragraphs: const [
        'RADMAX Radiator Flush Premix is a heavy-duty, water-based cooling system cleanser engineered for fast, efficient maintenance without costly vehicle downtime. Formulated with a synergistic mixture of high-efficiency organic inhibitors and surfactants, this ready-to-use cleaner aggressively breaks down and flushes away oil, grease, sludge, rust, and stubborn mineral scale build-up. While deep cleaning internal cooling passages, it simultaneously safeguards critical metals against high-temperature corrosion and cavitation pitting.',
      ],
      features: const [
        _FeatureData(
          title: 'Comprehensive Contaminant Removal:',
          description:
              'Highly effective against oil, grease, sludge, rust, and mineral scale to restore full coolant circulation.',
        ),
        _FeatureData(
          title: 'Ready-to-Use Water-Based Formula:',
          description:
              'Pre-mixed formula allows for immediate, direct application with no extra dilution or mixing required.',
        ),
        _FeatureData(
          title: 'Universal Component & Material Safety:',
          description:
              'Safe and fully compatible with all cooling system materials, including aluminum, carbon steel, and copper.',
        ),
        _FeatureData(
          title: 'Universal Coolant Compatibility:',
          description:
              'Compatible with all types of engine coolants (OAT, HOAT, conventional glycol, and water-based formulas).',
        ),
        _FeatureData(
          title: 'Cavitation & Corrosion Protection:',
          description:
              'Active organic inhibitors provide simultaneous protection against ongoing metal oxidation and destructive cavitation during the cleaning process.',
        ),
        _FeatureData(
          title: 'Preventative Maintenance Solution:',
          description:
              'Ideal for routine, periodic maintenance in petrol and diesel engines across passenger, commercial, and heavy-duty fleets to prevent unexpected downtime.',
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
