// ... imports Anda yang sudah ada ...
import 'dart:ui_web';

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:project/appbar/appbar_element.dart';
import 'package:project/appbar/list_home.dart';
import 'package:project/controller/homeController.dart';
import 'package:project/detail_location.dart';
import 'package:project/detail_product.dart';
import 'package:project/global%20widget/featureCard.dart';
import 'package:project/logoChooseUS.dart';
import 'package:project/model/allDataModel.dart';
import 'package:project/model/featureCardModel.dart';
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
  // bool isExpanded = false;
  // Tentukan breakpoint (Anda dapat menyesuaikannya)
  bool isDesktop(double width) => width >= 900;

  bool isTablet(double width) => width >= 600 && width < 900;

  bool isMobile(double width) => width < 600;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Data fitur tetap sama
    final List<Feature> featureData = [
      Feature('assets/images/D85ESS-Transp 1.png', "Removable Tube Radiator"),
      Feature('assets/images/D375-Transp 1.png', "Conventional Radiator Core"),
      Feature(
        'assets/images/777E-Transp 1.png',
        "Aluminum Plate & Bar\nCooler & Heat Exchanger",
      ),
    ];
    final List<Feature> secondfeatureData = [
      Feature('assets/images/D85ESS-Transp 1.png', "Removable Tube Radiator"),
      Feature('assets/images/D375-Transp 1.png', "Conventional Radiator Core"),
      Feature(
        'assets/images/777E-Transp 1.png',
        "Aluminum Plate & Bar\nCooler & Heat Exchanger",
      ),
    ];

    Widget plusPoint() {
      // Ambil lebar layar sekali untuk penggunaan isMobile di luar LayoutBuilder
      final screenWidth = MediaQuery.of(context).size.width;

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
            Padding(
              // Menggunakan isMobile di sini
              padding: EdgeInsets.symmetric(
                horizontal: isMobile(screenWidth) ? 5.w : 15.w,
              ),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  // Menetapkan crossAxisCount berdasarkan lebar lokal GridView (constraints.maxWidth)
                  int crossAxisCount = 1;
                  if (constraints.maxWidth > 900) {
                    crossAxisCount = 3;
                  } else if (constraints.maxWidth > 600) {
                    crossAxisCount = 2;
                  } else {
                    crossAxisCount = 1;
                  }

                  // **PENTING: Logika childAspectRatio**
                  // Tetapkan rasio aspek untuk menentukan tinggi item: lebar / tinggi
                  double aspect_ratio;
                  if (crossAxisCount == 1) {
                    // Jika 1 kolom (Mobile), rasio aspek harus besar (lebar >> tinggi) untuk kartu vertikal yang ramping.
                    aspect_ratio =
                        0.90; // Disesuaikan sedikit lebih besar dari 5 agar kartu lebih ramping
                  } else if (crossAxisCount == 2) {
                    // Jika 2 kolom (Tablet), rasio aspek harus lebih kecil untuk memberikan ruang vertikal lebih banyak.
                    aspect_ratio = 0.9;
                  } else {
                    // Jika 3 kolom (Desktop), rasio aspek harus kecil.
                    aspect_ratio = 0.50;
                  }
                  //

                  return GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 3.w,
                      mainAxisSpacing: 3.h,
                      childAspectRatio:
                          aspect_ratio, // Menggunakan nilai dinamis
                    ),
                    itemCount: featureData.length,
                    itemBuilder: (context, index) {
                      return featureCard(
                        title: featureData[index].title,

                        image: featureData[index].image,
                        isMobile: isMobile(screenWidth),
                      );
                    },
                  );
                },
              ),
            ),
            SizedBox(height: 5.h),
          ],
        ),
      );
    }

    Widget secondPlusPoint() {
      // Ambil lebar layar sekali untuk penggunaan isMobile di luar LayoutBuilder
      final screenWidth = MediaQuery.of(context).size.width;

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
            Padding(
              // Menggunakan isMobile di sini
              padding: EdgeInsets.symmetric(
                horizontal: isMobile(screenWidth) ? 5.w : 15.w,
              ),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  // Menetapkan crossAxisCount berdasarkan lebar lokal GridView (constraints.maxWidth)
                  int crossAxisCount = 1;
                  if (constraints.maxWidth > 900) {
                    crossAxisCount = 3;
                  } else if (constraints.maxWidth > 600) {
                    crossAxisCount = 2;
                  } else {
                    crossAxisCount = 1;
                  }

                  // **PENTING: Logika childAspectRatio**
                  // Tetapkan rasio aspek untuk menentukan tinggi item: lebar / tinggi
                  double aspect_ratio;
                  if (crossAxisCount == 1) {
                    // Jika 1 kolom (Mobile), rasio aspek harus besar (lebar >> tinggi) untuk kartu vertikal yang ramping.
                    aspect_ratio =
                        0.90; // Disesuaikan sedikit lebih besar dari 5 agar kartu lebih ramping
                  } else if (crossAxisCount == 2) {
                    // Jika 2 kolom (Tablet), rasio aspek harus lebih kecil untuk memberikan ruang vertikal lebih banyak.
                    aspect_ratio = 0.9;
                  } else {
                    // Jika 3 kolom (Desktop), rasio aspek harus kecil.
                    aspect_ratio = 0.50;
                  }
                  //

                  return GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 3.w,
                      mainAxisSpacing: 3.h,
                      childAspectRatio:
                          aspect_ratio, // Menggunakan nilai dinamis
                    ),
                    itemCount: secondfeatureData.length,
                    itemBuilder: (context, index) {
                      return featureCard(
                        title: secondfeatureData[index].title,

                        image: secondfeatureData[index].image,
                        isMobile: isMobile(screenWidth),
                      );
                    },
                  );
                },
              ),
            ),
            SizedBox(height: 5.h),
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
            image: AssetImage('assets/images/Rectangle 39 (1).png'),
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
        width: 100.w,
        height: 65.h,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/Rectangle 39 (1).png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 64),
              child: Text(
                'The Reason They Choose Us',
                style: whiteTextStyle.copyWith(fontWeight: bold, fontSize: 36),
              ),
            ),
            SizedBox(height: 48),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Container(
                      child: Text(
                        'ISO 9001, 14001, 45001\nCompany Certified',
                        style: whiteTextStyle.copyWith(
                          fontWeight: bold,
                          fontSize: 24,
                        ),
                      ),
                    ),
                    Container(
                      child: Text(
                        textAlign: TextAlign.center,
                        'We are committed to setting globally\nrecognized standards (ISO) in\nquality, environmental, and\noccupational health and safety\nmanagement systems. We strive to\nprovide the best services and\nproducts to our customers.',
                        style: whiteTextStyle.copyWith(
                          fontWeight: regular,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),

                Column(
                  children: [
                    Container(
                      child: Text(
                        '17.000+ Projects Handled',
                        style: whiteTextStyle.copyWith(
                          fontWeight: bold,
                          fontSize: 24,
                        ),
                      ),
                    ),
                    Container(
                      child: Text(
                        textAlign: TextAlign.center,
                        'A testament to our extensive\nexperience and trusted expertise,\nwe have successfully delivered over\n17.000 projects across various\nindustries, ensuring quality and\nreliability. We are still counting on\nmore project.',
                        style: whiteTextStyle.copyWith(
                          fontWeight: regular,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),

                Column(
                  children: [
                    Container(
                      child: Text(
                        '17.000+ Projects Handled',
                        style: whiteTextStyle.copyWith(
                          fontWeight: bold,
                          fontSize: 24,
                        ),
                      ),
                    ),
                    Container(
                      child: Text(
                        textAlign: TextAlign.center,
                        'A testament to our extensive\nexperience and trusted expertise,\nwe have successfully delivered over\n17.000 projects across various\nindustries, ensuring quality and\nreliability. We are still counting on\nmore project.',
                        style: whiteTextStyle.copyWith(
                          fontWeight: regular,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
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
            // Hapus margin tetap, ganti dengan Padding atau alignment
            padding: EdgeInsets.symmetric(
              horizontal: isDesktop(screenWidth) ? 0 : 5.w,
            ),
            child: Text(
              AppString().titleLandingPage1,
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
              style: greyTextStyle.copyWith(fontWeight: light, fontSize: 14.sp),
              textAlign: isDesktop(screenWidth)
                  ? TextAlign.left
                  : TextAlign.center,
            ),
          ),

          Container(
            margin: EdgeInsets.only(top: isDesktop(screenWidth) ? 3.h : 3.h),
            child: Row(
              mainAxisAlignment: isDesktop(screenWidth)
                  ? MainAxisAlignment.start
                  : MainAxisAlignment.center,
              children: [
                // TOMBOL BIRU
                ElevatedButton.icon(
                  onPressed: () {},
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
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        12,
                      ), // Membuat sudut melengkung
                    ),
                  ),
                ),

                SizedBox(width: 15), // Jarak antar tombol
                // TOMBOL PUTIH
                OutlinedButton.icon(
                  onPressed: () {},
                  icon: Text(
                    "Learn More",
                    style: TextStyle(color: Colors.black),
                  ),
                  label: Icon(
                    Icons.arrow_forward,
                    color: Colors.black,
                    size: isDesktop(screenWidth) ? 12.sp : 17.sp,
                  ),
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
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
          SizedBox(height: isDesktop(screenWidth) ? 10.h : 5.h),
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
            Text(
              AppString().featureListSectionTitle,
              style: isDesktop(screenWidth)
                  ? whiteTextStyle.copyWith(
                      fontSize: isDesktop(screenWidth) ? 20.sp : 16.sp,
                      fontWeight: bold,
                    )
                  : blackTextStyle.copyWith(
                      fontSize: isDesktop(screenWidth) ? 20.sp : 16.sp,
                      fontWeight: bold,
                    ),
            ),
            SizedBox(height: 3.h),
            ListHome(
              nomer: AppString().listHomeNumber1,
              title: AppString().listHomeTitle1,
              warna: isMobile(screenWidth) ? blackTextStyle : whiteTextStyle,
            ),
            SizedBox(height: 1.5.h),
            Text(
              AppString().listHomeSubtitle,
              style: greyTextStyle.copyWith(
                fontSize: (isMobile(screenWidth)) ? 14.sp : 10.sp,
                fontWeight: semiBold,
              ),
            ),
            Container(
              height: 2,
              width: double.infinity,
              color: Colors.grey.shade300,
              margin: EdgeInsets.symmetric(vertical: 2.h),
            ),

            // Item 02 s/d 05
            ListHome(
              warna: isMobile(screenWidth) ? blackTextStyle : whiteTextStyle,
              nomer: AppString().listHomeNumber2,
              title: AppString().listHomeTitle2,
            ),
            Container(
              height: 2,
              width: double.infinity,
              color: Colors.grey.shade300,
              margin: EdgeInsets.symmetric(vertical: 2.h),
            ),
            ListHome(
              warna: isMobile(screenWidth) ? blackTextStyle : whiteTextStyle,
              nomer: AppString().listHomeNumber3,
              title: AppString().listHomeTitle3,
            ),
            Container(
              height: 2,
              width: double.infinity,
              color: Colors.grey.shade300,
              margin: EdgeInsets.symmetric(vertical: 2.h),
            ),
            ListHome(
              warna: isMobile(screenWidth) ? blackTextStyle : whiteTextStyle,
              nomer: AppString().listHomeNumber4,
              title: AppString().listHomeTitle4,
            ),
            Container(
              height: 2,
              width: double.infinity,
              color: Colors.grey.shade300,
              margin: EdgeInsets.symmetric(vertical: 2.h),
            ),
            ListHome(
              warna: isMobile(screenWidth) ? blackTextStyle : whiteTextStyle,
              nomer: AppString().listHomeNumber5,
              title: AppString().listHomeTitle5,
            ),
            Container(
              height: 2,
              width: double.infinity,
              color: Colors.grey.shade300,
              margin: EdgeInsets.symmetric(vertical: 2.h),
            ),
            ListHome(
              warna: isMobile(screenWidth) ? blackTextStyle : whiteTextStyle,
              nomer: AppString().listHomeNumber6,
              title: AppString().listHomeTitle6,
            ),
            Container(
              height: 2,
              width: double.infinity,
              color: Colors.grey.shade300,
              margin: EdgeInsets.symmetric(vertical: 2.h),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Office & Workshop Location',
                    style: blackTextStyle.copyWith(
                      fontWeight: bold,
                      fontSize: 36,
                    ),
                  ),
                  Text(
                    '100% Made in Indonesia\nand by Indonesian Hands',
                    style: blackTextStyle.copyWith(
                      fontWeight: bold,
                      fontSize: 24,
                    ),
                  ),
                ],
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
                        image: AssetImage('assets/images/MAP-Indocool-1 1.png'),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 140),
                        child: Text(
                          'INDOCOOL GROUP, a leading name in the industrial\ncooling system sector, is dedicated to excellence\nand innovation. The group oversees two dynamic\nsubsidiaries:\n(1)PT Indocool Solusi Cemerlang (Bogor,\nBalikpapan, & Sangatta)\n(2)PT Indocool Rekayasa Batam (Batam Island)',
                          style: blackTextStyle.copyWith(fontWeight: regular),
                        ),
                      ),
                      SizedBox(height: 15),
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
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DetailLocation(
                    number: 'assets/images/1 8.png',
                    factory: 'assets/images/Rectangle 9.png',
                    title: 'Bogor Head Office & Workshop',
                  ),
                  DetailLocation(
                    number: 'assets/images/2 1.png',
                    factory: 'assets/images/Rectangle 10.png',
                    title: 'Balikpapan Office & Workshop',
                  ),
                  DetailLocation(
                    number: 'assets/images/3 1.png',
                    factory: 'assets/images/Rectangle 11.png',
                    title: 'Sangatta Office & Workshop',
                  ),
                  DetailLocation(
                    number: 'assets/images/4 6754.png',
                    factory: 'assets/images/Rectangle 12.png',
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
                  image: AssetImage('assets/images/MAP-Indocool-1 1.png'),
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
                    number: 'assets/images/1 8.png',
                    factory: 'assets/images/Rectangle 9.png',
                    title: 'Bogor Head Office & Workshop',
                  ),
                  SizedBox(width: 20),
                  DetailLocation(
                    number: 'assets/images/2 1.png',
                    factory: 'assets/images/Rectangle 10.png',
                    title: 'Balikpapan Office & Workshop',
                  ),
                  SizedBox(width: 20),
                  DetailLocation(
                    number: 'assets/images/3 1.png',
                    factory: 'assets/images/Rectangle 11.png',
                    title: 'Sangatta Office & Workshop',
                  ),
                  SizedBox(width: 20),
                  DetailLocation(
                    number: 'assets/images/4 6754.png',
                    factory: 'assets/images/Rectangle 12.png',
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
                    Logochooseus(image: 'assets/images/AMMAN Logo 1.png'),
                    Logochooseus(image: 'assets/images/Logo-Madhani 1.png'),
                    Logochooseus(image: 'assets/images/Logo-KPC 1.png'),
                    Logochooseus(image: 'assets/images/image 1.png'),
                    Logochooseus(
                      image: 'assets/images/Logo-Cipta-Andalan-Teknindo 1.png',
                    ),
                    Logochooseus(image: 'assets/images/Logo-Thriveni 1.png'),
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
        color: kWhiteColor,
        width: 100.w,
        child: Column(
          children: [
            Text(
              'Those Who Choose Us',
              style: blackTextStyle.copyWith(fontWeight: bold, fontSize: 36),
            ),
            Row(
              children: [
                Logochooseus(image: 'assets/images/AMMAN Logo 1.png'),
                Logochooseus(image: 'assets/images/Logo-Madhani 1.png'),
                Logochooseus(image: 'assets/images/Logo-KPC 1.png'),
                Logochooseus(image: 'assets/images/image 1.png'),
                Logochooseus(
                  image: 'assets/images/Logo-Cipta-Andalan-Teknindo 1.png',
                ),
                Logochooseus(image: 'assets/images/Logo-Thriveni 1.png'),
              ],
            ),
          ],
        ),
      );
    }

    Widget footer() {
      return Container(
        height: 180,
        width: double.infinity,
        color: Colors.black,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 50, top: 30),
                  child: Row(
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
                        style: whiteTextStyle.copyWith(fontSize: 25),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  margin: EdgeInsets.only(left: 50),
                  child: Text(
                    'Platform untuk bengkel dan customer bengkel\nyang memberikan kemudahan bekaitan dengan\nperawatan kendaraan',
                    style: whiteTextStyle.copyWith(
                      fontSize: isMobile(screenWidth) ? 10 : 14,
                    ),
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Learn More',
                  style: whiteTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: bold,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Tentang Kami',
                  style: greyTextStyle.copyWith(
                    fontWeight: medium,
                    fontSize: 12,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Layanan',
                  style: greyTextStyle.copyWith(
                    fontWeight: medium,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Contact Us',
                  style: whiteTextStyle.copyWith(fontSize: 16),
                ),
                SizedBox(height: 15),
                Text(
                  'Term of Services',
                  style: greyTextStyle.copyWith(
                    fontWeight: medium,
                    fontSize: 12,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Privacy Policy',
                  style: greyTextStyle.copyWith(
                    fontWeight: medium,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Sosial Media', style: whiteTextStyle),
                SizedBox(height: 20),
                Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(AppImages().instagram),
                        ),
                      ),
                    ),
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(AppImages().facebook),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
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

          Column(
            children: [
              reasonSectionMobile(),
              chooseUsMobile(),
              locationMobile(),
              SizedBox(height: 10.h),
              footerMobile(),
            ],
          ),
        ],
      );
    }

    Widget desktopWidget() {
      return Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 10.w,
              vertical: 10.h,
            ), // Padding global di Desktop
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: heroSectionContent()), // Kolom kiri
                Expanded(
                  child: Container(
                    // Hapus margin tetap dan batasi lebar/tinggi dengan Expanded
                    width: double.infinity,
                    height: 50.h, // Tinggi responsif
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(AppImages().imageHomePage1),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ), // Kolom kanan
              ],
            ),
          ),
          SizedBox(height: 10.h),
          // Section Fitur Terbaik
          Container(
            color: kLigtblueColor,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    // Gambar di kiri
                    width: double.infinity,
                    height: 100.h,
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
                Expanded(child: featureListSection()), // Daftar Fitur di kanan
              ],
            ),
          ),
          SizedBox(height: 10.h),

          plusPoint(),
          plusPoint(),
          reasonSection(),
          SizedBox(height: 10.h),
          chooseUs(),
          SizedBox(height: 10.h),
          location(),

          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //   children: [
          //     Expanded(child: questionHeroSectionContent()),
          //     Expanded(child: questionListSection()), // Daftar Fitur di kanan
          //   ],
          // ),
          SizedBox(height: 10.h),
          footer(),
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
        return Scaffold(
          appBar: AppBar(
            backgroundColor: kAppbarBackgroundColor,

            title: LayoutBuilder(
              builder: (context, constraints) {
                if (isMobile(constraints.maxWidth)) {
                  return Row(
                    children: [
                      Container(
                        width: 200,
                        height: 40,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(AppImages().imageHomePage2),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                    ],
                  );
                } else {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Gunakan Expanded di sini agar bagian kiri mengambil sisa ruang yang ada
                      // sehingga spaceBetween di Row utama bisa mendorong menu kanan ke pojok.
                      Row(
                        // Sekarang spaceAround akan bekerja karena sudah ada ruang dari Expanded
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // Logo dan Judul
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 50.w,
                                height: 100,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                      AppImages().imageHomePage2,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                            ],
                          ),

                          const SizedBox(
                            width: 20,
                          ), // Jarak antara judul dan search bar
                          // Bagian Search
                        ],
                      ),

                      // Row Menu Kanan (Tetap di pojok kanan)
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            onTap: () => Get.to(() => SearchProductPage()),
                            child: AppbarElement(title: AppString().appBar1),
                          ),
                          AppbarElement(title: AppString().appBar2),
                          AppbarElement(title: AppString().appBar3),
                          AppbarElement(title: AppString().appBar4),
                          SizedBox(width: screenWidth * 0.1, child: search()),
                        ],
                      ),
                    ],
                  );
                }
              },
            ),

            automaticallyImplyLeading: isMobile(
              MediaQuery.of(context).size.width,
            ),
          ),

          drawer: isMobile(MediaQuery.of(context).size.width)
              ? Drawer(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      DrawerHeader(child: Text(AppString().drawerTitle)),
                      ListTile(title: Text(AppString().appBar1), onTap: () {}),
                      ListTile(title: Text(AppString().appBar2), onTap: () {}),
                      ListTile(title: Text(AppString().appBar3), onTap: () {}),
                    ],
                  ),
                )
              : null,

          body: SingleChildScrollView(
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
        );
      },
    );
  }
}
