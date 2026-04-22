import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get/utils.dart';
import 'package:project/global%20widget/baseLayoutWrapper.dart';
import 'package:project/global%20widget/globalAppBar.dart';
import 'package:project/theme/services_images.dart';
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

  Widget ServiceAndRepair() {
    return Container(
      width: Get.width,

      decoration: BoxDecoration(color: kBlackColor),
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
                      width: 200,
                      height: 40,
                      margin: EdgeInsets.only(left: 140),
                      decoration: BoxDecoration(
                        color: kBlueColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          'Book Service Schedule',
                          style: whiteTextStyle.copyWith(
                            fontSize: 14,
                            fontWeight: bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 12),
                width: 60.w,
                height: 60.h,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      'assets/images/Service-Repair-Foto 1.png',
                    ),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(right: 20, left: 141),
                width: 348,
                height: 231,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/01-Welding-1.png'),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: 20),
                width: 30.w,
                height: 231,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/02-Service-1.png'),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: 20),
                width: 30.w,
                height: 231,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/03-Cleaning 1.png'),
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

  Widget repairRadiator() {
    return Column(
      children: [ServicesImages(), ServicesImages(), ServicesImages()],
    );
  }

  Widget mobileWidget() {
    return Container();
  }

  Widget desktopWidget() {
    return Column(
      children: [
        ServiceAndRepair(),
        ServicesImages(),
        ServicesImages(),
        ServicesImages(),
      ],
    );
  }
}
