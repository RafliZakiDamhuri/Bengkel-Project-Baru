import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get/utils.dart';
import 'package:project/global%20widget/baseLayoutWrapper.dart';
import 'package:project/global%20widget/customButton.dart';
import 'package:project/global%20widget/globalAppBar.dart';
import 'package:project/theme/services_images.dart';
import 'package:project/theme/string.dart';
import 'package:project/theme/theme.dart';
import 'package:sizer/sizer.dart';

class ServicesPage extends StatelessWidget {
  const ServicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Globalappbar(
      pageWidget: SingleChildScrollView(
        child: Column(
          children: [
            ResponsiveLayout(mobile: mobileWidget(), desktop: desktopWidget()),
          ],
        ),
      ),
    );
  }

  Widget serviceAndRepair() {
    return Container(
      width: Get.width,

      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/Hero-Service 1_result.webp'),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 140, top: 130),
                      child: Text(
                        'Services and Repair',
                        style: whiteTextStyle.copyWith(
                          fontSize: 36,
                          fontWeight: bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 47),
                    Container(
                      margin: EdgeInsets.only(left: 140),
                      child: Text(
                        'Indocool can carry out minor repairs or complete overhauls to most makes\nand models of industrial cooling system components. Radiators, oil\ncoolers,and heat exchangers, within the mining, oil & gas, marine,\nindustrial power generation, and general industries.',
                        style: whiteTextStyle.copyWith(
                          fontSize: 20,
                          fontWeight: medium,
                        ),
                      ),
                    ),
                    SizedBox(height: 40),
                    Container(
                      margin: EdgeInsets.only(left: 140),
                      child: bookServiceSchedule(),
                    ),
                  ],
                ),
              ),
              // Container(
              //   margin: EdgeInsets.only(top: 12),
              //   width: 60.w,
              //   height: 60.h,
              //   decoration: BoxDecoration(
              //     image: DecorationImage(
              //       image: AssetImage(
              //         'assets/images/Service-Repair-Foto 1_result.webp',
              //       ),
              //       fit: BoxFit.contain,
              //     ),
              //   ),
              // ),
            ],
          ),
          SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(top: 50, right: 40),
                width: 348,
                height: 231,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/01-Welding-1_result.webp'),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 50, right: 40),
                width: 348,
                height: 231,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/02-Service-1_result.webp'),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 50, right: 40),
                width: 348,
                height: 231,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      'assets/images/03-Cleaning 1_result.webp',
                    ),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 80),
        ],
      ),
    );
  }

  Widget mobileWidget() {
    return Container();
  }

  Widget desktopWidget() {
    return Column(
      children: [
        serviceAndRepair(),
        SizedBox(height: 60),

        ServicesImages(
          title: 'Minor Repair Radiator',
          imag: 'assets/images/04-Minor-Repair 1_result.webp',
          htmlData: AppString().minorRepair,
        ),
        SizedBox(height: 60),
        ServicesImages(
          title: 'Major Repair Radiator',
          imag: 'assets/images/05-Major-Repair 1_result.webp',
          htmlData: AppString().majorRepair,
        ),
        SizedBox(height: 60),
        ServicesImages(
          title: 'Complete Overhaul Radiator',
          imag: 'assets/images/06-Overhaul-Repair 1_result.webp',
          htmlData: AppString().completeOverhaul,
        ),
        SizedBox(height: 60),
      ],
    );
  }
}
