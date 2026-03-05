import 'package:flutter/material.dart';
import 'package:project/theme/theme.dart';
import 'package:sizer/sizer.dart';

class DetailLocation extends StatelessWidget {
  final String number;
  final String factory;
  final String title;
  const DetailLocation({
    super.key,
    required this.number,
    required this.factory,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    List<bool> expandedIcons = [false, false, false, false, false];
    // bool isExpanded = false;
    // Tentukan breakpoint (Anda dapat menyesuaikannya)
    bool isDesktop(double width) => width >= 900;

    bool isTablet(double width) => width >= 600 && width < 900;

    bool isMobile(double width) => width < 600;
    final screenWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Container(
          width: 16.w,
          height: 10.h,

          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage(number)),
          ),
        ),
        Container(
          width: isDesktop(screenWidth) ? 25.w : 60.w,
          height: isDesktop(screenWidth) ? 25.h : 28.h,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(factory),
              fit: BoxFit.contain,
            ),
          ),
        ),
        Container(child: Text(title, style: factoryTitleTextStyle)),
      ],
    );
  }
}
