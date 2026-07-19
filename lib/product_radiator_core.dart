import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/theme/theme.dart';

class ProductRadiatorCore extends StatelessWidget {
  final String title;
  final String img;
  const ProductRadiatorCore({
    super.key,
    required this.img,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 320,

          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            color: kWhiteColor,
          ),
          child: Column(
            children: [
              Container(
                height: 35,
                width: double.infinity,
                alignment: Alignment.center,
                color: Colors.grey[800],
                child: Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                width: 300,
                height: 176,
                decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage(img)),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        Text('click the picture to sort related product list'),
      ],
    );
  }
}
