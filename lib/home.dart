// ... imports Anda yang sudah ada ...
import 'dart:ui_web';

import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:project/appbar/appbar_element.dart';
import 'package:project/appbar/list_home.dart';
import 'package:project/controller/globalController.dart';
import 'package:project/controller/homeController.dart';
import 'package:project/controller/mainProductController.dart';
import 'package:project/custom_text_field.dart';
import 'package:project/detail_location.dart';
import 'package:project/detail_product.dart';
import 'package:project/global%20widget/appPreCache.dart';
import 'package:project/global%20widget/featureCard.dart';
import 'package:project/global%20widget/footer.dart';
import 'package:project/global%20widget/globalAppBar.dart';
import 'package:project/global%20widget/globalLoadingWidget.dart';
import 'package:project/global%20widget/personalData.dart';
import 'package:project/logoChooseUS.dart';
import 'package:project/model/allDataModel.dart';
import 'package:project/model/featureCardModel.dart';
import 'package:project/model/serviceModel.dart';
import 'package:project/routes/routes_name.dart';
import 'package:project/search_product_page.dart';
import 'package:project/theme/app_images.dart';
import 'package:project/theme/string.dart';
import 'package:project/theme/theme.dart';
// import-import lain
import 'package:sizer/sizer.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<bool> expandedIcons = [false, false, false, false, false];
  bool _visible = false;
  bool isDesktop(double width) => width >= 900;

  bool isTablet(double width) => width >= 600 && width < 900;
  ExpandableCarouselController carouselController =
      ExpandableCarouselController();
  bool isMobile(double width) => width < 600;
  var homecontroller = Get.find<Homecontroller>();
  var mainProductController = Get.find<MainProductController>();
  var globalController = Get.find<GlobalController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      AppPrecache.preload(context);
      if (mounted) {
        setState(() {
          _visible = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    // Data fitur tetap sama
    final List<Feature> featureData = [
      Feature(
        'assets/images/D85ESS-Transp 1_result.webp',
        "Removable Tube Radiator",
      ),
      Feature(
        'assets/images/D375-Transp 1_result.webp',
        "Conventional Radiator Core",
      ),
      Feature(
        'assets/images/777E-Transp 1_result.webp',
        "Aluminum Plate & Bar\nCooler & Heat Exchanger",
      ),
    ];
    final List<Feature> secondfeatureData = [
      Feature(
        'assets/images/D85ESS-Transp 1_result.webp',
        "Removable Tube Radiator",
      ),
      Feature(
        'assets/images/D375-Transp 1_result.webp',
        "Conventional Radiator Core",
      ),
      Feature(
        'assets/images/777E-Transp 1_result.webp',
        "Aluminum Plate & Bar\nCooler & Heat Exchanger",
      ),
    ];
    Widget nextButton({required VoidCallback onTap, isServices = false}) {
      return GestureDetector(
        onTap: onTap,
        child: Container(
          width: (isServices) ? 80 : 45,
          height: (isServices) ? 30 : 85,
          decoration: BoxDecoration(
            color: (isServices == false) ? Colors.grey.shade300 : darkblue,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Center(
            child: Icon(
              Icons.arrow_forward_outlined, // bisa diganti Icons.arrow_forward
              color: (isServices) ? kWhiteColor : Colors.black,
              size: 28,
            ),
          ),
        ),
      );
    }

    Widget prevButton({required VoidCallback onTap}) {
      return GestureDetector(
        onTap: onTap,
        child: Container(
          width: 45,
          height: 80,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Center(
            child: Icon(
              Icons.arrow_back_outlined, // bisa diganti Icons.arrow_forward

              color: Colors.black,
              size: 28,
            ),
          ),
        ),
      );
    }

    List<List<T>> chunk<T>(List<T> list, int size) {
      List<List<T>> chunks = [];
      for (int i = 0; i < list.length; i += size) {
        chunks.add(
          list.sublist(i, i + size > list.length ? list.length : i + size),
        );
      }
      return chunks;
    }

    Widget plusPoint() {
      // Ambil lebar layar sekali untuk penggunaan isMobile di luar LayoutBuilder

      return GetBuilder<MainProductController>(
        builder: (controller) {
          final screenWidth = MediaQuery.of(context).size.width;
          final grouped = chunk(
            mainProductController.mainProductModel ?? [],
            3,
          );
          return Container(
            color: Color(0xffF2F2F2),
            width: 100.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 5.h),
                Text(
                  AppString().plusPointTitle,
                  style: blackTextStyle.copyWith(
                    fontSize: 18.sp,
                    fontWeight: bold,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 1.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: Text(
                    AppString().pluspointSubTitle,
                    textAlign: TextAlign.center,
                    style: greyTextStyle.copyWith(
                      fontSize: 12.sp,
                      fontWeight: light,
                    ),
                  ),
                ),
                SizedBox(height: 5.h),

                (controller.isLoading == true)
                    ? globalLoading()
                    : (isMobile(screenWidth))
                    ? ExpandableCarousel(
                        items: mainProductController.mainProductModel?.map((
                          group,
                        ) {
                          return Container(
                            margin: EdgeInsets.only(right: 12, left: 12),
                            child: featureCard(
                              title: group.productName,
                              image: group.imageUrl,
                              isMobile: isMobile(screenWidth),
                            ),
                          );
                        }).toList(),
                        options: ExpandableCarouselOptions(
                          controller: carouselController,
                          autoPlay: true,
                          autoPlayAnimationDuration: Duration(seconds: 1),
                          viewportFraction: 1,
                          enableInfiniteScroll: false,
                        ),
                      )
                    : ExpandableCarousel(
                        items: grouped.map((group) {
                          return Row(
                            children: [
                              SizedBox(width: 20),
                              prevButton(
                                onTap: () {
                                  carouselController.previousPage(
                                    duration: Duration(milliseconds: 300),
                                    curve: Curves.linear,
                                  );
                                },
                              ),
                              ...group.map((item) {
                                return Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: featureCard(
                                      title: item.productName,
                                      image: item.imageUrl,
                                      isMobile: isMobile(screenWidth),
                                    ),
                                  ),
                                );
                              }),
                              nextButton(
                                onTap: () {
                                  carouselController.startAutoPlay();

                                  carouselController.nextPage(
                                    duration: Duration(milliseconds: 300),
                                    curve: Curves.linear,
                                  );
                                },
                              ),
                              SizedBox(width: 20),
                            ],
                          );
                        }).toList(),

                        options: ExpandableCarouselOptions(
                          controller: carouselController,
                          viewportFraction: 1, // wajib full
                          enableInfiniteScroll: false,
                        ),
                      ),
                SizedBox(height: 5.h),
              ],
            ),
          );
        },
      );
    }

    Widget servicesContentWidget(ServiceModel? serviceModel) {
      return Expanded(
        child: Container(
          margin: EdgeInsets.only(left: 10, right: 10),
          child: Column(
            children: [
              Image.network(serviceModel?.imageUrl ?? ''),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    serviceModel?.serviceName ?? '',
                    style: whiteTextStyle.copyWith(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  nextButton(onTap: () {}, isServices: true),
                ],
              ),
              SizedBox(height: 8),
              Text(
                serviceModel?.description ?? '',
                style: greyTextStyle.copyWith(fontSize: 12.sp),
              ),
            ],
          ),
        ),
      );
    }

    Widget servicesWidget() {
      return Container(
        color: Colors.black,

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(top: 40),
              child: Text(
                'Radiator or Heat Exchanger Service and Repair Specialist',
                style: whiteTextStyle.copyWith(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              margin: EdgeInsets.only(left: 32, right: 32),
              child: Text(
                'Indocool can carry out minor repairs or complete overhauls to most makes and models of industrial cooling system components. Radiators, oil coolers,and heat exchangers, within the mining, oil & gas, marine, industrial power generation, and general industries.',
                textAlign: TextAlign.center,
                style: whiteTextStyle.copyWith(
                  fontSize: 12.sp,
                  fontWeight: regular,
                ),
              ),
            ),
            SizedBox(height: 20.sp),
            Row(
              children: [
                SizedBox(width: 12.w),
                ...List.generate(homecontroller.serviceModel?.length ?? 0, (
                  index,
                ) {
                  return servicesContentWidget(
                    homecontroller.serviceModel?[index],
                  );
                }),
                SizedBox(width: 12.w),
              ],
            ),
            SizedBox(height: 100),
          ],
        ),
      );
    }

    Widget reasonSectionMobile() {
      return Container(
        width: 100.w,
        padding: EdgeInsets.symmetric(vertical: 64, horizontal: 20),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/Rectangle 39 (1)_result.webp'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Text(
              'The Reason They Choose Us',
              textAlign: TextAlign.center,
              style: whiteTextStyle.copyWith(fontWeight: bold, fontSize: 24),
            ),

            SizedBox(height: 32),

            Column(
              children: [
                Text(
                  'ISO 9001, 14001, 45001\nCompany Certified',
                  textAlign: TextAlign.center,
                  style: whiteTextStyle.copyWith(
                    fontWeight: bold,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'We are committed to setting globally recognized standards (ISO) in quality, environmental, and occupational health and safety management systems.',
                  textAlign: TextAlign.center,
                  style: whiteTextStyle.copyWith(
                    fontWeight: regular,
                    fontSize: 14,
                  ),
                ),
              ],
            ),

            SizedBox(height: 32),

            Column(
              children: [
                Text(
                  '17.000+ Projects Handled',
                  textAlign: TextAlign.center,
                  style: whiteTextStyle.copyWith(
                    fontWeight: bold,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'A testament to our extensive experience and trusted expertise, we have successfully delivered over 17.000 projects.',
                  textAlign: TextAlign.center,
                  style: whiteTextStyle.copyWith(
                    fontWeight: regular,
                    fontSize: 14,
                  ),
                ),
              ],
            ),

            SizedBox(height: 32),

            Column(
              children: [
                Text(
                  'Global Trusted Partner',
                  textAlign: TextAlign.center,
                  style: whiteTextStyle.copyWith(
                    fontWeight: bold,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Our commitment to excellence has made us a trusted partner for many companies worldwide.',
                  textAlign: TextAlign.center,
                  style: whiteTextStyle.copyWith(
                    fontWeight: regular,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }

    Widget reasonSection() {
      return Container(
        color: kLigtblueColor,
        width: double.infinity,
        child: Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(
                    left: 150,
                    bottom: 45,
                    top: 56,
                    right: 150,
                  ),
                  child: Text(
                    'THE REASON OUR\nCUSTOMERS CHOOSE US',
                    style: whiteTextStyle.copyWith(
                      fontSize: 40,
                      fontWeight: bold,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 150, bottom: 50),
                  width: 536,
                  height: 292,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        'assets/images/007-Indocool-Customer 1_result.webp',
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 44, bottom: 20),
                        width: 160,
                        height: 141,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                              'assets/images/006-ISO-Indocool 1_result.webp',
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'ISO 9001, 14001, 45001 Company Certified',
                              style: whiteTextStyle.copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'We are committed to setting globally recognized standards (ISO) in quality,\nenvironmental, and occupational health and safety management systems.\nWe strive to provide the best services and products to our customers.',
                              style: whiteTextStyle.copyWith(fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 44, bottom: 20),
                        width: 160,
                        height: 141,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                              'assets/images/005-Project-Indocool 1_result.webp',
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'ISO 9001, 14001, 45001 Company Certified',
                              style: whiteTextStyle.copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'We are committed to setting globally recognized standards (ISO) in quality,\nenvironmental, and occupational health and safety management systems.\nWe strive to provide the best services and products to our customers.',
                              style: whiteTextStyle.copyWith(fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 44, bottom: 20),
                        width: 160,
                        height: 141,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                              'assets/images/006-Indocool-Indonesia 1_result.webp',
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'ISO 9001, 14001, 45001 Company Certified',
                              style: whiteTextStyle.copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'We are committed to setting globally recognized standards (ISO) in quality,\nenvironmental, and occupational health and safety management systems.\nWe strive to provide the best services and products to our customers.',
                              style: whiteTextStyle.copyWith(fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    // Widget headerProduct({String? description, String? image}) {
    //   return Container(
    //     margin: EdgeInsets.only(right: 24, left: 24),
    //     child: Column(
    //       children: [
    //         Image.asset(image ?? '', width: 300, height: 300),
    //         SizedBox(height: 19),
    //         Text(description ?? '', style: blackTextStyle),
    //       ],
    //     ),
    //   );
    // }

    Widget headerProduct({String? description, String? image}) {
      return LayoutBuilder(
        builder: (context, constraints) {
          final size = constraints.maxWidth * 0.9;

          return Container(
            margin: EdgeInsets.only(right: 10, left: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  image ?? '',
                  width: size.clamp(120.0, 300),
                  height: size.clamp(120.0, 300),
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 12),
                Text(
                  description ?? '',
                  style: whiteTextStyle.copyWith(
                    fontSize: 20,
                    fontWeight: semiBold,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          );
        },
      );
    }

    Widget industry() {
      final isDesktop = MediaQuery.of(context).size.width > 1500;
      return Container(
        width: double.infinity,
        color: Colors.black,
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 260, right: 106, top: 100),
                  width: 374,
                  height: 306,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/Logo-47 1_result.webp'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'We have 47 years of proven performance, we understand your industry,\nwe provide solutions, and here is how we can support your operation.',
                        style: whiteTextStyle.copyWith(fontSize: 20),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'From heavy-duty radiators and industrial cooling systems to repair services,\nengine coolants, and spare parts, Indocool delivers reliable solutions to \nmaximize equipment performance and minimize downtime.',
                        style: whiteTextStyle.copyWith(fontSize: 20),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 70),
            Container(
              child: Text(
                'INDUSTRY WE SERVE:',
                style: whiteTextStyle.copyWith(
                  fontSize: 29,
                  fontWeight: semiBold,
                ),
              ),
            ),
            SizedBox(height: 44),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Flexible(
                        child: headerProduct(
                          description: AppString().productHeaderDescription1,
                          image: AppImages().imgHeaderProduct1,
                        ),
                      ),
                    ),
                    Container(
                      child: Flexible(
                        child: headerProduct(
                          description: AppString().productHeaderDescription2,
                          image: AppImages().imgHeaderProduct2,
                        ),
                      ),
                    ),
                    Container(
                      child: Flexible(
                        child: headerProduct(
                          description: AppString().productHeaderDescription3,
                          image: AppImages().imgHeaderProduct3,
                        ),
                      ),
                    ),
                    Container(
                      child: Flexible(
                        child: headerProduct(
                          description: AppString().productHeaderDescription4,
                          image: AppImages().imgHeaderProduct4,
                        ),
                      ),
                    ),
                    Container(
                      child: Flexible(
                        child: headerProduct(
                          description: AppString().productHeaderDescription5,
                          image: AppImages().imgHeaderProduct5,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 104),
          ],
        ),
      );
    }

    Widget heroSectionContent() {
      return Column(
        crossAxisAlignment: isDesktop(screenWidth)
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.center,
        children: [
          SizedBox(height: isDesktop(screenWidth) ? 10.h : 5.h),
          Container(
            margin: EdgeInsets.only(
              left: isDesktop(screenWidth) ? 0.w : 5.w,
              right: isDesktop(screenWidth) ? 15.w : 5.w,
            ),
            padding: EdgeInsets.symmetric(
              vertical: isDesktop(screenWidth) ? 40 : 2.h,
              horizontal: isDesktop(screenWidth) ? 36 : 0.w,
            ),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.45),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Column(
              crossAxisAlignment: isDesktop(screenWidth)
                  ? CrossAxisAlignment.start
                  : CrossAxisAlignment.center,
              children: [
                Container(
                  // Hapus margin tetap, ganti dengan Padding atau alignment
                  padding: EdgeInsets.symmetric(
                    horizontal: isDesktop(screenWidth) ? 0 : 5.w,
                  ),
                  child: Text(
                    AppString().titleLandingPage1,
                    style: whiteTextStyle.copyWith(
                      fontSize: isDesktop(screenWidth)
                          ? 20.sp
                          : 24.sp, // Ukuran font responsif
                      fontWeight: bold,
                    ),
                    textAlign: isDesktop(screenWidth)
                        ? TextAlign.left
                        : TextAlign.center,
                  ),
                ),
                SizedBox(height: 2.h),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: isDesktop(screenWidth) ? 0 : 5.w,
                  ),
                  child: Text(
                    AppString().heroSectionContentTitle,
                    style: whiteTextStyle.copyWith(fontSize: 14.sp),
                    textAlign: isDesktop(screenWidth)
                        ? TextAlign.left
                        : TextAlign.center,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: isDesktop(screenWidth) ? 3.h : 3.h,
                  ),
                  child: Row(
                    mainAxisAlignment: isDesktop(screenWidth)
                        ? MainAxisAlignment.start
                        : MainAxisAlignment.center,
                    children: [
                      // TOMBOL BIRU
                      ElevatedButton.icon(
                        onPressed: () {
                          globalController.openWhatsApp(
                            AppString().indocoolWhatsappNumber,
                            'Halo Saya Ingin Bertanya',
                          );
                        },
                        icon: Text(
                          "Contact Us",
                          style: TextStyle(color: Colors.white),
                        ),
                        label: Icon(
                          Icons.phone_callback,
                          color: Colors.white,
                          size: isDesktop(screenWidth) ? 12.sp : 17.sp,
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 15,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              12,
                            ), // Membuat sudut melengkung
                          ),
                        ),
                      ),

                      SizedBox(width: 15), // Jarak antar tombol
                      // TOMBOL PUTIH
                      ElevatedButton.icon(
                        onPressed: () {
                          Get.toNamed(AppRouteName.product);
                        },
                        icon: Text(
                          "Learn More",
                          style: blackTextStyle.copyWith(fontWeight: bold),
                        ),
                        label: Icon(
                          Icons.arrow_forward,
                          color: Colors.black,
                          size: isDesktop(screenWidth) ? 12.sp : 17.sp,
                        ),
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 15,
                          ),
                          side: BorderSide(
                            color: Colors.grey.shade300,
                          ), // Garis pinggir tipis
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: isDesktop(screenWidth) ? 20.h : 5.h),
        ],
      );
    }

    Widget questionHeroSectionContent() {
      return Container(
        padding: EdgeInsets.only(left: isDesktop(screenWidth) ? 20.w : 5.w),
        child: Column(
          crossAxisAlignment: isDesktop(screenWidth)
              ? CrossAxisAlignment.start
              : CrossAxisAlignment.center,
          children: [
            SizedBox(height: isDesktop(screenWidth) ? 10.h : 5.h),
            Container(
              // Hapus margin tetap, ganti dengan Padding atau alignment
              child: Text(
                'Pertanyaan yang\nSering Ditanyakan',
                style: blackTextStyle.copyWith(
                  fontSize: isDesktop(screenWidth)
                      ? 20.sp
                      : 24.sp, // Ukuran font responsif
                  fontWeight: bold,
                ),
                textAlign: isDesktop(screenWidth)
                    ? TextAlign.left
                    : TextAlign.center,
              ),
            ),
            SizedBox(height: 2.h),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: isDesktop(screenWidth) ? 0 : 5.w,
              ),
              child: Text(
                AppString().heroSectionContentTitle,
                style: greyTextStyle.copyWith(
                  fontWeight: light,
                  fontSize: isMobile(screenWidth) ? 13.sp : 10.sp,
                ),
                textAlign: isDesktop(screenWidth)
                    ? TextAlign.left
                    : TextAlign.center,
              ),
            ),
            SizedBox(height: isDesktop(screenWidth) ? 10.h : 5.h),
          ],
        ),
      );
    }

    Widget questionListSection() {
      return Padding(
        padding: EdgeInsets.symmetric(
          horizontal: isDesktop(screenWidth) ? 10.w : 5.w,
        ),
        child: Container(
          margin: EdgeInsets.only(bottom: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              SizedBox(height: 6.h),
              GestureDetector(
                onTap: () {
                  setState(() {
                    expandedIcons[0] = !expandedIcons[0];
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ListHome(
                      warna: blackTextStyle,
                      title: 'Apakah Buku Bengkel Itu?',
                      size: isMobile(screenWidth) ? 15.sp : 12.sp,
                    ),
                    Icon(
                      expandedIcons[0]
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down_outlined,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 1.5.h),
              Visibility(
                visible: expandedIcons[0] ? true : false,
                child: Text(
                  'Buku Bengkel adalah pengeloala bengkel modern yang lengkap dan mudah\ndigunakan,dirancang khusus untuk membantu Anda mengelola bengkel secara\nprofisonal dan efisien',
                  style: blackTextStyle.copyWith(
                    fontSize: (isMobile(screenWidth)) ? 13.sp : 10.sp,
                    fontWeight: light,
                  ),
                ),
              ),
              Container(
                height: 2,
                width: double.infinity,
                color: Colors.grey.shade300,
                margin: EdgeInsets.symmetric(vertical: 2.h),
              ),

              // Item 02 s/d 05
              GestureDetector(
                onTap: () {
                  setState(() {
                    expandedIcons[1] = !expandedIcons[1];
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ListHome(
                      warna: blackTextStyle,
                      title: 'Bagaimana cara sistem kerja Buku Bengkel?',
                      size: isMobile(screenWidth) ? 15.sp : 12.sp,
                    ),
                    Icon(
                      expandedIcons[1]
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down_outlined,
                    ),
                  ],
                ),
              ),
              Container(
                height: 2,
                width: double.infinity,
                color: Colors.grey.shade300,
                margin: EdgeInsets.symmetric(vertical: 2.h),
              ),

              GestureDetector(
                onTap: () {
                  setState(() {
                    expandedIcons[2] = !expandedIcons[2];
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ListHome(
                      warna: blackTextStyle,
                      title: 'Apakah ini Gratis',
                      size: isMobile(screenWidth) ? 15.sp : 12.sp,
                    ),
                    Icon(
                      expandedIcons[2]
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down_outlined,
                    ),
                  ],
                ),
              ),
              Container(
                height: 2,
                width: double.infinity,
                color: Colors.grey.shade300,
                margin: EdgeInsets.symmetric(vertical: 2.h),
              ),

              GestureDetector(
                onTap: () {
                  setState(() {
                    expandedIcons[3] = !expandedIcons[3];
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ListHome(
                      warna: blackTextStyle,
                      title: 'Bagaimana cara sistem kerja Buku Bengkel',
                      size: isMobile(screenWidth) ? 15.sp : 12.sp,
                    ),
                    Icon(
                      expandedIcons[3]
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down_outlined,
                    ),
                  ],
                ),
              ),
              Container(
                height: 2,
                width: double.infinity,
                color: Colors.grey.shade300,
                margin: EdgeInsets.symmetric(vertical: 2.h),
              ),

              GestureDetector(
                onTap: () {
                  setState(() {
                    expandedIcons[4] = !expandedIcons[4];
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ListHome(
                      warna: blackTextStyle,
                      title: 'Apakah data pada aplikasi ini aman',
                      size: isMobile(screenWidth) ? 15.sp : 12.sp,
                    ),
                    Icon(
                      expandedIcons[4]
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down_outlined,
                    ),
                  ],
                ),
              ),
              Container(
                height: 2,
                width: double.infinity,
                color: Colors.grey.shade300,
                margin: EdgeInsets.symmetric(vertical: 2.h),
              ),
            ],
          ),
        ),
      );
    }

    Widget featureListSection() {
      return Padding(
        padding: EdgeInsets.symmetric(
          horizontal: isDesktop(screenWidth) ? 0.05.w : 5.w,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 1.h),

            ListHome(
              nomer: AppString().listHomeNumber1,
              title: AppString().listHomeTitle1,
              warna: isMobile(screenWidth) ? blackTextStyle : blackTextStyle,
            ),
            Visibility(
              visible: homecontroller.isViewListHome1 == true,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 1.5.h),
                  Container(
                    margin: EdgeInsets.only(left: 58),
                    child: Text(
                      AppString().listHomeSubtitle1,
                      style: blackTextStyle.copyWith(
                        fontSize: (isMobile(screenWidth)) ? 14.sp : 10.sp,
                        fontWeight: regular,
                      ),
                    ),
                  ),
                  Container(
                    height: 2,
                    width: double.infinity,
                    color: Colors.grey.shade300,
                    margin: EdgeInsets.symmetric(vertical: 2.h),
                  ),
                  ListHome(
                    nomer: AppString().listHomeNumber2,
                    title: AppString().listHomeTitle2,
                    warna: isMobile(screenWidth)
                        ? blackTextStyle
                        : blackTextStyle,
                  ),
                  Visibility(
                    visible: homecontroller.isViewListHome1 == true,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 1.5.h),
                        Container(
                          margin: EdgeInsets.only(left: 58),
                          child: Text(
                            AppString().listHomeSubtitle2,
                            style: blackTextStyle.copyWith(
                              fontSize: (isMobile(screenWidth)) ? 14.sp : 10.sp,
                              fontWeight: regular,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 2,
                    width: double.infinity,
                    color: Colors.grey.shade300,
                    margin: EdgeInsets.symmetric(vertical: 2.h),
                  ),
                  ListHome(
                    nomer: AppString().listHomeNumber3,
                    title: AppString().listHomeTitle3,
                    warna: isMobile(screenWidth)
                        ? blackTextStyle
                        : blackTextStyle,
                  ),
                  Visibility(
                    visible: homecontroller.isViewListHome1 == true,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 1.5.h),
                        Container(
                          margin: EdgeInsets.only(left: 58),
                          child: Text(
                            AppString().listHomeSubtitle1,
                            style: blackTextStyle.copyWith(
                              fontSize: (isMobile(screenWidth)) ? 14.sp : 10.sp,
                              fontWeight: regular,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  ListHome(
                    nomer: AppString().listHomeNumber4,
                    title: AppString().listHomeTitle4,
                    warna: isMobile(screenWidth)
                        ? blackTextStyle
                        : blackTextStyle,
                  ),
                  Visibility(
                    visible: homecontroller.isViewListHome1 == true,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 1.5.h),
                        Container(
                          margin: EdgeInsets.only(left: 58),
                          child: Text(
                            AppString().listHomeSubtitle4,
                            style: blackTextStyle.copyWith(
                              fontSize: (isMobile(screenWidth)) ? 14.sp : 10.sp,
                              fontWeight: regular,
                            ),
                          ),
                        ),
                        Container(
                          height: 2,
                          width: double.infinity,
                          color: Colors.grey.shade300,
                          margin: EdgeInsets.symmetric(vertical: 2.h),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    Widget location() {
      return Container(
        width: 100.w,

        child: Container(
          margin: EdgeInsets.only(top: 50),
          child: Column(
            children: [
              Text(
                'Office & Workshop Location',
                style: blackTextStyle.copyWith(fontWeight: bold, fontSize: 36),
              ),

              SizedBox(height: 5.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: 50.w,
                    height: 30.h,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          'assets/images/MAP-Indocool-1 1_result.webp',
                        ),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Container(
                        width: 438,
                        height: 138,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                              'assets/images/Indocool-Indonesia-Australia-2 1_result.webp',
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 44),
                      Container(
                        margin: EdgeInsets.only(right: 120),
                        child: Text(
                          'We are a company with more than 47 years of\nexperience in maintenance, repair, service,\nmanufacturing, and fabricating radiators & heat\nexchangers in Indonesia. We have 5 facilities in\nJava, Kalimantan, and Batam, and we have a mission\nto become the best company in Southeast\nAsia in the Radiator & Heat Exchanger.',
                          style: blackTextStyle.copyWith(fontWeight: regular),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 5.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  DetailLocation(
                    number: 'assets/images/1 8_result.webp',
                    factory: 'assets/images/Rectangle 11_result.webp',
                    title: 'Bogor Head Office & Workshop',
                  ),
                  DetailLocation(
                    number: 'assets/images/2 1_result.webp',
                    factory: 'assets/images/Rectangle 9_result.webp',
                    title: 'Balikpapan Office & Workshop',
                  ),
                  DetailLocation(
                    number: 'assets/images/3 1_result.webp',
                    factory: 'assets/images/Rectangle 10_result.webp',
                    title: 'Sangatta Office & Workshop',
                  ),
                  DetailLocation(
                    number: 'assets/images/4 6754_result.webp',
                    factory: 'assets/images/Rectangle 12_result.webp',
                    title: 'Batam Head Office & Workshop',
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }

    Widget locationMobile() {
      return Container(
        width: 100.w,
        margin: EdgeInsets.only(top: 50),
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Office & Workshop Location',
              style: blackTextStyle.copyWith(fontWeight: bold, fontSize: 24),
            ),

            SizedBox(height: 10),

            Text(
              '100% Made in Indonesia\nand by Indonesian Hands',
              style: blackTextStyle.copyWith(fontWeight: bold, fontSize: 16),
            ),

            SizedBox(height: 3.h),

            Container(
              width: 100.w,
              height: 25.h,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    'assets/images/MAP-Indocool-1 1_result.webp',
                  ),
                  fit: BoxFit.contain,
                ),
              ),
            ),

            SizedBox(height: 3.h),

            Text(
              'INDOCOOL GROUP, a leading name in the industrial cooling system sector, is dedicated to excellence and innovation. The group oversees two dynamic subsidiaries:\n(1) PT Indocool Solusi Cemerlang (Bogor, Balikpapan, & Sangatta)\n(2) PT Indocool Rekayasa Batam (Batam Island)',
              style: blackTextStyle.copyWith(fontWeight: regular),
            ),

            SizedBox(height: 15),

            Text(
              'We are a company with more than 47 years of experience in maintenance, repair, service, manufacturing, and fabricating radiators & heat exchangers in Indonesia.',
              style: blackTextStyle.copyWith(fontWeight: regular),
            ),

            SizedBox(height: 4.h),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  DetailLocation(
                    number: 'assets/images/1 8_result.webp',
                    factory: 'assets/images/Rectangle 9_result.webp',
                    title: 'Bogor Head Office & Workshop',
                  ),
                  SizedBox(width: 20),
                  DetailLocation(
                    number: 'assets/images/2 1_result.webp',
                    factory: 'assets/images/Rectangle 10_result.webp',
                    title: 'Balikpapan Office & Workshop',
                  ),
                  SizedBox(width: 20),
                  DetailLocation(
                    number: 'assets/images/3 1_result.webp',
                    factory: 'assets/images/Rectangle 11_result.webp',
                    title: 'Sangatta Office & Workshop',
                  ),
                  SizedBox(width: 20),
                  DetailLocation(
                    number: 'assets/images/4 6754_result.webp',
                    factory: 'assets/images/Rectangle 12_result.webp',
                    title: 'Batam Head Office & Workshop',
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    Widget chooseUsMobile() {
      return Container(
        width: 100.w,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Column(
          children: [
            Text(
              'Those Who Choose Us',
              textAlign: TextAlign.center,
              style: blackTextStyle.copyWith(fontWeight: bold, fontSize: 24),
            ),

            SizedBox(height: 32),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Logochooseus(
                      image: 'assets/images/AMMAN Logo 1_result.webp',
                    ),
                    Logochooseus(
                      image: 'assets/images/Logo-Madhani 1_result.webp',
                    ),
                    Logochooseus(image: 'assets/images/Logo-KPC 1_result.webp'),
                    Logochooseus(image: 'assets/images/image 1_result.webp'),
                    Logochooseus(
                      image:
                          'assets/images/Logo-Cipta-Andalan-Teknindo 1_result.webp',
                    ),
                    Logochooseus(
                      image: 'assets/images/Logo-Thriveni 1_result.webp',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget chooseUs() {
      return Container(
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/images/Indocool-Global-Customer 1_result.webp',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 33, left: 260, top: 40),
              child: Text(
                'EXPANDING OUR REACH ACROSS\nGLOBAL INDUSTRIES',
                style: whiteTextStyle.copyWith(fontSize: 40, fontWeight: bold),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 80, left: 260),
              child: Text(
                'From Indonesia to international markets, our commitment to quality,\nreliability, and customer satisfaction continues to drive long-term\npartnerships across critical industries.',
                style: whiteTextStyle.copyWith(
                  fontSize: 20,
                  fontWeight: semiBold,
                ),
              ),
            ),
          ],
        ),
      );
    }

    // Widget personaldata() {
    //   return Container(
    //     width: double.infinity,
    //     color: kBlueColor,
    //     child: Column(
    //       children: [
    //         Center(
    //           child: Text(
    //             'Place Your Inquiry Here',
    //             style: whiteTextStyle.copyWith(fontSize: 28, fontWeight: bold),
    //           ),
    //         ),
    //         SizedBox(height: 3.h),
    //         Container(
    //           width: 65.w,

    //           decoration: BoxDecoration(
    //             color: kWhiteColor,
    //             borderRadius: BorderRadius.circular(16),
    //           ),
    //           child: Container(
    //             margin: EdgeInsets.only(top: 25),
    //             child: Column(
    //               children: [
    //                 Row(
    //                   mainAxisAlignment: MainAxisAlignment.spaceAround,
    //                   children: [
    //                     CustoumTextField(
    //                       hintName: 'Enter name',
    //                       obsecureText: false,
    //                       width: 20.w,
    //                     ),
    //                     CustoumTextField(
    //                       hintName: 'Enter Email',
    //                       obsecureText: false,
    //                       width: 20.w,
    //                     ),
    //                     CustoumTextField(
    //                       hintName: 'Company name',
    //                       obsecureText: false,
    //                       width: 20.w,
    //                     ),
    //                   ],
    //                 ),
    //                 Row(
    //                   mainAxisAlignment: MainAxisAlignment.spaceAround,
    //                   children: [
    //                     CustoumTextField(
    //                       hintName: 'Messege',
    //                       obsecureText: false,
    //                       width: 50.w,
    //                       maxLines: 5,
    //                     ),
    //                     Container(
    //                       width: 150,
    //                       height: 50,
    //                       margin: EdgeInsets.only(top: 5.h),
    //                       child: ElevatedButton(
    //                         onPressed: () {},
    //                         style: ElevatedButton.styleFrom(
    //                           backgroundColor: kBlueColor,
    //                           shape: RoundedRectangleBorder(
    //                             borderRadius: BorderRadius.circular(30),
    //                           ),
    //                           elevation: 0,
    //                         ),
    //                         child: Text(
    //                           "SUBMIT",
    //                           style: whiteTextStyle.copyWith(fontWeight: bold),
    //                         ),
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //               ],
    //             ),
    //           ),
    //         ),
    //       ],
    //     ),
    //   );
    // }

    Widget personalDataMobile() {
      return Container(
        width: double.infinity,
        color: kBlueColor,
        padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Place Your Inquiry Here',
              textAlign: TextAlign.center,
              style: whiteTextStyle.copyWith(fontSize: 22, fontWeight: bold),
            ),
            SizedBox(height: 20),

            // CARD PUTIH
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: kWhiteColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  // NAME
                  CustoumTextField(
                    hintName: 'Enter name',
                    obsecureText: false,
                    width: double.infinity,
                  ),

                  // EMAIL
                  CustoumTextField(
                    hintName: 'Enter Email',
                    obsecureText: false,
                    width: double.infinity,
                  ),

                  // COMPANY
                  CustoumTextField(
                    hintName: 'Company name',
                    obsecureText: false,
                    width: double.infinity,
                  ),

                  // MESSAGE
                  CustoumTextField(
                    hintName: 'Message',
                    obsecureText: false,
                    width: double.infinity,
                    maxLines: 4,
                  ),

                  SizedBox(height: 10),

                  // BUTTON
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kBlueColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        "SUBMIT",
                        style: whiteTextStyle.copyWith(
                          fontWeight: bold,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    Widget footerMobile() {
      return Container(
        width: double.infinity,
        color: Colors.black,
        padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(right: 10),
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(AppImages().imageFooter),
                    ),
                  ),
                ),
                Text(
                  AppString().judul,
                  style: whiteTextStyle.copyWith(fontSize: 22),
                ),
              ],
            ),

            SizedBox(height: 12),

            Text(
              'Platform untuk bengkel dan customer bengkel\n'
              'yang memberikan kemudahan berkaitan dengan\n'
              'perawatan kendaraan',
              style: whiteTextStyle.copyWith(fontSize: 12),
            ),

            SizedBox(height: 30),

            Text(
              'Learn More',
              style: whiteTextStyle.copyWith(fontSize: 16, fontWeight: bold),
            ),
            SizedBox(height: 10),
            Text('Tentang Kami', style: greyTextStyle.copyWith(fontSize: 12)),
            SizedBox(height: 6),
            Text('Layanan', style: greyTextStyle.copyWith(fontSize: 12)),

            SizedBox(height: 25),

            Text('Contact Us', style: whiteTextStyle.copyWith(fontSize: 16)),
            SizedBox(height: 10),
            Text(
              'Term of Services',
              style: greyTextStyle.copyWith(fontSize: 12),
            ),
            SizedBox(height: 6),
            Text('Privacy Policy', style: greyTextStyle.copyWith(fontSize: 12)),

            SizedBox(height: 25),

            Text('Social Media', style: whiteTextStyle),
            SizedBox(height: 10),
            Row(
              children: [
                Image.asset(AppImages().instagram, width: 32),
                SizedBox(width: 10),
                Image.asset(AppImages().facebook, width: 32),
              ],
            ),
          ],
        ),
      );
    }

    Widget mobileWidget() {
      return Column(
        children: [
          heroSectionContent(),
          Container(
            width: 90.w,
            height: 50.h,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppImages().imageHomePage1),
                fit: BoxFit.contain,
              ),
            ),
          ),
          SizedBox(height: 5.h),
          // Section Fitur Terbaik
          featureListSection(),
          SizedBox(height: 5.h),
          plusPoint(),
          servicesWidget(),

          Column(
            children: [
              reasonSectionMobile(),
              chooseUsMobile(),
              locationMobile(),
              SizedBox(height: 10.h),
              personalDataMobile(),
              footerMobile(),
            ],
          ),
        ],
      );
    }

    Widget desktopWidget() {
      return Column(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/images/Indocool-Provide-Radiator-for-Multi-Sector-2 1_result.webp',
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 10.w,
                vertical: 10.h,
              ), // Padding global di Desktop
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: heroSectionContent()), // Kolom kiri
                ],
              ),
            ),
          ),
          industry(),
          // SizedBox(height: 10.h),
          // Section Fitur Terbaik
          Container(
            color: kWhiteColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 260, top: 75),
                  child: Text(
                    AppString().featureListSectionTitle,
                    style: isDesktop(screenWidth)
                        ? blackTextStyle.copyWith(
                            fontSize: isDesktop(screenWidth) ? 20.sp : 16.sp,
                            fontWeight: bold,
                          )
                        : blackTextStyle.copyWith(
                            fontSize: isDesktop(screenWidth) ? 20.sp : 16.sp,
                            fontWeight: bold,
                          ),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        // Gambar di kiri
                        width: 438,
                        height: 618,
                        margin: EdgeInsets.only(
                          left: 5.w,
                        ), // Sedikit margin ke kiri
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(AppImages().imageHomePage3),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: featureListSection(),
                    ), // Daftar Fitur di kanan
                  ],
                ),
              ],
            ),
          ),

          plusPoint(),
          servicesWidget(),

          reasonSection(),

          chooseUs(),

          location(),

          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //   children: [
          //     Expanded(child: questionHeroSectionContent()),
          //     Expanded(child: questionListSection()), // Daftar Fitur di kanan
          //   ],
          // ),
          SizedBox(height: 10.h),
        ],
      );
    }

    Widget search() {
      return GetBuilder<Homecontroller>(
        builder: (controller) {
          return TypeAheadField<AllDataModel>(
            builder: (context, controller, focusNode) => Container(
              height: 60,

              child: Center(
                child: TextFormField(
                  controller: controller,
                  focusNode: focusNode,

                  decoration: InputDecoration(
                    filled: true,
                    fillColor: kGreyColor,
                    suffixIcon: Icon(Icons.search),
                    border: InputBorder.none,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: kGreyColor),
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: kGreyColor),
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    hint: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Cari berdasarkan plat number',
                            style: blackTextStyle.copyWith(
                              fontSize: 10.sp,
                              fontWeight: light,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            debounceDuration: const Duration(milliseconds: 500),
            itemBuilder: (context, value) {
              return ListTile(
                leading: const Icon(Icons.directions_car),
                title: Text(value.platNumber?.platNumber ?? ''),
                subtitle: Text(value.coreTypeModel?.coreType ?? ''),
              );
            },
            onSelected: (value) {
              Get.to(DetailProduct(allDataModel: value));
            },
            suggestionsCallback: (search) async {
              if (search.isEmpty) return [];
              await controller.getDatabyPlatNumber(search);

              return controller.allDataModel;
            },
          );
        },
      );
    }

    return GetBuilder<Homecontroller>(
      builder: (controller) {
        return AnimatedOpacity(
          opacity: _visible ? 1 : 0,
          duration: const Duration(milliseconds: 500),
          child: Globalappbar(
            isNeedScrollButton: true,
            pageWidget: SingleChildScrollView(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  // Tentukan layout berdasarkan lebar layar
                  final width = constraints.maxWidth;

                  if (isDesktop(width)) {
                    return desktopWidget();
                  } else {
                    return mobileWidget();
                  }
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
