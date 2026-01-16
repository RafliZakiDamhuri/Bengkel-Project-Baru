import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:project/controller/homeController.dart';
import 'package:project/home.dart';
import 'package:project/search_product_page.dart';

import 'package:sizer/sizer.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  await Supabase.initialize(
    url: 'https://hkuubnsamodgtlsgyhrv.supabase.co',
    anonKey: 'sb_publishable_ucLnPqx9eVJ3RILC2HwE1w_CjsGgvvF',
  );
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
          routes: {'/cek': (context) => const Home()},
        );
      },
    );
  }
}
