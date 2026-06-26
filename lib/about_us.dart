import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/state_manager.dart';
import 'package:project/controller/aboutUsController.dart';
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
    Widget mobileWidget() {
      return Container();
    }

    Widget heroSection() {
      return Stack(
        children: [
          Image.asset(
            AppImages().contactUsImage,
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
      return Container(
        child: Row(
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
                        onTap: () {},
                        width: 150,
                        title: 'Linkedin',
                      ),
                      const SizedBox(width: 20),

                      customBlueAppBarButton(
                        onTap: () {},
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
