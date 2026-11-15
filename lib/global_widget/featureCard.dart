import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:project/routes/routes_name.dart';
import 'package:project/theme/theme.dart';
import 'package:sizer/sizer.dart'; // pastikan sudah import

Widget featureCard({
  required String title,

  required String image,
  required bool isMobile,
  required int index,
}) {
  return InkWell(
    onTap: () {
      if (index == 0) {
        Get.toNamed(AppRouteName.radmaxRemovableTubeRadiator);
      } else if (index == 1) {
        Get.toNamed(AppRouteName.lightDutyRadiator);
      } else if (index == 2) {
        Get.toNamed(AppRouteName.heavyDutyCooler);
      } else if (index == 3) {
        Get.toNamed(AppRouteName.heavyDutyCooper);
      } else if (index == 4) {
        Get.toNamed(AppRouteName.catterpillarReplacement);
      } else if (index == 5) {
        Get.toNamed(AppRouteName.catterpillarTubeAndShell);
      } else if (index == 6) {
        Get.toNamed(AppRouteName.radiatorEngine);
      } else if (index == 7) {
        Get.toNamed(AppRouteName.airCooled);
      } else if (index == 8) {
        Get.toNamed(AppRouteName.platedHeat);
      } else if (index == 9) {
        Get.toNamed(AppRouteName.industrialShell);
      } else if (index == 10) {
        Get.toNamed(AppRouteName.radmaxLevelRelease);
      } else if (index == 11) {
        Get.toNamed(AppRouteName.replacementFan);
      }
    },

    child: Container(
      width: 20.h,
      height: 60.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(2.w),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 1.h),
          Image.network(
            image,
            width: isMobile ? 70.sp : 50.w,
            height: isMobile ? 70.sp : 50.h,
          ),
          SizedBox(height: 1.h),
          Text(
            title,
            textAlign: TextAlign.center,
            style: blackTextStyle.copyWith(
              fontWeight: bold,
              fontSize: (isMobile) ? 16.sp : 12.sp, // responsive font
            ),
          ),
        ],
      ),
    ),
  );
}
