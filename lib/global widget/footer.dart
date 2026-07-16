import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';
import 'package:project/controller/globalController.dart';
import 'package:project/global%20widget/baseLayoutWrapper.dart';
import 'package:project/product_page.dart';
import 'package:project/routes/routes_name.dart';
import 'package:project/theme/app_images.dart';
import 'package:project/theme/string.dart';
import 'package:project/theme/theme.dart';
import 'package:sizer/sizer.dart';

Widget footer() {
  GlobalController globalController = Get.find<GlobalController>();
  Widget socialMedia() {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            globalController.openUrl(AppString().facebook);
          },
          child: Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppImages().facebookNewLogo),
              ),
            ),
          ),
        ),
        SizedBox(width: 8),
        GestureDetector(
          onTap: () {
            globalController.openUrl(AppString().instagram);
          },
          child: Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppImages().instagramNewLogo),
              ),
            ),
          ),
        ),
        SizedBox(width: 8),
        GestureDetector(
          onTap: () {
            globalController.openUrl(AppString().linkedInUrl);
          },
          child: Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppImages().linkedInNewLogo),
              ),
            ),
          ),
        ),
        SizedBox(width: 8),
        GestureDetector(
          onTap: () {
            globalController.openUrl(AppString().tiktok);
          },
          child: Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppImages().tiktokNewLogo),
              ),
            ),
          ),
        ),
        SizedBox(width: 8),
        GestureDetector(
          onTap: () {
            globalController.openUrl(AppString().youtube);
          },
          child: Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppImages().youtubeNewLogo),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget products() {
    return GestureDetector(
      onTap: () {
        Get.toNamed(AppRouteName.product);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 30),
            child: GestureDetector(
              onTap: () {
                Get.toNamed(AppRouteName.product);
              },
              child: Text(
                'Products',
                style: whiteTextStyle.copyWith(fontSize: 16, fontWeight: bold),
              ),
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Removable Tube Radiator',
            style: whiteTextStyle.copyWith(fontWeight: medium, fontSize: 14),
          ),
          SizedBox(height: 8),
          Text(
            'Alumunium Tube & Fin Core',
            style: whiteTextStyle.copyWith(fontWeight: medium, fontSize: 14),
          ),
          SizedBox(height: 8),
          Text(
            'Alumunium Plate & Bar Core',
            style: whiteTextStyle.copyWith(fontWeight: medium, fontSize: 14),
          ),
          SizedBox(height: 8),
          Text(
            'Copper Brass Core',
            style: whiteTextStyle.copyWith(fontWeight: medium, fontSize: 14),
          ),
          SizedBox(height: 8),
          Text(
            'CAT® Core Replacement',
            style: whiteTextStyle.copyWith(fontWeight: medium, fontSize: 14),
          ),
          SizedBox(height: 8),
          Text(
            'Tube & Shell Oil Cooler',
            style: whiteTextStyle.copyWith(fontWeight: medium, fontSize: 14),
          ),
          SizedBox(height: 8),
          Text(
            'Radiator Coolant',
            style: whiteTextStyle.copyWith(fontWeight: medium, fontSize: 14),
          ),
          SizedBox(height: 8),
          Text(
            'Air Cooled Heat Exchanger',
            style: whiteTextStyle.copyWith(fontWeight: medium, fontSize: 14),
          ),
          SizedBox(height: 8),
          Text(
            'Plate Heat Exchanger',
            style: whiteTextStyle.copyWith(fontWeight: medium, fontSize: 14),
          ),
          SizedBox(height: 8),
          Text(
            'Industrial Oil Cooler',
            style: whiteTextStyle.copyWith(fontWeight: medium, fontSize: 14),
          ),
          SizedBox(height: 8),
          Text(
            'Safety Radiator Cap',
            style: whiteTextStyle.copyWith(fontWeight: medium, fontSize: 14),
          ),
          SizedBox(height: 8),
          Text(
            'Replacement Fan',
            style: whiteTextStyle.copyWith(fontWeight: medium, fontSize: 14),
          ),
          SizedBox(height: 19),
        ],
      ),
    );
  }

  Widget services() {
    return GestureDetector(
      onTap: () {
        Get.toNamed(AppRouteName.services);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 30),
            child: Text(
              'Services',
              style: whiteTextStyle.copyWith(fontSize: 16, fontWeight: bold),
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Minor Repair',
            style: whiteTextStyle.copyWith(fontWeight: medium, fontSize: 14),
          ),
          SizedBox(height: 8),
          Text(
            'Major Repair',
            style: whiteTextStyle.copyWith(fontWeight: medium, fontSize: 14),
          ),
          SizedBox(height: 8),
          Text(
            'General Overhaul',
            style: whiteTextStyle.copyWith(fontWeight: medium, fontSize: 14),
          ),
          SizedBox(height: 22),
        ],
      ),
    );
  }

  Widget aboutUs() {
    return GestureDetector(
      onTap: () {
        Get.toNamed(AppRouteName.aboutUs);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Container(
            margin: EdgeInsets.only(top: 30),
            child: Text(
              'About Us',
              style: whiteTextStyle.copyWith(fontSize: 16, fontWeight: bold),
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Company Profile',
            style: whiteTextStyle.copyWith(fontWeight: medium, fontSize: 14),
          ),
          SizedBox(height: 8),
          Text(
            'Portfolio',
            style: whiteTextStyle.copyWith(fontWeight: medium, fontSize: 14),
          ),

          SizedBox(height: 22),
        ],
      ),
    );
  }

  Widget contactUs() {
    return GestureDetector(
      onTap: () {
        Get.toNamed(AppRouteName.contactUs);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 30),
            child: Text(
              'Contact',
              style: whiteTextStyle.copyWith(fontSize: 16, fontWeight: bold),
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Indocool Quick Contact Line',
            style: whiteTextStyle.copyWith(fontWeight: medium, fontSize: 14),
          ),
          SizedBox(height: 8),
          Text(
            'Inquiry',
            style: whiteTextStyle.copyWith(fontWeight: medium, fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget partNumberSearch() {
    return GestureDetector(
      onTap: () {
        Get.toNamed(AppRouteName.searchProduct);
      },
      child: Container(
        width: 280,
        height: 67,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/Rectangle 48_result.webp'),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'PART NUMBER SEARCH',
              style: whiteTextStyle.copyWith(fontSize: 14, fontWeight: bold),
            ),
            SizedBox(width: 8),
            Container(
              width: 20,
              height: 17,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/Logo-SHop 1_result.webp'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget footerLeft() {
    return Container(
      margin: EdgeInsets.only(right: 80),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(left: 50, top: 30),
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.only(right: 10),
                  width: 437,
                  height: 40,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(AppImages().imageFooter),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(left: 50),
                child: Text(
                  'PT. Indocool Solusi Cemerlang',
                  style: whiteTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: bold,
                  ),
                ),
              ),
              SizedBox(height: 12),
              Container(
                margin: EdgeInsets.only(left: 50),
                child: Text(
                  'Bogor Head Office: Bogor, Jawa Barat, Indonesia\nBranch Balikpapan: Balikpapan, Kalimantan Timur, Indonesia\nBranch Sangatta: Kutai Timur, Kalimantan Timur, Indonesia',
                  style: whiteTextStyle.copyWith(
                    fontSize: 14,
                    fontWeight: regular,
                  ),
                ),
              ),
              SizedBox(height: 12),
              Container(
                margin: EdgeInsets.only(left: 50),
                child: Text(
                  'PT. Indocool Rekayasa Batam',
                  style: whiteTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: bold,
                  ),
                ),
              ),
              SizedBox(height: 12),
              Container(
                margin: EdgeInsets.only(left: 50),
                child: Text(
                  'Batam Head Office: Batam, Kepulauan Riau, Indonesia',
                  style: whiteTextStyle.copyWith(
                    fontSize: 14,
                    fontWeight: regular,
                  ),
                ),
              ),
              SizedBox(height: 24),
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 50),
                    width: 15,
                    height: 15,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          'assets/images/Logo-WhatsApp 1_result.webp',
                        ),
                      ),
                    ),
                  ),
                  Text(
                    '+62 812-1000-256',
                    style: whiteTextStyle.copyWith(
                      fontWeight: medium,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 50),
                    width: 15,
                    height: 15,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          'assets/images/Logo-Email-2 1_result.webp',
                        ),
                      ),
                    ),
                  ),
                  Text(
                    'customersupport@indocool.co.id',
                    style: whiteTextStyle.copyWith(
                      fontWeight: medium,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 29),
              Container(
                margin: EdgeInsets.only(left: 50),
                width: 437,
                height: 28,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/Logo-ISO 1_result.webp'),
                  ),
                ),
              ),
              SizedBox(height: 22),
            ],
          ),
        ],
      ),
    );
  }

  Widget footerMenu() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        products(),
        SizedBox(width: 100),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [services(), aboutUs(), contactUs()],
        ),
      ],
    );
  }

  Widget footerRight(bool isSmallDesktop) {
    if (isSmallDesktop) {
      return Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Row(
          children: [
            partNumberSearch(),
            const SizedBox(width: 40),
            socialMedia(),
          ],
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.only(left: 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          partNumberSearch(),
          const SizedBox(height: 300),
          socialMedia(),
        ],
      ),
    );
  }

  Widget footerBottom() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          child: Text(
            "All manufacturer's names, symbols, part numbers, or descriptions, are used for reference purpose only.\nIt is not our intent to imply that any part mentioned is the product of OEM.",
            style: whiteTextStyle.copyWith(fontSize: 10, fontWeight: regular),
          ),
        ),
        Container(
          child: Text(
            'Copyright © 2026 PT. INDOCOOL SOLUSI CEMERLANG  | All Right Reserved',
            style: whiteTextStyle.copyWith(fontSize: 14, fontWeight: bold),
          ),
        ),
      ],
    );
  }

  Widget footerContent(bool isSmallDesktop) {
    if (isSmallDesktop) {
      return Container(
        margin: const EdgeInsets.only(left: 80, top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [footerLeft(), const SizedBox(width: 80), footerMenu()],
            ),

            const SizedBox(height: 50),

            footerRight(isSmallDesktop),
          ],
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.only(left: 180, top: 30),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          footerLeft(),

          footerMenu(),

          Expanded(
            child: Align(
              alignment: Alignment.topRight,
              child: footerRight(isSmallDesktop),
            ),
          ),
        ],
      ),
    );
  }

  Widget footerDesktop() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isSmallDesktop = constraints.maxWidth < 1500;

        return Container(
          width: double.infinity,
          color: Colors.black,
          child: Column(
            children: [
              footerContent(isSmallDesktop),

              const SizedBox(height: 40),

              Center(
                child: Container(width: 80.w, height: 1, color: Colors.white),
              ),

              const SizedBox(height: 25),

              footerBottom(),
            ],
          ),
        );
      },
    );
  }

  Widget footerMobile() {
    return Container(
      width: double.infinity,
      color: Colors.black,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 50, top: 30),
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 10),
                            width: 200,
                            height: 40,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(AppImages().imageFooter),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 50),
                          child: Text(
                            'PT. Indocool Solusi Cemerlang',
                            style: whiteTextStyle.copyWith(
                              fontSize: 16,
                              fontWeight: bold,
                            ),
                          ),
                        ),
                        SizedBox(height: 12),
                        Container(
                          margin: EdgeInsets.only(left: 50),
                          child: Text(
                            'Bogor Head Office: Bogor, Jawa Barat, Indonesia\nBranch Balikpapan: Balikpapan, Kalimantan Timur, Indonesia\nBranch Sangatta: Kutai Timur, Kalimantan Timur, Indonesia',
                            style: whiteTextStyle.copyWith(
                              fontSize: 14,
                              fontWeight: regular,
                            ),
                          ),
                        ),
                        SizedBox(height: 12),
                        Container(
                          margin: EdgeInsets.only(left: 50),
                          child: Text(
                            'PT. Indocool Rekayasa Batam',
                            style: whiteTextStyle.copyWith(
                              fontSize: 16,
                              fontWeight: bold,
                            ),
                          ),
                        ),
                        SizedBox(height: 12),
                        Container(
                          margin: EdgeInsets.only(left: 50),
                          child: Text(
                            'Batam Head Office: Batam, Kepulauan Riau, Indonesia',
                            style: whiteTextStyle.copyWith(
                              fontSize: 14,
                              fontWeight: regular,
                            ),
                          ),
                        ),
                        SizedBox(height: 24),
                        Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 50),
                              width: 15,
                              height: 15,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                    'assets/images/Logo-WhatsApp 1_result.webp',
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              '+62 812-1000-256',
                              style: whiteTextStyle.copyWith(
                                fontWeight: medium,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 50),
                              width: 15,
                              height: 15,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                    'assets/images/Logo-Email-2 1_result.webp',
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              'customersupport@indocool.co.id',
                              style: whiteTextStyle.copyWith(
                                fontWeight: medium,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 29),
                        Container(
                          margin: EdgeInsets.only(left: 50),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: 30),
                                child: GestureDetector(
                                  onTap: () {
                                    Get.toNamed(AppRouteName.product);
                                  },
                                  child: Text(
                                    'Products',
                                    style: whiteTextStyle.copyWith(
                                      fontSize: 16,
                                      fontWeight: bold,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Removable Tube Radiator',
                                style: whiteTextStyle.copyWith(
                                  fontWeight: medium,
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Conventional Radiator',
                                style: whiteTextStyle.copyWith(
                                  fontWeight: medium,
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Aluminum Plate & Bar Core',
                                style: whiteTextStyle.copyWith(
                                  fontWeight: medium,
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'After & Inter Cooler',
                                style: whiteTextStyle.copyWith(
                                  fontWeight: medium,
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Tube & Shell Oil Cooler',
                                style: whiteTextStyle.copyWith(
                                  fontWeight: medium,
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Radiator Coolant',
                                style: whiteTextStyle.copyWith(
                                  fontWeight: medium,
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Air Cooled Heat Exchanger',
                                style: whiteTextStyle.copyWith(
                                  fontWeight: medium,
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Plate Heat Exchanger',
                                style: whiteTextStyle.copyWith(
                                  fontWeight: medium,
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Industrial Oil Cooler',
                                style: whiteTextStyle.copyWith(
                                  fontWeight: medium,
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Safety Radiator Cap',
                                style: whiteTextStyle.copyWith(
                                  fontWeight: medium,
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Screw Cap Adapter',
                                style: whiteTextStyle.copyWith(
                                  fontWeight: medium,
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Replacement Fan',
                                style: whiteTextStyle.copyWith(
                                  fontWeight: medium,
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(height: 19),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(top: 30),
                                    child: Text(
                                      'Services',
                                      style: whiteTextStyle.copyWith(
                                        fontSize: 16,
                                        fontWeight: bold,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    'Minor Repair',
                                    style: whiteTextStyle.copyWith(
                                      fontWeight: medium,
                                      fontSize: 14,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    'Major Repair',
                                    style: whiteTextStyle.copyWith(
                                      fontWeight: medium,
                                      fontSize: 14,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    'General Overhaul',
                                    style: whiteTextStyle.copyWith(
                                      fontWeight: medium,
                                      fontSize: 14,
                                    ),
                                  ),
                                  SizedBox(height: 27),
                                  Container(
                                    margin: EdgeInsets.only(top: 30),
                                    child: Text(
                                      'Insight',
                                      style: whiteTextStyle.copyWith(
                                        fontSize: 16,
                                        fontWeight: bold,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    'Company News',
                                    style: whiteTextStyle.copyWith(
                                      fontWeight: medium,
                                      fontSize: 14,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    'Product Insight',
                                    style: whiteTextStyle.copyWith(
                                      fontWeight: medium,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),

                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(top: 30),
                                    child: Text(
                                      'About Us',
                                      style: whiteTextStyle.copyWith(
                                        fontSize: 16,
                                        fontWeight: bold,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    'Company Profile',
                                    style: whiteTextStyle.copyWith(
                                      fontWeight: medium,
                                      fontSize: 14,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    'Portfolio',
                                    style: whiteTextStyle.copyWith(
                                      fontWeight: medium,
                                      fontSize: 14,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    'Job Vacancies',
                                    style: whiteTextStyle.copyWith(
                                      fontWeight: medium,
                                      fontSize: 14,
                                    ),
                                  ),
                                  SizedBox(height: 27),
                                  Container(
                                    margin: EdgeInsets.only(top: 30),
                                    child: Text(
                                      'Contact',
                                      style: whiteTextStyle.copyWith(
                                        fontSize: 16,
                                        fontWeight: bold,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    'Inquiry',
                                    style: whiteTextStyle.copyWith(
                                      fontWeight: medium,
                                      fontSize: 14,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    'Customer Support',
                                    style: whiteTextStyle.copyWith(
                                      fontWeight: medium,
                                      fontSize: 14,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    'Company Location',
                                    style: whiteTextStyle.copyWith(
                                      fontWeight: medium,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 22),

                        Container(
                          margin: EdgeInsets.only(left: 50),
                          width: 300,
                          height: 28,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                'assets/images/Logo-ISO 1_result.webp',
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 22),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          Row(
            children: [
              Spacer(flex: 5),

              Container(
                width: 336,
                height: 67,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/Rectangle 48_result.webp'),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'PART NUMBER SEARCH',
                      style: whiteTextStyle.copyWith(
                        fontSize: 20,
                        fontWeight: bold,
                      ),
                    ),
                    SizedBox(width: 8),
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                            'assets/images/Logo-SHop 1_result.webp',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(flex: 1),
            ],
          ),
          SizedBox(height: 40),

          Center(
            child: Container(
              width: 80.w,
              height: 1,
              margin: EdgeInsets.symmetric(horizontal: 40),
              color: Colors.white,
            ),
          ),
          SizedBox(height: 25),
          Container(
            margin: EdgeInsets.only(left: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Container(
                    child: Text(
                      "All manufacturer's names, symbols, part numbers, or descriptions, are used for reference purpose only.\nIt is not our intent to imply that any part mentioned is the product of OEM.",
                      style: whiteTextStyle.copyWith(
                        fontSize: 10,
                        fontWeight: regular,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 25),

                Expanded(
                  child: Container(
                    child: Text(
                      'Copyright © 2026 PT. INDOCOOL SOLUSI CEMERLANG  | All Right Reserved',
                      style: whiteTextStyle.copyWith(
                        fontSize: 14,
                        fontWeight: bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 25),
        ],
      ),
    );
  }

  return ResponsiveLayout(mobile: footerMobile(), desktop: footerDesktop());
}
