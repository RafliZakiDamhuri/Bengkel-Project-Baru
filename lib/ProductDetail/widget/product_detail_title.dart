import 'package:flutter/widgets.dart';

import 'package:flutter/material.dart';

class ProductDetailTitle extends StatelessWidget {
  final String title1;
  final String title2;

  const ProductDetailTitle({
    super.key,
    required this.title1,
    required this.title2,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 300,
            child: Text(
              title1,
              style: const TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
          Text(
            title2,
            style: const TextStyle(color: Colors.black, fontSize: 14),
          ),
        ],
      ),
    );
  }
}
