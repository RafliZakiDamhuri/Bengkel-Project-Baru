import 'package:flutter/material.dart';
import 'package:project/theme/app_images.dart';
import 'package:project/theme/string.dart';
import 'package:project/theme/theme.dart';
import 'package:sizer/sizer.dart';

Widget footer() {
  return Container(
    width: double.infinity,
    color: Colors.black,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 🔽 KODE KAMU (TIDAK DIUBAH SAMA SEKALI)
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 50, top: 30),
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 10),
                        width: 437,
                        height: 40,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(AppImages().imageFooter),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 50),
                      child: Text(
                        'PT. Indocool Solusi Cemerlang',
                        style: whiteTextStyle.copyWith(
                          fontSize: 16,
                          fontWeight: bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 12),
                    Container(
                      margin: EdgeInsets.only(left: 50),
                      child: Text(
                        'Bogor Head Office: Bogor, Jawa Barat, Indonesia\nBranch Balikpapan: Balikpapan, Kalimantan Timur, Indonesia\nBranch Sangatta: Kutai Timur, Kalimantan Timur, Indonesia',
                        style: whiteTextStyle.copyWith(
                          fontSize: 14,
                          fontWeight: regular,
                        ),
                      ),
                    ),
                    SizedBox(height: 12),
                    Container(
                      margin: EdgeInsets.only(left: 50),
                      child: Text(
                        'PT. Indocool Rekayasa Batam',
                        style: whiteTextStyle.copyWith(
                          fontSize: 16,
                          fontWeight: bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 12),
                    Container(
                      margin: EdgeInsets.only(left: 50),
                      child: Text(
                        'Batam Head Office: Batam, Kepulauan Riau, Indonesia',
                        style: whiteTextStyle.copyWith(
                          fontSize: 14,
                          fontWeight: regular,
                        ),
                      ),
                    ),
                    SizedBox(height: 24),
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 50),
                          width: 15,
                          height: 15,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                'assets/images/Logo-WhatsApp 1.png',
                              ),
                            ),
                          ),
                        ),
                        Text(
                          '+62 812-1000-256',
                          style: whiteTextStyle.copyWith(
                            fontWeight: medium,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 50),
                          width: 15,
                          height: 15,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                'assets/images/Logo-Email-2 1.png',
                              ),
                            ),
                          ),
                        ),
                        Text(
                          'customersupport@indocool.co.id',
                          style: whiteTextStyle.copyWith(
                            fontWeight: medium,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 29),
                    Container(
                      margin: EdgeInsets.only(left: 50),
                      width: 437,
                      height: 28,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/Logo-ISO 1.png'),
                        ),
                      ),
                    ),
                    SizedBox(height: 22),
                  ],
                ),
              ],
            ),

            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 30),
                  child: Text(
                    'Product',
                    style: whiteTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: bold,
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Removable Tube Radiator',
                  style: whiteTextStyle.copyWith(
                    fontWeight: medium,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Conventional Radiator',
                  style: whiteTextStyle.copyWith(
                    fontWeight: medium,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Aluminum Plate & Bar Core',
                  style: whiteTextStyle.copyWith(
                    fontWeight: medium,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'After & Inter Cooler',
                  style: whiteTextStyle.copyWith(
                    fontWeight: medium,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Tube & Shell Oil Cooler',
                  style: whiteTextStyle.copyWith(
                    fontWeight: medium,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Radiator Coolant',
                  style: whiteTextStyle.copyWith(
                    fontWeight: medium,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Air Cooled Heat Exchanger',
                  style: whiteTextStyle.copyWith(
                    fontWeight: medium,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Plate Heat Exchanger',
                  style: whiteTextStyle.copyWith(
                    fontWeight: medium,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Industrial Oil Cooler',
                  style: whiteTextStyle.copyWith(
                    fontWeight: medium,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Safety Radiator Cap',
                  style: whiteTextStyle.copyWith(
                    fontWeight: medium,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Screw Cap Adapter',
                  style: whiteTextStyle.copyWith(
                    fontWeight: medium,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Replacement Fan',
                  style: whiteTextStyle.copyWith(
                    fontWeight: medium,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 19),
              ],
            ),

            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 30),
                  child: Text(
                    'Services',
                    style: whiteTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: bold,
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Minor Repair',
                  style: whiteTextStyle.copyWith(
                    fontWeight: medium,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Major Repair',
                  style: whiteTextStyle.copyWith(
                    fontWeight: medium,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'General Overhaul',
                  style: whiteTextStyle.copyWith(
                    fontWeight: medium,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 27),
                Container(
                  margin: EdgeInsets.only(top: 30),
                  child: Text(
                    'Insight',
                    style: whiteTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: bold,
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Company News',
                  style: whiteTextStyle.copyWith(
                    fontWeight: medium,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Product Insight',
                  style: whiteTextStyle.copyWith(
                    fontWeight: medium,
                    fontSize: 14,
                  ),
                ),
              ],
            ),

            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 30),
                  child: Text(
                    'About Us',
                    style: whiteTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: bold,
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Company Profile',
                  style: whiteTextStyle.copyWith(
                    fontWeight: medium,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Portfolio',
                  style: whiteTextStyle.copyWith(
                    fontWeight: medium,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Job Vacancies',
                  style: whiteTextStyle.copyWith(
                    fontWeight: medium,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 27),
                Container(
                  margin: EdgeInsets.only(top: 30),
                  child: Text(
                    'Contact',
                    style: whiteTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: bold,
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Inquiry',
                  style: whiteTextStyle.copyWith(
                    fontWeight: medium,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Customer Support',
                  style: whiteTextStyle.copyWith(
                    fontWeight: medium,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Company Location',
                  style: whiteTextStyle.copyWith(
                    fontWeight: medium,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ],
        ),

        Row(
          children: [
            Spacer(flex: 5),

            Container(
              width: 336,
              height: 67,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/Rectangle 48.png'),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'PART NUMBER SEARCH',
                    style: whiteTextStyle.copyWith(
                      fontSize: 20,
                      fontWeight: bold,
                    ),
                  ),
                  Container(
                    width: 40,
                    height: 37,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/Logo-SHop 1.png'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Spacer(flex: 1),
          ],
        ),
        SizedBox(height: 40),

        // 🔽 GARIS (TAMBAHAN DOANG)
        Center(
          child: Container(
            width: 80.w,
            height: 1,
            margin: EdgeInsets.symmetric(horizontal: 40),
            color: Colors.white,
          ),
        ),
        SizedBox(height: 25),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              child: Text(
                "All manufacturer's names, symbols, part numbers, or descriptions, are used for reference purpose only.\nIt is not our intent to imply that any part mentioned is the product of OEM.",
                style: whiteTextStyle.copyWith(
                  fontSize: 10,
                  fontWeight: regular,
                ),
              ),
            ),
            Container(
              child: Text(
                'Copyright © 2026 PT. INDOCOOL SOLUSI CEMERLANG  | All Right Reserved',
                style: whiteTextStyle.copyWith(fontSize: 14, fontWeight: bold),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
