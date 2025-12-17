import 'package:flutter/material.dart';
import 'package:project/theme/theme.dart';
import 'package:sizer/sizer.dart';

class ListHome extends StatelessWidget {
  final String? nomer;
  final String title;
  final double? size;
  const ListHome({super.key, this.nomer, required this.title, this.size});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        nomer == null
            ? Container()
            : Container(
                margin: EdgeInsets.only(right: 40),
                child: Text(nomer!, style: blackTextStyle),
              ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: blackTextStyle.copyWith(
                fontWeight: bold,
                fontSize: size ?? 16.sp,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
