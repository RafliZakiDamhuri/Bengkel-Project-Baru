import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showSuccessDialog(String title, String message, String buttonText) {
  Get.dialog(
    AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(onPressed: () => Get.back(), child: Text(buttonText)),
      ],
    ),
    barrierDismissible: false,
  );
}
