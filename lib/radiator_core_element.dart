import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/theme/theme.dart';

class RadiatorCoreElement extends StatelessWidget {
  final String img;
  final String title;
  const RadiatorCoreElement({
    super.key,
    required this.img,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Row(
            children: [
              Container(
                width: 500,
                height: 300,
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
                      margin: EdgeInsets.only(top: 40, left: 30, right: 30),
                      width: 620,
                      height: 196,
                      decoration: BoxDecoration(
                        image: DecorationImage(image: AssetImage(img)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Text('click the picture to sort related product list'),
      ],
    );
  }
}
