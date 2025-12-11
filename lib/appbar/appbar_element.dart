import 'package:flutter/material.dart';
import 'package:project/tema/theme.dart';

class AppbarElement extends StatelessWidget {
  final String title;
  const AppbarElement({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 20),
      child: Text(
        title,
        style: blackTextStyle.copyWith(fontSize: 16, fontWeight: bold),
      ),
    );
  }
}
