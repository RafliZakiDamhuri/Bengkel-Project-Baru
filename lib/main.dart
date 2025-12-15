import 'package:flutter/material.dart';
import 'package:get_x/get.dart';
import 'package:project/controller/homeController.dart';
import 'package:project/home.dart';

import 'package:sizer/sizer.dart';

void main() {
  Get.put(Homecontroller()); // hanya sekali, global

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          home: const Home(),
          routes: {'/': (context) => const Home()},
        );
      },
    );
  }
}
