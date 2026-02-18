import 'package:flutter/material.dart';
import 'package:project/theme/theme.dart';
import 'package:sizer/sizer.dart';

class ListHome extends StatelessWidget {
  final String? nomer;
  final String title;
  final double? size;
  final TextStyle? warna;
  const ListHome({
    super.key,
    this.nomer,
    required this.title,
    this.size,
    required this.warna,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        nomer == null
            ? Container()
            : Container(
                margin: EdgeInsets.only(right: 40),
                child: Text(nomer!, style: whiteTextStyle.merge(warna)),
              ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: whiteTextStyle
                  .copyWith(fontWeight: bold, fontSize: size ?? 12.sp)
                  .merge(warna),
            ),
          ],
        ),
      ],
    );
  }
}
