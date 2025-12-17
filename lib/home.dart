// ... imports Anda yang sudah ada ...
import 'package:flutter/material.dart';
import 'package:get_x/get_state_manager/get_state_manager.dart';
import 'package:project/appbar/appbar_element.dart';
import 'package:project/appbar/list_home.dart';
import 'package:project/controller/homeController.dart';
import 'package:project/global%20widget/featureCard.dart';
import 'package:project/model/featureCardModel.dart';
import 'package:project/theme/app_images.dart';
import 'package:project/theme/string.dart';
import 'package:project/theme/theme.dart';
// import-import lain
import 'package:sizer/sizer.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  // Tentukan breakpoint (Anda dapat menyesuaikannya)
  bool isDesktop(double width) => width >= 900;
  bool isTablet(double width) => width >= 600 && width < 900;
  bool isMobile(double width) => width < 600;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Data fitur tetap sama
    final List<Feature> featureData = [
      Feature(
        Icons.print,
        "Dukungan Printer",
        "Cetak struk, invoice, dan laporan dengan mudah menggunakan berbagai jenis printer dalam aplikasi ini",
      ),
      Feature(
        Icons.attach_money,
        "Pencatatan Keuangan",
        "Lacak semua pemasukan dan pengeluaran bisnismu secara detail dan otomatis.",
      ),
      Feature(
        Icons.print,
        "Dukungan Printer",
        "Cetak struk, invoice, dan laporan dengan mudah menggunakan berbagai jenis printer dalam aplikasi ini",
      ),
      Feature(
        Icons.attach_money,
        "Pencatatan Keuangan",
        "Lacak semua pemasukan dan pengeluaran bisnismu secara detail dan otomatis.",
      ),
      Feature(
        Icons.print,
        "Dukungan Printer",
        "Cetak struk, invoice, dan laporan dengan mudah menggunakan berbagai jenis printer dalam aplikasi ini",
      ),
      Feature(
        Icons.attach_money,
        "Pencatatan Keuangan",
        "Lacak semua pemasukan dan pengeluaran bisnismu secara detail dan otomatis.",
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
                        3; // Disesuaikan sedikit lebih besar dari 5 agar kartu lebih ramping
                  } else if (crossAxisCount == 2) {
                    // Jika 2 kolom (Tablet), rasio aspek harus lebih kecil untuk memberikan ruang vertikal lebih banyak.
                    aspect_ratio = 2.0;
                  } else {
                    // Jika 3 kolom (Desktop), rasio aspek harus kecil.
                    aspect_ratio = 2;
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
                        subtitle: featureData[index].description,
                        icon: featureData[index].icon,
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
              ListHome(
                title: 'Apakah Buku Bengkel Itu?',
                size: isMobile(screenWidth) ? 15.sp : 12.sp,
              ),
              SizedBox(height: 1.5.h),
              Text(
                'Buku Bengkel adalah pengeloala bengkel modern yang lengkap dan mudah\ndigunakan,dirancang khusus untuk membantu Anda mengelola bengkel secara\nprofisonal dan efisien',
                style: greyTextStyle.copyWith(
                  fontSize: (isMobile(screenWidth)) ? 13.sp : 10.sp,
                  fontWeight: light,
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
                title: 'Bagaimana cara sistem kerja Buku Bengkel?',
                size: isMobile(screenWidth) ? 15.sp : 12.sp,
              ),

              Container(
                height: 2,
                width: double.infinity,
                color: Colors.grey.shade300,
                margin: EdgeInsets.symmetric(vertical: 2.h),
              ),
              ListHome(
                title: 'Apakah ini Gratis?',
                size: isMobile(screenWidth) ? 15.sp : 12.sp,
              ),
              Container(
                height: 2,
                width: double.infinity,
                color: Colors.grey.shade300,
                margin: EdgeInsets.symmetric(vertical: 2.h),
              ),

              ListHome(
                title: 'Bagaimana cara sistem kerja Buku Bengkel?',
                size: isMobile(screenWidth) ? 15.sp : 12.sp,
              ),
              Container(
                height: 2,
                width: double.infinity,
                color: Colors.grey.shade300,
                margin: EdgeInsets.symmetric(vertical: 2.h),
              ),

              ListHome(
                title: 'Apakah data pada aplikasi ini aman',
                size: isMobile(screenWidth) ? 15.sp : 12.sp,
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
          horizontal: isDesktop(screenWidth) ? 10.w : 5.w,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppString().featureListSectionTitle,
              style: blackTextStyle.copyWith(
                fontSize: isDesktop(screenWidth) ? 20.sp : 16.sp,
                fontWeight: bold,
              ),
            ),
            SizedBox(height: 3.h),
            ListHome(
              nomer: AppString().listHomeNumber1,
              title: AppString().listHomeTitle1,
            ),
            SizedBox(height: 1.5.h),
            Text(
              AppString().listHomeSubtitle,
              style: greyTextStyle.copyWith(
                fontSize: (isMobile(screenWidth)) ? 14.sp : 10.sp,
                fontWeight: light,
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
              nomer: AppString().listHomeNumber5,
              title: AppString().listHomeTitle5,
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
            children: [questionHeroSectionContent(), questionListSection()],
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
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  // Gambar di kiri
                  width: double.infinity,
                  height: 50.h,
                  margin: EdgeInsets.only(left: 5.w), // Sedikit margin ke kiri
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(AppImages().imageHomePage1),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              Expanded(child: featureListSection()), // Daftar Fitur di kanan
            ],
          ),
          SizedBox(height: 10.h),
          plusPoint(),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(child: questionHeroSectionContent()),
              Expanded(child: questionListSection()), // Daftar Fitur di kanan
            ],
          ),
        ],
      );
    }

    return GetBuilder<Homecontroller>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: kBackgroundColor,

            title: LayoutBuilder(
              builder: (context, constraints) {
                if (isMobile(constraints.maxWidth)) {
                  return Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(AppImages().imageHomePage2),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        AppString().judul,
                        style: blueTextStyle.copyWith(
                          fontWeight: bold,
                          fontSize: 14.sp,
                        ),
                      ),
                    ],
                  );
                } else {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Logo dan Judul
                      Row(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(AppImages().imageHomePage2),
                              ),
                            ),
                          ),
                          Text(
                            AppString().judul,
                            style: blueTextStyle.copyWith(
                              fontWeight: bold,
                              fontSize: 14.sp,
                            ),
                          ),
                        ],
                      ),
                      // Menu Navigasi
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AppbarElement(title: AppString().appBar1),
                          AppbarElement(title: AppString().appBar2),
                          AppbarElement(title: AppString().appBar3),
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
