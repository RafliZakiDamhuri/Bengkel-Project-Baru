import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/controller/globalController.dart';
import 'package:project/global%20widget/baseLayoutWrapper.dart';
import 'package:project/global%20widget/customButton.dart';
import 'package:project/global%20widget/globalAppBar.dart';
import 'package:project/theme/app_images.dart';
import 'package:project/theme/string.dart';
import 'package:project/theme/theme.dart';

class CareersPage extends StatelessWidget {
  const CareersPage({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalController globalController = Get.find<GlobalController>();

    Widget careersSection() {
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

    Widget careersSectionMobile() {
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
      return Column(children: [careersSection()]);
    }

    Widget mobileWidget() {
      return Column(children: [careersSectionMobile()]);
    }

    return Globalappbar(
      isNeedInquiryPage: false,
      pageWidget: SingleChildScrollView(
        child: ResponsiveLayout(
          mobile: mobileWidget(),
          desktop: desktopWidget(),
        ),
      ),
    );
  }
}
