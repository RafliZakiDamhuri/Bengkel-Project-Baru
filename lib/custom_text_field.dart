import 'package:flutter/material.dart';
import 'package:project/theme/theme.dart';

class CustoumTextField extends StatelessWidget {
  final String hintName;
  final bool obsecureText;
  final double width;
  final int maxLines;
  final TextEditingController? controller;
  final void Function(String)? onChangedFunction;

  const CustoumTextField({
    super.key,
    required this.hintName,
    required this.obsecureText,
    required this.width,
    this.maxLines = 1,
    this.controller,
    this.onChangedFunction,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      margin: EdgeInsets.only(bottom: 20, left: 12, right: 12),
      child: TextFormField(
        onChanged: onChangedFunction,
        controller: controller,
        obscureText: obsecureText,
        maxLines: maxLines,
        cursorColor: kBlackColor,
        decoration: InputDecoration(
          hintText: hintName,
          hintStyle: TextStyle(color: Colors.grey[600]),
          filled: true,
          fillColor: Colors.grey[300],
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
