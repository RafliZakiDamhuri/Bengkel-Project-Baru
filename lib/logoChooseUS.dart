import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class Logochooseus extends StatelessWidget {
  final String image;
  const Logochooseus({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    List<bool> expandedIcons = [false, false, false, false, false];
    // bool isExpanded = false;
    // Tentukan breakpoint (Anda dapat menyesuaikannya)
    bool isDesktop(double width) => width >= 900;

    bool isTablet(double width) => width >= 600 && width < 900;

    bool isMobile(double width) => width < 600;
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: 16.w,
      margin: isMobile(screenWidth)
          ? EdgeInsets.symmetric(horizontal: 20)
          : isDesktop(screenWidth)
          ? EdgeInsets.only(left: 10)
          : EdgeInsets.only(left: 0),
      height: isMobile(screenWidth) ? 15.h : 20.h,
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(image)),
      ),
    );
  }
}
