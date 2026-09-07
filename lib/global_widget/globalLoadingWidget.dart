import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

void showLoadingDialog({String message = "Loading..."}) {
  Get.dialog(
    PopScope(
      canPop: false,
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: LoadingAnimationWidget.beat(color: Colors.blue, size: 80),
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
