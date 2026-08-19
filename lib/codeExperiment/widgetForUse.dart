import 'package:flutter/material.dart';

class SuretipButton extends StatelessWidget {
  final String text;
  final double textSize;
  final VoidCallback onTap;
  final Color color;

  const SuretipButton({
    super.key,
    required this.text,
    required this.textSize,
    required this.onTap,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 200,
        height: 40,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: textSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
