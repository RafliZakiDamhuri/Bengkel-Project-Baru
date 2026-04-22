import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

void showLoadingDialog({String message = "Loading..."}) {
  Get.dialog(
    Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 16),
              Text(message),
            ],
          ),
        ),
      ),
    ),
    barrierDismissible: false,
  );
}

Widget globalLoading() {
  return Center(
    child: LoadingAnimationWidget.beat(color: Colors.white, size: 200),
  );
}

void hideLoadingDialog() {
  if (Get.isDialogOpen ?? false) {
    Get.back();
  }
}
