import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/Utility/date_time_helper.dart';
import 'package:project/appbar/list_home.dart';
import 'package:project/blog/model/blog_model.dart';
import 'package:project/controller/globalController.dart';
import 'package:project/controller/homeController.dart';
import 'package:project/controller/mainProductController.dart';
import 'package:project/custom_text_field.dart';
import 'package:project/detail_location.dart';
import 'package:project/global_widget/appPreCache.dart';
import 'package:project/global_widget/featureCard.dart';
import 'package:project/global_widget/globalAppBar.dart';
import 'package:project/global_widget/globalLoadingWidget.dart';
import 'package:project/logoChooseUS.dart';
import 'package:project/model/featureCardModel.dart';
import 'package:project/model/serviceModel.dart';
import 'package:project/routes/routes_name.dart';
import 'package:project/theme/app_images.dart';
import 'package:project/theme/string.dart';
import 'package:project/theme/theme.dart';
import 'package:outlined_text/outlined_text.dart';
import 'package:sizer/sizer.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentProductIndex = 0;
  List<bool> expandedIcons = [false, false, false, false, false];
  bool _visible = false;
  bool isDesktop(double width) => width >= 900;

  bool isTablet(double width) => width >= 600 && width < 900;
  ExpandableCarouselController carouselController =
      ExpandableCarouselController();
  bool isMobile(double width) => width < 600;
  var homecontroller = Get.find<HomeController>();
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
    Widget nextProduct({
      required VoidCallback onTap,
      required int index,
      required int totalPage,
    }) {
      final bool isLastPage = index >= totalPage - 1;

      return InkWell(
        onTap: isLastPage ? null : onTap,
        child: Container(
          width: 150,
          height: 150,

          child: Center(
            child: Image.asset(
              isLastPage
                  ? 'assets/images/Button-Next 3.png'
                  : 'assets/images/Button-Next 1.png',
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
          ),
        ),
      );
    }

    Widget BackProduct({required VoidCallback onTap, required int index}) {
      final bool isFirstPage = index == 0;

      return InkWell(
        onTap: isFirstPage ? null : onTap,
        child: Container(
          width: 150,
          height: 150,
          child: Center(
            child: Image.asset(
              isFirstPage
                  ? 'assets/images/Button-Back 1.png'
                  : 'assets/images/Button-Back 2.png',
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
          ),
        ),
      );
    }

    Widget nextButton({required VoidCallback onTap, isServices = false}) {
      return InkWell(
        onTap: onTap,
        child: Container(
          width: (isServices) ? 80 : 45,
          height: (isServices) ? 30 : 85,
          decoration: BoxDecoration(
            color: (isServices == false) ? Colors.grey.shade300 : darkblue,
            shape: BoxShape.circle,
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
      return InkWell(
        onTap: onTap,
        child: Container(
          width: 45,
          height: 80,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            shape: BoxShape.circle,
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
            4,
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
                    style: blackTextStyle.copyWith(
                      fontSize: 12.sp,
                      fontWeight: semiBold,
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
                          onPageChanged: (index, reason) {
                            setState(() {
                              currentProductIndex = index;
                            });
                          },
                        ),
                      )
                    : Column(
                        children: [
                          // =========================
                          // CAROUSEL
                          // =========================
                          ExpandableCarousel(
                            items: grouped.map((group) {
                              return Row(
                                children: [
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
                                ],
                              );
                            }).toList(),

                            options: ExpandableCarouselOptions(
                              controller: carouselController,
                              viewportFraction: 1,
                              enableInfiniteScroll: false,
                              autoPlay: false,
                              onPageChanged: (index, reason) {
                                setState(() {
                                  currentProductIndex = index;
                                });
                              },
                            ),
                          ),

                          const SizedBox(height: 20),

                          // =========================
                          // TOMBOL DI BAWAH
                          // =========================
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              BackProduct(
                                index: currentProductIndex,
                                onTap: () {
                                  carouselController.previousPage(
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.linear,
                                  );
                                },
                              ),

                              const SizedBox(width: 20),

                              nextProduct(
                                index: currentProductIndex,
                                totalPage: grouped.length,
                                onTap: () {
                                  carouselController.nextPage(
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.linear,
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
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
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(serviceModel?.imageUrl ?? ''),

              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      serviceModel?.serviceName ?? '',
                      style: blackTextStyle.copyWith(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  nextButton(
                    onTap: () {
                      Get.toNamed(AppRouteName.services);
                    },
                    isServices: true,
                  ),
                ],
              ),

              const SizedBox(height: 8),

              Text(
                serviceModel?.description ?? '',
                textAlign: TextAlign.left,
                style: blackTextStyle.copyWith(fontSize: 14),
              ),
            ],
          ),
        ),
      );
    }

    Widget servicesWidget() {
      return Container(
        color: Color(0xffF4F4F4),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(top: 40),
              child: Text(
                'Radiator or Heat Exchanger Service and Repair Specialist',
                style: blackTextStyle.copyWith(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              margin: EdgeInsets.only(left: 32, right: 32),
              child: Text(
                'Indocool can carry out minor repairs or complete overhauls to most makes and models of industrial cooling system components.\nRadiators, oil coolers,and heat exchangers, within the mining, oil & gas, marine, industrial power generation, and general industries.',
                textAlign: TextAlign.center,
                style: blackTextStyle.copyWith(
                  fontSize: 18,
                  fontWeight: semiBold,
                ),
              ),
            ),
            SizedBox(height: 20.sp),
            Row(
              children: [
                SizedBox(width: 10.w),
                ...List.generate(homecontroller.serviceModel?.length ?? 0, (
                  index,
                ) {
                  return servicesContentWidget(
                    homecontroller.serviceModel?[index],
                  );
                }),
                SizedBox(width: 10.w),
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
        width: double.infinity,
        color: kLigtblueColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 30),

            // =========================
            // JUDUL DENGAN BORDER
            // =========================
            Container(
              width: 480,
              height: 52,
              margin: EdgeInsets.symmetric(horizontal: 14),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Color(0xff0054A6),
                border: Border.all(color: Color(0xffffd900), width: 2),
              ),
              child: Text(
                'THE REASON OUR CUSTOMERS CHOOSE US',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xffffd900),
                  fontSize: 23,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),

            SizedBox(height: 50),

            // =========================
            // TEXT CONTENT
            // =========================
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text(
                      'Proven Through 17,000+ Successful\n'
                      'Projects Across Domestic and\n'
                      'International Industries',
                      style: whiteTextStyle.copyWith(
                        fontSize: 24,
                        fontWeight: bold,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    SizedBox(height: 24),

                    Text(
                      'With over 17,000+ successful projects completed,\n'
                      'our track record reflects decades of engineering\n'
                      'experience, technical capability, and trusted\n'
                      'partnerships across domestic and international\n'
                      'industries.',
                      style: whiteTextStyle.copyWith(
                        fontWeight: regular,
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      'ISO 9001, 14001, 45001\nCertified Company',
                      style: whiteTextStyle.copyWith(
                        fontSize: 24,
                        fontWeight: bold,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    SizedBox(height: 24),

                    Text(
                      'We are committed to setting globally recognized\nstandards (ISO) in quality, environmental, and\noccupational health and safety management\nsystems. We strive to provide the best services\nand products to our customers.',
                      style: whiteTextStyle.copyWith(
                        fontWeight: regular,
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      'Proudly Manufactured in Indonesia,\nEnhanced by Australian Engineering\nKnowledge',
                      style: whiteTextStyle.copyWith(
                        fontSize: 24,
                        fontWeight: bold,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    SizedBox(height: 24),

                    Text(
                      'Proudly made in Indonesia, we combine local\nmanufacturing excellence with engineering\nexpertise to deliver high-quality cooling solutions\nthat meet global industry standards.',
                      style: whiteTextStyle.copyWith(
                        fontWeight: regular,
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ],
            ),

            SizedBox(height: 50),
          ],
        ),
      );
    } // Widget headerProduct({String? description, String? image}) {
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
            margin: const EdgeInsets.symmetric(horizontal: 10),
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

                SizedBox(
                  height: 56,
                  child: Center(
                    child: Text(
                      description ?? '',
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: blackTextStyle.copyWith(
                        fontSize: 20,
                        fontWeight: bold,
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

    Widget industry() {
      final isDesktop = MediaQuery.of(context).size.width > 1500;
      return Container(
        width: double.infinity,
        color: Color(0xffE8F2FF),
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
                        style: blackTextStyle.copyWith(
                          fontSize: 20,
                          fontWeight: bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'From heavy-duty radiators and industrial cooling systems to repair services,\nengine coolants, and spare parts, Indocool delivers reliable solutions to \nmaximize equipment performance and minimize downtime.',
                        style: blackTextStyle.copyWith(
                          fontSize: 20,
                          fontWeight: bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 70),
            Container(
              child: Text(
                'INDUSTRY WE SUPPORT:',
                style: blackTextStyle.copyWith(fontSize: 29, fontWeight: bold),
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
                    Container(
                      child: Flexible(
                        child: headerProduct(
                          description: AppString().productHeaderDescription6,
                          image: AppImages().imgHeaderProduct6,
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: isDesktop(screenWidth) ? 55.h : 5.h),
          Container(
            // Hapus margin tetap, ganti dengan Padding atau alignment
            padding: EdgeInsets.symmetric(
              horizontal: isDesktop(screenWidth) ? 0 : 5.w,
            ),
            child: OutlinedText(
              text: Text(
                AppString().titleLandingPage1,
                style: blackTextStyle.copyWith(
                  fontSize: isDesktop(screenWidth)
                      ? 50
                      : 24.sp, // Ukuran font responsif
                  fontWeight: bold,
                  height: 1.0,
                ),
                textAlign: TextAlign.center,
              ),
              strokes: [OutlinedTextStroke(color: Colors.white, width: 7)],
            ),
          ),
          SizedBox(height: isDesktop(screenWidth) ? 30.h : 5.h),
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
              InkWell(
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
              InkWell(
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

              InkWell(
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

              InkWell(
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

              InkWell(
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
              warna: isMobile(screenWidth) ? whiteTextStyle : whiteTextStyle,
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
                      style: whiteTextStyle.copyWith(
                        fontSize: (isMobile(screenWidth)) ? 14.sp : 12.sp,
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
                        ? whiteTextStyle
                        : whiteTextStyle,
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
                            style: whiteTextStyle.copyWith(
                              fontSize: (isMobile(screenWidth)) ? 14.sp : 12.sp,
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
                        ? whiteTextStyle
                        : whiteTextStyle,
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
                            AppString().listHomeSubtitle3,
                            style: whiteTextStyle.copyWith(
                              fontSize: (isMobile(screenWidth)) ? 14.sp : 12.sp,
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
                    nomer: AppString().listHomeNumber4,
                    title: AppString().listHomeTitle4,
                    warna: isMobile(screenWidth)
                        ? whiteTextStyle
                        : whiteTextStyle,
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
                            style: whiteTextStyle.copyWith(
                              fontSize: (isMobile(screenWidth)) ? 14.sp : 12.sp,
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
          margin: EdgeInsets.only(top: 50, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(left: 29.w),
                child: Text(
                  'LOCATIONS',
                  style: blackTextStyle.copyWith(
                    fontWeight: bold,
                    fontSize: 36,
                  ),
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    margin: EdgeInsets.only(),
                    width: 950,
                    height: 390,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          'assets/images/MAP-Indocool-1 1_result.webp',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: 574,
                        height: 250,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                              'assets/images/Indocool-Indonesia-Australia-2 1_result.webp',
                            ),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.only(right: 120),
                        child: Text(
                          'We are a company with more than 47 years of experience in maintenance,\nrepair, service, manufacturing, and fabrication of radiators & heat exchangers\nin Indonesia. We have 5 facilities in Java, Kalimantan, and Batam, and we\nhave a mission to be the best company in Southeast Asia in the Radiator &\nHeat Exchanger industry.',
                          style: blackTextStyle.copyWith(
                            fontWeight: regular,
                            fontSize: 18,
                          ),
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
            image: AssetImage('assets/images/Rectangle 81.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 33, left: 260, top: 40),
                  child: Text(
                    'GLOBAL MARKETS',
                    style: whiteTextStyle.copyWith(
                      fontSize: 40,
                      fontWeight: bold,
                    ),
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
            Container(
              width: 880,
              height: 373,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/Indonesian-Map 1.png'),
                  fit: BoxFit.cover,
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

    Widget insightNewsCard({required BlogModel blog}) {
      return InkWell(
        onTap: () {
          Get.toNamed(AppRouteName.blogDetail, parameters: {'id': blog.id});
        },
        child: Container(
          margin: const EdgeInsets.only(right: 35),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // IMAGE
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CachedNetworkImage(
                  imageUrl: blog.imageUrl,
                  fit: BoxFit.cover,
                  height: 250,
                  width: double.infinity,

                  placeholder: (_, __) =>
                      const Center(child: CircularProgressIndicator()),
                  errorWidget: (_, __, ___) => const Icon(
                    Icons.broken_image,
                    size: 55,
                    color: Colors.white,
                  ),
                ),
              ),

              const SizedBox(height: 15),

              // CATEGORY + DATE
              Container(
                width: double.infinity,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFFC8E9FF),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      height: 40,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: const Color(0xFF0864C5),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Text(
                        blog.type,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    const Spacer(),

                    Padding(
                      padding: const EdgeInsets.only(right: 18),
                      child: Text(
                        blog.createdAt != null
                            ? DateHelper.formatDate(blog.createdAt!)
                            : '',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 18),

              // TITLE
              Text(
                blog.title,
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  height: 1.2,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      );
    }

    Widget insightNewsSection() {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Garis atas
            Container(width: double.infinity, height: 1, color: Colors.black),

            const SizedBox(height: 35),

            Text(
              'Indocool Insight and News',
              style: GoogleFonts.inter(
                fontSize: 28,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),

            const SizedBox(height: 40),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(
                homecontroller.top3Blogs.length,
                (index) => Expanded(
                  child: insightNewsCard(blog: homecontroller.top3Blogs[index]),
                ),
              ),
            ),

            const SizedBox(height: 50),

            // See More Content
            Center(
              child: InkWell(
                onTap: () {
                  Get.toNamed(AppRouteName.blogList);
                },
                child: Container(
                  width: 300,
                  height: 55,
                  decoration: BoxDecoration(
                    color: const Color(0xFFD6EEFF),
                    border: Border.all(color: Colors.black, width: 1),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'See More Content',
                        style: GoogleFonts.inter(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),

                      const SizedBox(width: 30),

                      const Icon(
                        Icons.arrow_forward,
                        size: 24,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget desktopWidget() {
      return Column(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppImages().homeimg),
                fit: BoxFit.fill,
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
          Divider(color: Colors.black, thickness: 5, height: 1),
          industry(),
          // SizedBox(height: 10.h),
          // Section Fitur Terbaik
          Divider(color: Colors.black, thickness: 5, height: 1),
          Container(
            color: Color(0xff005CBC),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                Center(
                  child: Container(
                    child: Text(
                      AppString().featureListSectionTitle,
                      style: isDesktop(screenWidth)
                          ? whiteTextStyle.copyWith(
                              fontSize: isDesktop(screenWidth) ? 20.sp : 16.sp,
                              fontWeight: bold,
                            )
                          : whiteTextStyle.copyWith(
                              fontSize: isDesktop(screenWidth) ? 20.sp : 16.sp,
                              fontWeight: bold,
                            ),
                    ),
                  ),
                ),
                SizedBox(height: 100),
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
                SizedBox(height: 113),
              ],
            ),
          ),
          Divider(color: Colors.black, thickness: 5, height: 1),
          plusPoint(),
          Divider(color: Colors.black, thickness: 5, height: 1),
          servicesWidget(),
          Divider(color: Colors.black, thickness: 5, height: 1),
          reasonSection(),
          Divider(color: Colors.black, thickness: 5, height: 1),
          chooseUs(),
          Divider(color: Colors.black, thickness: 5, height: 1),
          location(),

          insightNewsSection(),
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

    return GetBuilder<HomeController>(
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
