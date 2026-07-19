import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:project/Auth/controller/auth_controller.dart';
import 'package:project/CMS/presentation/cms.dart';
import 'package:project/CMS/presentation/edit_data.dart';
import 'package:project/about_us_page.dart';
import 'package:project/contact_us_page.dart';
import 'package:project/home.dart';
import 'package:project/Auth/presentation/login_page.dart';
import 'package:project/product_page.dart';
import 'package:project/Auth/presentation/register_page.dart';
import 'package:project/routes/routes_name.dart';
import 'package:project/search_product_page.dart';
import 'package:project/theme/services_page.dart';

class AppPages {
  static final pages = [
    GetPage(name: AppRouteName.home, page: () => const Home()),
    GetPage(name: AppRouteName.product, page: () => const ProductPage()),
    GetPage(
      name: AppRouteName.searchProduct,
      page: () => const SearchProductPage(),
    ),
    GetPage(name: AppRouteName.aboutUs, page: () => const AboutUsPage()),
    GetPage(name: AppRouteName.contactUs, page: () => const ContactUsPage()),
    GetPage(name: AppRouteName.services, page: () => const ServicesPage()),
    GetPage(name: AppRouteName.login, page: () => const LoginPage()),
    GetPage(
      name: AppRouteName.register,
      page: () => const RegisterPage(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(name: AppRouteName.cms, page: () => CmsPage()),
    GetPage(name: AppRouteName.editData, page: () => EditData()),
  ];
}
