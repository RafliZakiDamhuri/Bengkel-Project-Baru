import 'package:flutter/material.dart';
import 'package:project/theme/app_images.dart';
import 'package:project/theme/string.dart';
import 'package:project/theme/theme.dart';

Widget footer() {
  return Container(
    height: 180,
    width: double.infinity,
    color: Colors.black,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(AppImages().imageFooter),
                      ),
                    ),
                  ),
                  Text(
                    AppString().judul,
                    style: whiteTextStyle.copyWith(fontSize: 25),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Container(
              margin: EdgeInsets.only(left: 50),
              child: Text(
                'Platform untuk bengkel dan customer bengkel\nyang memberikan kemudahan bekaitan dengan\nperawatan kendaraan',
                style: whiteTextStyle.copyWith(fontSize: 14),
              ),
            ),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Learn More',
              style: whiteTextStyle.copyWith(fontSize: 16, fontWeight: bold),
            ),
            SizedBox(height: 20),
            Text(
              'Tentang Kami',
              style: greyTextStyle.copyWith(fontWeight: medium, fontSize: 12),
            ),
            SizedBox(height: 10),
            Text(
              'Layanan',
              style: greyTextStyle.copyWith(fontWeight: medium, fontSize: 12),
            ),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Contact Us', style: whiteTextStyle.copyWith(fontSize: 16)),
            SizedBox(height: 15),
            Text(
              'Term of Services',
              style: greyTextStyle.copyWith(fontWeight: medium, fontSize: 12),
            ),
            SizedBox(height: 10),
            Text(
              'Privacy Policy',
              style: greyTextStyle.copyWith(fontWeight: medium, fontSize: 12),
            ),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Sosial Media', style: whiteTextStyle),
            SizedBox(height: 20),
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(AppImages().instagram),
                    ),
                  ),
                ),
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(AppImages().facebook),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );
}
