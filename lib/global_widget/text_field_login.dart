import 'package:flutter/material.dart';
import 'package:project/theme/theme.dart';

class TextFieldLogin extends StatelessWidget {
  final String textName;
  final String hintName;
  final bool obsecureText;
  final TextEditingController controller;
  const TextFieldLogin({
    super.key,

    required this.hintName,
    required this.textName,
    required this.obsecureText,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(textName, style: whiteTextStyle),
          SizedBox(height: 6),
          Container(
            width: 500,
            decoration: BoxDecoration(
              color: const Color(0xff1E1E1E),
              borderRadius: BorderRadius.circular(4),
            ),
            child: TextFormField(
              controller: controller,
              style: whiteTextStyle.copyWith(fontSize: 14),
              cursorColor: Colors.white,
              obscureText: obsecureText,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 18,
                ),
                hintText: hintName,
                hintStyle: greyTextStyle,
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
