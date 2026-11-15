import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:project/Auth/controller/auth_controller.dart';
import 'package:project/CMS/presentation/cms.dart';
import 'package:project/CMS/presentation/edit_data.dart';
import 'package:project/CMS/presentation/edit_resources.dart';
import 'package:project/CMS/presentation/edit_blog.dart';
import 'package:project/about_us_page.dart';
import 'package:project/blog/presentation/blog_list.dart';
import 'package:project/careers_page.dart';
import 'package:project/blog/presentation/blog_detail.dart';
import 'package:project/contact.dart';
import 'package:project/contact_us_page.dart';
import 'package:project/gallery/presentation/gallery.dart';
import 'package:project/home.dart';
import 'package:project/Auth/presentation/login_page.dart';
import 'package:project/ProductDetail/presentation/product_detail_page.dart';

import 'package:project/Inquiry/presentation/inquiry.dart';
import 'package:project/product/catterpillar_tube_and_shell.dart';
import 'package:project/product/light_duty_radiator_core.dart';
import 'package:project/product/air_cooled.dart';
import 'package:project/product/catterpillar_replacement.dart';
import 'package:project/product/heavy_duty_cooler.dart';
import 'package:project/product/heavy_duty_cooper.dart';
import 'package:project/product/industrial_shell.dart';
import 'package:project/product/plated_heat.dart';
import 'package:project/product/radiator_engine.dart';
import 'package:project/product/radmax_lever_release.dart';
import 'package:project/product/replacement_fan.dart';
import 'package:project/product_page.dart';
import 'package:project/Auth/presentation/register_page.dart';
import 'package:project/radiator_core.dart';
import 'package:project/product/radmax_removable_tube_radiator.dart';
import 'package:project/resources/presentation/resouces.dart';
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
    GetPage(name: AppRouteName.radiator, page: () => const RadiatorCore()),
    GetPage(name: AppRouteName.inquiryPage, page: () => InquiryPage()),
    GetPage(name: AppRouteName.contactPage, page: () => Contact()),

    GetPage(name: AppRouteName.blogDetail, page: () => const BlogDetail()),
    GetPage(
      name: AppRouteName.register,
      page: () => const RegisterPage(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: AppRouteName.cms,
      page: () => CmsPage(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(name: AppRouteName.editData, page: () => EditData()),
    GetPage(
      name: AppRouteName.productDetailPage,
      page: () => const ProductDetailPage(),
    ),
    GetPage(name: AppRouteName.careers, page: () => const CareersPage()),

    GetPage(name: AppRouteName.blogList, page: () => const BlogListPage()),
    GetPage(name: AppRouteName.editBlog, page: () => EditBlog()),
    GetPage(name: AppRouteName.gallery, page: () => IndocoolGalleryScreen()),
    GetPage(
      name: AppRouteName.resources,
      page: () => DownloadableResourcesPage(),
    ),
    GetPage(name: AppRouteName.editResources, page: () => EditResources()),
    GetPage(
      name: AppRouteName.radmaxRemovableTubeRadiator,
      page: () => RadmaxRemovableTubeRadiator(),
    ),
    GetPage(
      name: AppRouteName.lightDutyRadiator,
      page: () => LightDutyRadiatorCore(),
    ),
    GetPage(name: AppRouteName.heavyDutyCooler, page: () => HeavyDutyCooler()),
    GetPage(name: AppRouteName.heavyDutyCooper, page: () => HeavyDutyCooper()),
    GetPage(name: AppRouteName.airCooled, page: () => AirCooled()),
    GetPage(
      name: AppRouteName.industrialShell,
      page: () => const IndustrialShell(),
    ),
    GetPage(name: AppRouteName.platedHeat, page: () => const PlatedHeat()),
    GetPage(
      name: AppRouteName.radmaxLevelRelease,
      page: () => const RadmaxLeverRelease(),
    ),
    GetPage(
      name: AppRouteName.replacementFan,
      page: () => const ReplacementFan(),
    ),
    GetPage(
      name: AppRouteName.radiatorEngine,
      page: () => const RadiatorEngine(),
    ),
    GetPage(
      name: AppRouteName.catterpillarReplacement,
      page: () => const CatterpillarReplacement(),
    ),
    GetPage(
      name: AppRouteName.catterpillarTubeAndShell,
      page: () => const CatterpillarTubeAndShell(),
    ),
  ];
}
