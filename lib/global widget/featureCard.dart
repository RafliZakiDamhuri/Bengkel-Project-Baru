import 'package:flutter/material.dart';
import 'package:project/theme/theme.dart';
import 'package:sizer/sizer.dart'; // pastikan sudah import

Widget featureCard({
  required String title,

  required String image,
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
        Image.asset(
          image,
          width: isMobile ? 70.sp : 50.sp,
          height: isMobile ? 70.sp : 50.sp,
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
        SizedBox(height: 0.5.h),
      ],
    ),
  );
}
