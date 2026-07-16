import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:project/about_us_page.dart';
import 'package:project/appbar/appbar_element.dart';
import 'package:project/contact_us_page.dart';
import 'package:project/controller/homeController.dart';
import 'package:project/controller/mainProductController.dart';
import 'package:project/detail_product.dart';
import 'package:project/global%20widget/footer.dart';
import 'package:project/global%20widget/personalData.dart';
import 'package:project/home.dart';
import 'package:project/login_page.dart';
import 'package:project/model/allDataModel.dart';
import 'package:project/product_page.dart';
import 'package:project/routes/routes_name.dart';
import 'package:project/search_product_page.dart';
import 'package:project/theme/app_images.dart';
import 'package:project/theme/services_page.dart';
import 'package:project/theme/string.dart';
import 'package:project/theme/theme.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

class Globalappbar extends StatefulWidget {
  Widget pageWidget;
  bool isNeedInquiryPage;
  bool isNeedScrollButton;
  Globalappbar({
    super.key,
    required this.pageWidget,
    this.isNeedInquiryPage = true,
    this.isNeedScrollButton = false,
  });

  @override
  State<Globalappbar> createState() => _GlobalappbarState();
}

class _GlobalappbarState extends State<Globalappbar> {
  bool isDesktop(double width) => width >= 900;
  final ScrollController scrollController = ScrollController();
  bool isTablet(double width) => width >= 600 && width < 900;

  bool isMobile(double width) => width < 600;
  Future<void> openWhatsApp(String phone, String message) async {
    final url = Uri.parse(
      "https://wa.me/$phone?text=${Uri.encodeComponent(message)}",
    );

    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch WhatsApp';
    }
  }

  var homecontroller = Get.find<Homecontroller>();
  var mainProductController = Get.find<MainProductController>();
  // var globalController = Get.find<GlobalController>();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    Widget search() {
      return GetBuilder<Homecontroller>(
        builder: (controller) {
          return TypeAheadField<AllDataModel>(
            builder: (context, controller, focusNode) => Container(
              height: 60,

              child: Center(
                child: TextFormField(
                  controller: controller,
                  focusNode: focusNode,

                  decoration: InputDecoration(
                    filled: true,
                    fillColor: kGreyColor,
                    suffixIcon: Icon(Icons.search),
                    border: InputBorder.none,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: kGreyColor),
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: kGreyColor),
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    hint: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Cari berdasarkan plat number',
                            style: blackTextStyle.copyWith(
                              fontSize: 10.sp,
                              fontWeight: light,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            debounceDuration: const Duration(milliseconds: 500),
            itemBuilder: (context, value) {
              return ListTile(
                leading: const Icon(Icons.directions_car),
                title: Text(value.platNumber?.platNumber ?? ''),
                subtitle: Text(value.coreTypeModel?.coreType ?? ''),
              );
            },
            onSelected: (value) {
              Get.to(DetailProduct(allDataModel: value));
            },
            suggestionsCallback: (search) async {
              if (search.isEmpty) return [];
              await controller.getDatabyPlatNumber(search);

              return controller.allDataModel;
            },
          );
        },
      );
    }

    return Scaffold(
      floatingActionButton: Column(
        mainAxisAlignment: widget.isNeedScrollButton
            ? MainAxisAlignment.center
            : MainAxisAlignment.end,
        children: [
          Visibility(
            visible: widget.isNeedScrollButton,
            child: Container(
              margin: EdgeInsets.only(bottom: 400, top: 400),
              child: GestureDetector(
                onTap: () {
                  scrollController.animateTo(
                    scrollController.offset + 500,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  );
                },
                child: Image.asset(AppImages().scroll, width: 5.w, height: 5.h),
              ),
            ),
          ),

          GestureDetector(
            onTap: () {
              openWhatsApp(
                AppString().indocoolWhatsappNumber,
                "I opened the Indocool website, I want to know your business!",
              );
            },
            child: Image.asset(
              AppImages().il_whastapp,
              width: 5.w,
              height: 5.h,
            ),
          ),
        ],
      ),
      appBar: AppBar(
        toolbarHeight: 90,
        backgroundColor: kAppbarBackgroundColor,

        title: LayoutBuilder(
          builder: (context, constraints) {
            if (isMobile(constraints.maxWidth)) {
              return Row(
                children: [
                  Container(
                    width: 200,
                    height: 40,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(AppImages().imageHomePage2),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                ],
              );
            } else {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // Logo dan Judul
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.toNamed(AppRouteName.home);
                            },
                            child: Container(
                              width: 264,
                              height: 64,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(AppImages().imageHomePage2),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                        ],
                      ),

                      const SizedBox(width: 20),
                    ],
                  ),

                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: () => Get.toNamed(AppRouteName.home),
                        child: AppbarElement(title: AppString().appBar0),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(AppRouteName.product);
                        },
                        child: GetBuilder<MainProductController>(
                          builder: (controller) {
                            return HoverDropdownMenu(
                              title: AppString().appBar1,

                              items: List.generate(
                                controller.mainProductModel?.length ?? 0,

                                (index) {
                                  return HoverDropdownItem(
                                    title:
                                        controller
                                            .mainProductModel?[index]
                                            .productName ??
                                        '',

                                    onTap: () {
                                      Get.toNamed(AppRouteName.product);
                                    },
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(AppRouteName.services);
                        },
                        child: HoverDropdownMenu(
                          title: AppString().appBar2,

                          items: List.generate(
                            homecontroller.serviceModel?.length ?? 0,

                            (index) {
                              return HoverDropdownItem(
                                title:
                                    homecontroller
                                        .serviceModel?[index]
                                        .serviceName ??
                                    '',

                                onTap: () {
                                  Get.toNamed(AppRouteName.services);
                                },
                              );
                            },
                          ),
                        ),
                      ),

                      GestureDetector(
                        onTap: () {
                          Get.toNamed(AppRouteName.searchProduct);
                        },
                        child: AppbarElement(title: AppString().appBar3),
                      ),

                      GestureDetector(
                        onTap: () {
                          Get.toNamed(AppRouteName.register);

                          // Get.toNamed(AppRouteName.aboutUs);
                        },
                        child: AppbarElement(title: AppString().appBar5),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(AppRouteName.contactUs);
                        },
                        child: AppbarElement(title: AppString().appBar6),
                      ),

                      SizedBox(width: screenWidth * 0.1, child: search()),
                    ],
                  ),
                ],
              );
            }
          },
        ),

        automaticallyImplyLeading: isMobile(MediaQuery.of(context).size.width),
      ),
      drawer: isMobile(MediaQuery.of(context).size.width)
          ? Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  DrawerHeader(child: Text(AppString().drawerTitle)),
                  ListTile(
                    title: Text(AppString().appBar1),
                    onTap: () => Get.to(() => ProductPage()),
                  ),
                  ListTile(
                    title: Text(AppString().appBar2),
                    onTap: () {
                      Get.to(SearchProductPage());
                    },
                  ),
                  ListTile(
                    title: Text(AppString().appBar3),
                    onTap: () {
                      Get.to(SearchProductPage());
                    },
                  ),
                  ListTile(
                    title: Text(AppString().appBar5),
                    onTap: () {
                      Get.to(AboutUsPage());
                    },
                  ),
                  ListTile(
                    title: Text(AppString().appBar6),
                    onTap: () {
                      Get.to(ContactUsPage());
                    },
                  ),
                ],
              ),
            )
          : null,
      body: SingleChildScrollView(
        controller: scrollController,
        child: Column(
          children: [
            widget.pageWidget,
            (widget.isNeedInquiryPage == false) ? Container() : personaldata(),
            footer(),
          ],
        ),
      ),
    );
  }
}

class HoverDropdownItem {
  final String title;
  final VoidCallback onTap;

  HoverDropdownItem({required this.title, required this.onTap});
}

class HoverDropdownMenu extends StatefulWidget {
  final String title;
  final List<HoverDropdownItem> items;

  const HoverDropdownMenu({
    super.key,
    required this.title,
    required this.items,
  });

  @override
  State<HoverDropdownMenu> createState() => _HoverDropdownMenuState();
}

class _HoverDropdownMenuState extends State<HoverDropdownMenu> {
  final MenuController _controller = MenuController();

  bool _isHoverAnchor = false;
  bool _isHoverMenu = false;

  void _checkClose() {
    Future.delayed(const Duration(milliseconds: 300), () {
      if (!_isHoverAnchor && !_isHoverMenu) {
        _controller.close();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MenuAnchor(
      controller: _controller,

      alignmentOffset: const Offset(-10, 20),

      style: MenuStyle(
        elevation: const WidgetStatePropertyAll(12),

        backgroundColor: const WidgetStatePropertyAll(Colors.white),

        surfaceTintColor: const WidgetStatePropertyAll(Colors.transparent),

        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        ),
      ),

      menuChildren: [
        MouseRegion(
          onEnter: (_) {
            _isHoverMenu = true;
          },

          onExit: (_) {
            _isHoverMenu = false;
            _checkClose();
          },

          child: Column(
            children: widget.items.map((item) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: MenuItemButton(
                  onPressed: item.onTap,

                  child: SizedBox(width: 180, child: Text(item.title)),
                ),
              );
            }).toList(),
          ),
        ),
      ],

      builder: (context, controller, child) {
        return MouseRegion(
          onEnter: (_) {
            _isHoverAnchor = true;
            controller.open();
          },

          onExit: (_) {
            _isHoverAnchor = false;
            _checkClose();
          },

          child: AppbarElement(title: widget.title),
        );
      },
    );
  }
}
