import 'package:flutter/material.dart';
import 'package:project/theme/app_images.dart';

class AppPrecache {
  static Future<void> preload(BuildContext context) async {
    await Future.wait([
      precacheImage(
        AssetImage(
          'assets/images/Indocool-Provide-Radiator-for-Multi-Sector-2 1_result.webp',
        ),
        context,
      ),
      precacheImage(AssetImage(AppImages().incoCoolProductList), context),
      precacheImage(
        AssetImage('assets/images/Hero-Service 1_result.webp'),
        context,
      ),
      precacheImage(AssetImage(AppImages().contactUs), context),
      precacheImage(
        AssetImage('assets/images/Indoocool-Search-Part 1_result.webp'),
        context,
      ),
      precacheImage(AssetImage(AppImages().aboutUsImage), context),
    ]);
  }
}
