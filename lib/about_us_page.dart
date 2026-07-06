import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/state_manager.dart';
import 'package:project/controller/aboutUsController.dart';
import 'package:project/controller/globalController.dart';
import 'package:project/global%20widget/baseLayoutWrapper.dart';
import 'package:project/global%20widget/customButton.dart';
import 'package:project/global%20widget/globalAppBar.dart';
import 'package:project/theme/app_images.dart';
import 'package:project/theme/string.dart';
import 'package:project/theme/theme.dart';
import 'package:sizer/sizer.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalController globalController = Get.find<GlobalController>();
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
                    onTap: () {},
                    title: 'Request Company Profile',
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    }

    Widget indoCoolCarrersSection() {
      return Row(
        children: [
          Container(
            margin: EdgeInsets.only(top: 80, bottom: 80),
            child: Image.asset(
              AppImages().indoCoolCarrer,
              width: 500,
              height: 500,
            ),
          ),
          const SizedBox(width: 60),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Indocool Careers',
                  style: blackTextStyle.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 36,
                  ),
                ),
                const SizedBox(height: 40),
                Container(
                  margin: EdgeInsets.only(right: 400),
                  child: Text(
                    AppString().indocoolCareers,
                    style: blackTextStyle.copyWith(fontSize: 20),
                  ),
                ),
                const SizedBox(width: 40),
                Row(
                  children: [
                    customBlueAppBarButton(
                      onTap: () {
                        globalController.openUrl(AppString().linkedInUrl);
                      },
                      width: 150,
                      title: 'Linkedin',
                    ),
                    const SizedBox(width: 20),

                    customBlueAppBarButton(
                      onTap: () {
                        globalController.openUrl(AppString().jobStreetUrl);
                      },
                      width: 150,
                      title: 'Jobstreet',
                      backGroundColor: darkblue,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      );
    }

    Widget indoCoolCarrersSectionMobile() {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(AppImages().indoCoolCarrer, width: 260),

            const SizedBox(height: 32),

            Text(
              'Indocool Careers',
              textAlign: TextAlign.center,
              style: blackTextStyle.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 28,
              ),
            ),

            const SizedBox(height: 20),

            Text(
              AppString().indocoolCareers,
              textAlign: TextAlign.center,
              style: blackTextStyle.copyWith(fontSize: 16, height: 1.6),
            ),

            const SizedBox(height: 32),

            SizedBox(
              width: double.infinity,
              child: customBlueAppBarButton(
                onTap: () {
                  globalController.openUrl(AppString().linkedInUrl);
                },
                title: 'LinkedIn',
              ),
            ),

            const SizedBox(height: 16),

            SizedBox(
              width: double.infinity,
              child: customBlueAppBarButton(
                onTap: () {
                  globalController.openUrl(AppString().jobStreetUrl);
                },
                title: 'JobStreet',
                backGroundColor: darkblue,
              ),
            ),
          ],
        ),
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
          indoCoolCarrersSection(),
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
          indoCoolCarrersSectionMobile(),
        ],
      );
    }

    return GetBuilder<AboutUsController>(
      initState: (state) async {},
      builder: (controller) {
        return Globalappbar(
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
