import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:get/get.dart';
import 'package:project/Auth/controller/auth_controller.dart';
import 'package:project/CMS/controller/blog_controller.dart';
import 'package:project/CMS/controller/cms_controller.dart';
import 'package:project/CMS/controller/gallery_controller.dart';
import 'package:project/CMS/controller/resources_controller.dart';
import 'package:project/Inquiry/controller/inquiry_controller.dart';
import 'package:project/ProductDetail/controller/product_detail_controller.dart';
import 'package:project/controller/aboutUsController.dart';
import 'package:project/controller/contactUsController.dart';
import 'package:project/controller/globalController.dart';
import 'package:project/controller/homeController.dart';
import 'package:project/controller/mainProductController.dart';
import 'package:project/controller/searchProductController.dart';
import 'package:project/core/config/app_config.dart';
import 'package:project/gallery/controller/gallery_controller.dart';
import 'package:project/routes/routes_navigator.dart';
import 'package:sizer/sizer.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

import 'package:project/routes/routes_name.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy();
  await Supabase.initialize(
    url: AppConfig.supabaseUrl,
    anonKey: AppConfig.supabaseAnonKey,
  );
  Get.put(HomeController());
  Get.put(GlobalController());
  Get.put(MainProductController());
  Get.put(AboutUsController());
  Get.put(ContactUsController());
  Get.put(AuthController());
  Get.put(SearchProductController());
  Get.put(CmsController());
  Get.put(ProductDetailController());
  Get.put(BlogController());
  Get.put(CMSGalleryController());
  Get.put(GalleryController());
  Get.put(ResourcesController());
  Get.put(InquiryController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return GetMaterialApp(
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            FlutterQuillLocalizations.delegate,
          ],
          supportedLocales: const [Locale('en'), Locale('id')],
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
