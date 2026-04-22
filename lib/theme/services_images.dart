import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get/utils.dart';
import 'package:project/theme/theme.dart';

class ServicesImages extends StatelessWidget {
  const ServicesImages({super.key});

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
                image: AssetImage('assets/images/04-Minor-Repair 1.png'),
                fit: BoxFit.contain,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Text(
                  'Minor Repair Radiator',
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
                  ' Repair of leaks within the minor affected area, ensuring quick and\n cost-effective restoration.',
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
                  ' Replacement of critical parts such as radiator caps, filler necks,\n gaskets, and other small components.',
                  style: blackTextStyle.copyWith(fontWeight: regular),
                ),
              ),
              SizedBox(height: 10),
              Text(
                'With experienced technicians and proper inspection procedures,\nIndocool ensures your radiator is returned to safe, efficient, and\nreliable operating condition.',
              ),
              SizedBox(height: 10),
              Text(
                'Prevent downtime. Extend equipment life. Keep your system running\nefficiently with Indocool.',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
