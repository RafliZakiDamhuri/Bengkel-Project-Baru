import 'package:flutter/material.dart';
import 'package:project/theme/theme.dart';
import 'package:sizer/sizer.dart'; // pastikan sudah import

Widget featureCard({
  required String title,
  required String subtitle,
  required IconData icon,
  required bool isMobile,
}) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 2.w),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(2.w),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 1.h),
        Icon(
          icon,
          size: 20, // responsive icon
        ),
        SizedBox(height: 1.h),
        Text(
          title,
          textAlign: TextAlign.center,
          style: blackTextStyle.copyWith(
            fontSize: (isMobile) ? 16.sp : 12.sp, // responsive font
          ),
        ),
        SizedBox(height: 0.5.h),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: greyTextStyle.copyWith(
            fontSize: (isMobile) ? 14.sp : 10.sp, // responsive font
          ),
        ),
      ],
    ),
  );
}
