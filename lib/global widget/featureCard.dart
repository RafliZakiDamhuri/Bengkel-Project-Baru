import 'package:flutter/material.dart';
import 'package:project/theme/theme.dart';
import 'package:sizer/sizer.dart'; // pastikan sudah import

Widget featureCard({
  required String title,

  required String image,
  required bool isMobile,
}) {
  return Container(
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
  );
}
