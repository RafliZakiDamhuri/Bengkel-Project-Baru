import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/controller/globalController.dart';

import 'package:project/global_widget/baseLayoutWrapper.dart';
import 'package:project/routes/routes_name.dart';
import 'package:project/theme/app_images.dart';
import 'package:project/theme/string.dart';
import 'package:project/theme/theme.dart';

Widget footer() {
  GlobalController globalController = Get.find<GlobalController>();

  // ============================================================
  // SOCIAL MEDIA
  // ============================================================
  Widget socialMedia() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {
            globalController.openUrl(AppString().facebook);
          },
          child: Container(
            width: 22,
            height: 22,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppImages().facebookNewLogo),
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),

        InkWell(
          onTap: () {
            globalController.openUrl(AppString().instagram);
          },
          child: Container(
            width: 22,
            height: 22,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppImages().instagramNewLogo),
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),

        InkWell(
          onTap: () {
            globalController.openUrl(AppString().linkedInUrl);
          },
          child: Container(
            width: 22,
            height: 22,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppImages().linkedInNewLogo),
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),

        InkWell(
          onTap: () {
            globalController.openUrl(AppString().tiktok);
          },
          child: Container(
            width: 22,
            height: 22,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppImages().tiktokNewLogo),
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),

        InkWell(
          onTap: () {
            globalController.openUrl(AppString().youtube);
          },
          child: Container(
            width: 22,
            height: 22,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppImages().youtubeNewLogo),
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ============================================================
  // MENU TEXT
  // ============================================================
  Widget menuText(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        text,
        style: whiteTextStyle.copyWith(fontWeight: medium, fontSize: 13),
      ),
    );
  }

  Widget menuTitle(String text) {
    return Text(
      text,
      style: whiteTextStyle.copyWith(fontSize: 15, fontWeight: bold),
    );
  }

  // ============================================================
  // PRODUCTS
  // ============================================================
  Widget products() {
    return SizedBox(
      width: 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              Get.toNamed(AppRouteName.product);
            },
            child: menuTitle('Products'),
          ),
          const SizedBox(height: 16),

          InkWell(
            onTap: () {
              Get.toNamed(AppRouteName.product);
            },
            child: menuText('Removable Tube Radiator'),
          ),
          InkWell(
            onTap: () {
              Get.toNamed(AppRouteName.product);
            },
            child: menuText('Alumunium Tube & Fin Core'),
          ),
          InkWell(
            onTap: () {
              Get.toNamed(AppRouteName.product);
            },
            child: menuText('Alumunium Plate & Bar Core'),
          ),
          InkWell(
            onTap: () {
              Get.toNamed(AppRouteName.product);
            },
            child: menuText('Copper Brass Core'),
          ),
          InkWell(
            onTap: () {
              Get.toNamed(AppRouteName.product);
            },
            child: menuText('CAT® Core Replacement'),
          ),
          InkWell(
            onTap: () {
              Get.toNamed(AppRouteName.product);
            },
            child: menuText('Tube & Shell Oil Cooler'),
          ),
          InkWell(
            onTap: () {
              Get.toNamed(AppRouteName.product);
            },
            child: menuText('Radiator Coolant'),
          ),
          InkWell(
            onTap: () {
              Get.toNamed(AppRouteName.product);
            },
            child: menuText('Air Cooled Heat Exchanger'),
          ),
          InkWell(
            onTap: () {
              Get.toNamed(AppRouteName.product);
            },
            child: menuText('Plate Heat Exchanger'),
          ),
          InkWell(
            onTap: () {
              Get.toNamed(AppRouteName.product);
            },
            child: menuText('Industrial Oil Cooler'),
          ),
          InkWell(
            onTap: () {
              Get.toNamed(AppRouteName.product);
            },
            child: menuText('Safety Radiator Cap'),
          ),
          InkWell(
            onTap: () {
              Get.toNamed(AppRouteName.product);
            },
            child: menuText('Replacement Fan'),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // SERVICES
  // ============================================================
  Widget services() {
    return SizedBox(
      width: 165,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              Get.toNamed(AppRouteName.services);
            },
            child: menuTitle('Services'),
          ),
          const SizedBox(height: 16),

          InkWell(
            onTap: () {
              Get.toNamed(AppRouteName.services);
            },
            child: menuText('Minor Repair'),
          ),
          InkWell(
            onTap: () {
              Get.toNamed(AppRouteName.services);
            },
            child: menuText('Major Repair'),
          ),
          InkWell(
            onTap: () {
              Get.toNamed(AppRouteName.services);
            },
            child: menuText('General Overhaul'),
          ),

          const SizedBox(height: 14),

          menuTitle('Catalogue'),

          const SizedBox(height: 16),

          InkWell(
            onTap: () {
              Get.toNamed(
                '${AppRouteName.searchProduct}?flow=${AppString().radiatorAndCoolers}',
              );
            },
            child: menuText('Radiators and Coolers'),
          ),
          InkWell(
            onTap: () {
              Get.toNamed(
                '${AppRouteName.searchProduct}?flow=${AppString().caterpillarRadiatorCore}',
              );
            },
            child: menuText('CAT® Radiator Core'),
          ),
          InkWell(
            onTap: () {
              Get.toNamed(
                '${AppRouteName.searchProduct}?flow=${AppString().caterpilarTube}',
              );
            },
            child: menuText('CAT® Tube and Shell'),
          ),
          InkWell(
            onTap: () {
              Get.toNamed(
                '${AppRouteName.searchProduct}?flow=${AppString().radiatorCapAndAdapters}',
              );
            },
            child: menuText('Radiator Cap and Adapter'),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // INQUIRY / INSIGHT
  // ============================================================
  Widget aboutUs() {
    return SizedBox(
      width: 150,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              Get.toNamed(AppRouteName.aboutUs);
            },
            child: InkWell(
              onTap: () {
                Get.toNamed(AppRouteName.aboutUs);
              },
              child: menuTitle('Inquiry'),
            ),
          ),
          const SizedBox(height: 16),

          InkWell(
            onTap: () {
              Get.toNamed(AppRouteName.contactPage);
            },
            child: menuText('Contact Us'),
          ),
          InkWell(
            onTap: () {
              Get.toNamed(AppRouteName.aboutUs);
            },
            child: menuText('About Us'),
          ),

          const SizedBox(height: 14),

          InkWell(
            onTap: () {
              Get.toNamed(AppRouteName.blogList);
            },
            child: menuTitle('Insight'),
          ),

          const SizedBox(height: 16),

          InkWell(
            onTap: () {
              Get.toNamed(AppRouteName.blogList);
            },
            child: menuText('Product Insight'),
          ),
          InkWell(
            onTap: () {
              Get.toNamed(AppRouteName.blogList);
            },
            child: menuText('Company News'),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // GALLERY / RESOURCES
  // ============================================================
  Widget contactUs() {
    return SizedBox(
      width: 120,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              Get.toNamed(AppRouteName.contactUs);
            },
            child: menuTitle('Gallery'),
          ),
          const SizedBox(height: 16),

          InkWell(
            onTap: () {
              Get.toNamed(AppRouteName.gallery);
            },
            child: menuText('Gallery'),
          ),

          const SizedBox(height: 14),

          InkWell(
            onTap: () {
              Get.toNamed(AppRouteName.resources);
            },
            child: menuTitle('Resources'),
          ),

          const SizedBox(height: 16),

          InkWell(
            onTap: () {
              Get.toNamed(AppRouteName.careers);
            },
            child: menuText('Careers'),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // PART NUMBER SEARCH
  // ============================================================
  Widget partNumberSearch() {
    return Container(
      width: 220,
      height: 48,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/Rectangle 48_result.webp'),
          fit: BoxFit.fill,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'PART NUMBER SEARCH',
            style: whiteTextStyle.copyWith(fontSize: 11, fontWeight: bold),
          ),
          const SizedBox(width: 8),

          Container(
            width: 18,
            height: 18,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/Logo-SHop 1_result.webp'),
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // FOOTER LEFT
  // ============================================================
  Widget footerLeft() {
    return SizedBox(
      width: 340,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 310,
            height: 42,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppImages().imageFooter),
                fit: BoxFit.contain,
                alignment: Alignment.centerLeft,
              ),
            ),
          ),

          const SizedBox(height: 12),

          Text(
            'PT. Indocool Solusi Cemerlang',
            style: whiteTextStyle.copyWith(fontSize: 14, fontWeight: bold),
          ),

          const SizedBox(height: 10),

          Text(
            'Head Office: Jakarta, Indonesia\n'
            'Branch Balikpapan: Balikpapan, Kalimantan Timur, Indonesia\n'
            'Branch Sangatta: Kutai Timur, Kalimantan Timur, Indonesia',
            style: whiteTextStyle.copyWith(
              fontSize: 11,
              fontWeight: regular,
              height: 1.45,
            ),
          ),

          const SizedBox(height: 18),

          Text(
            'PT. Indocool Rekayasa Batam',
            style: whiteTextStyle.copyWith(fontSize: 14, fontWeight: bold),
          ),

          const SizedBox(height: 10),

          Text(
            'Batam Head Office: Batam, Kepulauan Riau, Indonesia',
            style: whiteTextStyle.copyWith(fontSize: 11, fontWeight: regular),
          ),

          const SizedBox(height: 18),

          Row(
            children: [
              Container(
                width: 17,
                height: 17,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      'assets/images/Logo-WhatsApp 1_result.webp',
                    ),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(width: 8),

              Text(
                '+62 812-1000-256',
                style: whiteTextStyle.copyWith(
                  fontWeight: medium,
                  fontSize: 11,
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          Row(
            children: [
              Container(
                width: 17,
                height: 17,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      'assets/images/Logo-Email-2 1_result.webp',
                    ),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(width: 8),

              Text(
                'customersupport@indocool.co.id',
                style: whiteTextStyle.copyWith(
                  fontWeight: medium,
                  fontSize: 11,
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          Container(
            width: 310,
            height: 32,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/Logo-ISO 1_result.webp'),
                fit: BoxFit.contain,
                alignment: Alignment.centerLeft,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // FOOTER MENU
  // ============================================================
  Widget footerMenu() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        products(),
        const SizedBox(width: 35),
        services(),
        const SizedBox(width: 35),
        aboutUs(),
        const SizedBox(width: 35),
        contactUs(),
      ],
    );
  }

  // ============================================================
  // FOOTER BOTTOM
  // ============================================================
  Widget footerBottom() {
    return Padding(
      padding: const EdgeInsets.only(top: 22, bottom: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "All manufacturer's names, symbols, part numbers, or descriptions, "
            'are used for reference purpose only.\n'
            'It is not our intent to imply that any part mentioned is the product of OEM.',
            style: whiteTextStyle.copyWith(
              fontSize: 10,
              fontWeight: regular,
              height: 1.45,
            ),
          ),

          Text(
            'Copyright © 2026 PT. INDOCOOL SOLUSI CEMERLANG | All Right Reserved',
            style: whiteTextStyle.copyWith(fontSize: 10, fontWeight: bold),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // FOOTER DESKTOP
  // ============================================================
  Widget footerDesktop() {
    return Container(
      width: double.infinity,
      color: Colors.black,
      child: Padding(
        // MENTOK KE KIRI TAPI TIDAK TERLALU MEPET
        padding: const EdgeInsets.only(left: 45, right: 35, top: 35),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LayoutBuilder(
              builder: (context, constraints) {
                final isSmallDesktop = constraints.maxWidth < 1350;

                if (isSmallDesktop) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Wrap(
                        spacing: 45,
                        runSpacing: 35,
                        crossAxisAlignment: WrapCrossAlignment.start,
                        children: [footerLeft(), footerMenu()],
                      ),

                      const SizedBox(height: 30),

                      Row(
                        children: [
                          partNumberSearch(),
                          const SizedBox(width: 40),
                          socialMedia(),
                        ],
                      ),
                    ],
                  );
                }

                return SizedBox(
                  width: double.infinity,
                  child: Stack(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          footerLeft(),
                          const SizedBox(width: 50),
                          footerMenu(),
                        ],
                      ),

                      // SOCIAL MEDIA TETAP DI KANAN
                      Positioned(right: 0, bottom: 0, child: socialMedia()),
                    ],
                  ),
                );
              },
            ),

            const SizedBox(height: 28),

            Container(
              width: double.infinity,
              height: 1,
              color: Colors.white.withOpacity(0.6),
            ),

            footerBottom(),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // FOOTER MOBILE
  // ============================================================
  Widget footerMobile() {
    return Container(
      width: double.infinity,
      color: Colors.black,
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          footerLeft(),

          const SizedBox(height: 35),

          products(),

          const SizedBox(height: 30),

          services(),

          const SizedBox(height: 30),

          aboutUs(),

          const SizedBox(height: 30),

          contactUs(),

          const SizedBox(height: 35),

          partNumberSearch(),

          const SizedBox(height: 30),

          socialMedia(),

          const SizedBox(height: 30),

          Container(
            width: double.infinity,
            height: 1,
            color: Colors.white.withOpacity(0.6),
          ),

          const SizedBox(height: 20),

          Text(
            "All manufacturer's names, symbols, part numbers, or descriptions, "
            'are used for reference purpose only.\n'
            'It is not our intent to imply that any part mentioned is the product of OEM.',
            style: whiteTextStyle.copyWith(
              fontSize: 10,
              fontWeight: regular,
              height: 1.5,
            ),
          ),

          const SizedBox(height: 20),

          Text(
            'Copyright © 2026 PT. INDOCOOL SOLUSI CEMERLANG | All Right Reserved',
            style: whiteTextStyle.copyWith(fontSize: 10, fontWeight: bold),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // RESPONSIVE LAYOUT
  // ============================================================
  return ResponsiveLayout(mobile: footerMobile(), desktop: footerDesktop());
}
