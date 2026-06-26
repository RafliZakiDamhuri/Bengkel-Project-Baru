import 'package:flutter/material.dart';
import 'package:project/theme/string.dart';
import 'package:project/theme/theme.dart';
import 'package:url_launcher/url_launcher.dart';

Widget bookServiceSchedule() {
  Future<void> openWhatsApp(String phone, String message) async {
    final url = Uri.parse(
      "https://wa.me/$phone?text=${Uri.encodeComponent(message)}",
    );

    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch WhatsApp';
    }
  }

  return GestureDetector(
    onTap: () {
      openWhatsApp(
        AppString().indocoolWhatsappNumber,
        'Halo Saya Ingin Booking',
      );
    },
    child: Container(
      width: 200,
      height: 40,
      decoration: BoxDecoration(
        color: kBlueColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          'Book Service Schedule',
          style: whiteTextStyle.copyWith(fontSize: 14, fontWeight: bold),
        ),
      ),
    ),
  );
}

Widget customBlueAppBarButton({
  VoidCallback? onTap,
  String title = '-',
  double width = 250,
  Color? backGroundColor,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      // padding: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.only(left: 20, right: 20),

      width: width,
      height: 40,
      decoration: BoxDecoration(
        color: backGroundColor ?? kAppbarBackgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          title,
          style: whiteTextStyle.copyWith(fontSize: 14, fontWeight: bold),
        ),
      ),
    ),
  );
}
