import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:project/controller/contactUsController.dart';
import 'package:project/controller/globalController.dart';
import 'package:project/global%20widget/baseLayoutWrapper.dart';
import 'package:project/global%20widget/customButton.dart';
import 'package:project/global%20widget/globalAppBar.dart';
import 'package:project/global%20widget/personalDataContactUs.dart';
import 'package:project/theme/app_images.dart';
import 'package:project/theme/string.dart';

class ContactUsPage extends StatefulWidget {
  const ContactUsPage({super.key});

  @override
  State<ContactUsPage> createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
  bool _ready = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    precacheImage(AssetImage(AppImages().contactUs), context).then((_) {
      if (mounted) {
        setState(() {
          _ready = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(Contactuscontroller());
    Widget mobileHeroSection() {
      return Stack(
        children: [
          SizedBox(
            height: 800,
            width: double.infinity,
            child: Image.asset(AppImages().contactUs, fit: BoxFit.cover),
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
              margin: EdgeInsets.only(top: 500, left: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Have a question?\nGet an answer directly\nfrom the experts.',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Html(
                    data: AppString().contactUsHtml,
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
                    title: 'Contact Us',
                    width: 120,
                  ),
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
            AppImages().contactUs,
            width: double.infinity,
            fit: BoxFit.fitWidth,
          ),

          Padding(
            padding: const EdgeInsets.only(left: 120, top: 165),
            child: SizedBox(
              width: Get.width / 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Have a question?\nGet an answer directly\nfrom the experts.',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 40),
                  Row(
                    children: [
                      Expanded(
                        child: Html(
                          data: AppString().contactUsHtml,
                          style: {
                            "body": Style(
                              color: Colors.white,
                              fontSize: FontSize(24),
                              margin: Margins.zero,
                              padding: HtmlPaddings.zero,
                              lineHeight: const LineHeight(1.5),
                            ),
                            "p": Style(margin: Margins.only(bottom: 12)),
                            "ul": Style(
                              margin: Margins.only(left: 20, bottom: 12),
                            ),
                            "li": Style(color: Colors.white),
                            "strong": Style(fontWeight: FontWeight.bold),
                          },
                        ),
                      ),
                      SizedBox(width: 180),
                    ],
                  ),
                  const SizedBox(height: 50),
                  customBlueAppBarButton(onTap: () {}, title: 'Contact Us'),
                ],
              ),
            ),
          ),
        ],
      );
    }

    Widget desktopWidget() {
      return Column(children: [heroSection(), personaldataContactUs()]);
    }

    Widget mobileWidget() {
      return Column(children: [mobileHeroSection(), personaldataContactUs()]);
    }

    return GetBuilder<Contactuscontroller>(
      initState: (state) async {
        await Get.find<Contactuscontroller>().getAllInquiryType();
        await Get.find<Contactuscontroller>().getContact();
      },
      builder: (controller) {
        if (!_ready) {
          return const Center(child: CircularProgressIndicator());
        }
        return Globalappbar(
          pageWidget: SingleChildScrollView(
            child: ResponsiveLayout(
              mobile: mobileWidget(),
              desktop: desktopWidget(),
            ),
          ),
          isNeedInquiryPage: false,
        );
      },
    );
  }
}
