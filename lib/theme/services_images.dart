import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get/utils.dart';
import 'package:project/global%20widget/customButton.dart';
import 'package:project/theme/theme.dart';

class ServicesImages extends StatelessWidget {
  final String imag;
  final String title;
  const ServicesImages({super.key, required this.imag, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 140),
      width: Get.width,
      decoration: BoxDecoration(color: kWhiteColor),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            width: 523,
            height: 608,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(imag),
                fit: BoxFit.contain,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Text(
                  title,
                  style: blackTextStyle.copyWith(
                    fontSize: 32,
                    fontWeight: bold,
                  ),
                ),
              ),
              SizedBox(height: 25),
              Container(
                child: Text(
                  'At Indocool, we provide fast and reliable minor radiator repair\nservices to keep your cooling system performing at its best and\nprevent small issues from becoming major failures.',
                ),
              ),
              SizedBox(height: 25),
              Container(
                child: Text(
                  'Our service covers essential maintenance and repair activities:',
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 20),

                child: Text(
                  '• Radiator Cleaning',
                  style: blackTextStyle.copyWith(fontWeight: bold),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 25),
                child: Text(
                  ' Removal of dirt, scale, and debris to restore optimal heat transfer performance',
                  style: blackTextStyle.copyWith(fontWeight: regular),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 20),

                child: Text(
                  '• Radiator Testing',
                  style: blackTextStyle.copyWith(fontWeight: bold),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 25),
                child: Text(
                  ' Pressure and performance testing to identify potential leaks or weak points.',
                  style: blackTextStyle.copyWith(fontWeight: regular),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 20),
                child: Text(
                  '• Leak Repair (Minor Damage)',
                  style: blackTextStyle.copyWith(fontWeight: bold),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 25),
                child: Text(
                  ' Repair of leaks within the minor affected area, ensuring quick and\ncost-effective restoration.',
                  style: blackTextStyle.copyWith(fontWeight: regular),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 20),
                child: Text(
                  '• Minor Component Replacement.',
                  style: blackTextStyle.copyWith(fontWeight: bold),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 25),
                child: Text(
                  'Replacement of small parts such as radiator caps, filler necks, gaskets,\nand other small components.',
                  style: blackTextStyle.copyWith(fontWeight: regular),
                ),
              ),
              SizedBox(height: 10),
              Text(
                'With experienced technicians and proper inspection procedures,\nIndocool ensures your radiator is returned to safe, efficient, and reliable\noperating condition.',
              ),
              SizedBox(height: 10),
              Text(
                'Prevent downtime. Extend equipment life. Keep your system running\nefficiently with Indocool.',
              ),

              Container(
                width: 200,
                height: 40,
                margin: EdgeInsets.only(top: 56),
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
        ],
      ),
    );
  }
}
