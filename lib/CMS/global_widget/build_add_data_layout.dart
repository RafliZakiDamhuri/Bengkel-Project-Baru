import 'package:flutter/material.dart';
import 'package:project/global%20widget/customButton.dart';
import 'package:project/theme/theme.dart';

Widget buildAddDataLayout({
  required String title,
  required List<Widget> leftFields,
  required List<Widget> rightFields,
  required VoidCallback onSubmit,
}) {
  return Container(
    margin: const EdgeInsets.only(left: 40, top: 80, bottom: 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(title, style: blackTextStyle.copyWith(fontSize: 30)),

        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(children: leftFields),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...rightFields,

                const SizedBox(height: 20),

                customBlueAppBarButton(onTap: onSubmit, title: 'Update'),
              ],
            ),
          ],
        ),
      ],
    ),
  );
}
