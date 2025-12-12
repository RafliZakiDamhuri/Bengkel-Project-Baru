import 'package:flutter/material.dart';
import 'package:project/theme/theme.dart';
import 'package:sizer/sizer.dart';

class ListHome extends StatelessWidget {
  final String nomer;
  final String title;
  const ListHome({super.key, required this.nomer, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          margin: EdgeInsets.only(right: 40),
          child: Text(nomer, style: blackTextStyle),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: blackTextStyle.copyWith(fontWeight: bold, fontSize: 16.sp),
            ),
          ],
        ),
      ],
    );
  }
}
