import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:project/Auth/controller/auth_controller.dart';
import 'package:project/CMS/controller/cms_controller.dart';
import 'package:project/ProductDetail/controller/product_detail_controller.dart';
import 'package:project/controller/aboutUsController.dart';
import 'package:project/controller/contactUsController.dart';
import 'package:project/controller/globalController.dart';
import 'package:project/controller/homeController.dart';
import 'package:project/controller/mainProductController.dart';
import 'package:project/controller/searchProductController.dart';
import 'package:project/home.dart';
import 'package:project/routes/routes_name.dart';
import 'package:project/routes/routes_navigator.dart';
import 'package:project/search_product_page.dart';

import 'package:sizer/sizer.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy();
  await Supabase.initialize(
    url: 'https://hkuubnsamodgtlsgyhrv.supabase.co',
    anonKey: 'sb_publishable_ucLnPqx9eVJ3RILC2HwE1w_CjsGgvvF',
  );
  Get.put(Homecontroller());
  Get.put(GlobalController()); // hanya sekali, global
  Get.put(MainProductController());
  Get.put(AboutUsController());
  Get.put(Contactuscontroller());
  Get.put(AuthController());
  Get.put(Searchproductcontroller());
  Get.put(CmsController());
  Get.put(ProductDetailController());

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
          initialRoute: AppRouteName.home,
          getPages: AppPages.pages,
          defaultTransition: Transition.fadeIn,
          transitionDuration: const Duration(milliseconds: 500),
        );
      },
    );
  }
}
