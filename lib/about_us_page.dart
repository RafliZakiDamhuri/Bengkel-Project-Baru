import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:project/controller/aboutUsController.dart';
import 'package:project/controller/mainProductController.dart';
import 'package:project/global_widget/baseLayoutWrapper.dart';
import 'package:project/global_widget/customButton.dart';
import 'package:project/global_widget/globalAppBar.dart';
import 'package:project/theme/app_images.dart';
import 'package:project/theme/string.dart';
import 'package:project/routes/routes_name.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    var mainProductController = Get.find<MainProductController>();
    Widget mobileHeroSection() {
      return Stack(
        children: [
          SizedBox(
            height: 800,
            width: double.infinity,
            child: Image.asset(AppImages().aboutUsImage, fit: BoxFit.cover),
          ),

          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.black45, Colors.black87],
              ),
            ),
            child: Container(
              margin: EdgeInsets.only(top: 500, left: 16, right: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ABOUT US',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  // const SizedBox(height: 40),
                  Html(
                    data: AppString().aboutUsHtml,
                    style: {
                      "body": Style(
                        color: Colors.white,
                        fontSize: FontSize(14),
                        margin: Margins.zero,
                        padding: HtmlPaddings.zero,
                        lineHeight: const LineHeight(1.5),
                      ),
                      "p": Style(margin: Margins.only(bottom: 12)),
                      "ul": Style(margin: Margins.only(left: 20, bottom: 12)),
                      "li": Style(color: Colors.white),
                      "strong": Style(fontWeight: FontWeight.bold),
                    },
                  ),
                  customBlueAppBarButton(
                    onTap: () {},
                    title: 'Request Company Profile',
                  ),
                  SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      );
    }

    Widget heroSection() {
      return Stack(
        children: [
          Image.asset(
            AppImages().aboutUsImage,
            width: double.infinity,
            fit: BoxFit.fitWidth,
          ),

          Padding(
            padding: const EdgeInsets.only(left: 160, top: 165),
            child: SizedBox(
              width: Get.width / 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ABOUT US',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 40),
                  Html(
                    data: AppString().aboutUsHtml,
                    style: {
                      "body": Style(
                        color: Colors.white,
                        fontSize: FontSize(24),
                        margin: Margins.zero,
                        padding: HtmlPaddings.zero,
                        lineHeight: const LineHeight(1.5),
                      ),
                      "p": Style(margin: Margins.only(bottom: 12)),
                      "ul": Style(margin: Margins.only(left: 20, bottom: 12)),
                      "li": Style(color: Colors.white),
                      "strong": Style(fontWeight: FontWeight.bold),
                    },
                  ),
                  const SizedBox(height: 50),
                  customBlueAppBarButton(
                    onTap: () {
                      mainProductController.downloadPdfWeb(
                        AppString().companyProfilePdfUrl,
                        pdfName: "Company Profile - Indocool Group.pdf",
                      );
                    },
                    title: 'Request Company Profile',
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    }

    Widget desktopWidget() {
      return Column(
        children: [
          heroSection(),
          Image.asset(
            AppImages().aboutUsHistory,
            width: double.infinity,
            fit: BoxFit.fitWidth,
          ),
          Image.asset(
            AppImages().companySertification,
            width: double.infinity,
            fit: BoxFit.fitWidth,
          ),
        ],
      );
    }

    Widget mobileWidget() {
      return Column(
        children: [
          mobileHeroSection(),
          Image.asset(
            AppImages().aboutUsHistory,
            width: double.infinity,
            fit: BoxFit.fitWidth,
          ),
          Image.asset(
            AppImages().companySertification,
            width: double.infinity,
            fit: BoxFit.fitWidth,
          ),
          SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: customBlueAppBarButton(
              onTap: () {
                Get.toNamed(AppRouteName.careers);
              },
              title: 'Indocool Careers',
            ),
          ),
          SizedBox(height: 40),
        ],
      );
    }

    return GetBuilder<AboutUsController>(
      initState: (state) async {},
      builder: (controller) {
        return Globalappbar(
          isNeedInquiryPage: false,
          pageWidget: SingleChildScrollView(
            child: ResponsiveLayout(
              mobile: mobileWidget(),
              desktop: desktopWidget(),
            ),
          ),
        );
      },
    );
  }
}
