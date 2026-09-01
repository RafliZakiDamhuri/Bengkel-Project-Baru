import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:project/about_us_page.dart';
import 'package:project/appbar/appbar_element.dart';
import 'package:project/contact_us_page.dart';
import 'package:project/controller/homeController.dart';
import 'package:project/controller/mainProductController.dart';
import 'package:project/controller/searchProductController.dart';
import 'package:project/global%20widget/footer.dart';
import 'package:project/global%20widget/personalData.dart';
import 'package:project/Inquiry/presentation/inquiry.dart';
import 'package:project/model/productModel.dart';
import 'package:project/product_page.dart';
import 'package:project/routes/routes_name.dart';
import 'package:project/search_product_page.dart';
import 'package:project/theme/app_images.dart';
import 'package:project/theme/string.dart';
import 'package:project/theme/theme.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

class Globalappbar extends StatefulWidget {
  Widget pageWidget;
  bool isNeedInquiryPage;
  bool isNeedScrollButton;
  Color backgroundColor;

  Globalappbar({
    super.key,
    required this.pageWidget,
    this.isNeedInquiryPage = true,
    this.isNeedScrollButton = true,
    this.backgroundColor = Colors.white,
  });

  @override
  State<Globalappbar> createState() => _GlobalappbarState();
}

class _GlobalappbarState extends State<Globalappbar> {
  final ScrollController scrollController = ScrollController();

  bool isDesktop(double width) => width >= 900;

  bool isTablet(double width) => width >= 600 && width < 900;

  bool isMobile(double width) => width < 600;

  final Homecontroller homecontroller = Get.find<Homecontroller>();

  final MainProductController mainProductController =
      Get.find<MainProductController>();

  // =========================================================
  // WHATSAPP
  // =========================================================

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

  // =========================================================
  // CEK ROUTE AKTIF
  // =========================================================

  bool isActiveRoute(String route) {
    return Get.currentRoute == route;
  }

  // =========================================================
  // SEARCH PRODUCT AKTIF
  // =========================================================

  bool isSearchProductActive() {
    return Get.currentRoute.startsWith(AppRouteName.searchProduct);
  }

  // =========================================================
  // PRODUCT AKTIF
  // =========================================================

  bool isProductActive() {
    return Get.currentRoute == AppRouteName.product ||
        Get.currentRoute == AppRouteName.productDetailPage;
  }

  // =========================================================
  // NAVBAR ELEMENT
  //
  // TIDAK MENGUBAH UKURAN APPBAR ELEMENT
  // HANYA MENAMBAHKAN GARIS DI BAWAH
  // =========================================================

  Widget activeAppbarElement({required String title, required bool isActive}) {
    return Stack(
      alignment: Alignment.bottomCenter,
      clipBehavior: Clip.none,
      children: [
        AppbarElement(title: title),

        Positioned(
          bottom: -5,
          child: Container(
            margin: EdgeInsets.only(right: 20),
            width: 60,
            height: 2,
            decoration: BoxDecoration(
              color: isActive ? Colors.blue : Colors.transparent,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ],
    );
  }

  // =========================================================
  // SEARCH
  // =========================================================

  Widget search() {
    return GetBuilder<Homecontroller>(
      builder: (controller) {
        return TypeAheadField<ProductModel>(
          builder: (context, textController, focusNode) {
            return Container(
              height: 60,
              child: Center(
                child: TextFormField(
                  controller: textController,
                  focusNode: focusNode,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: kGreyColor,

                    suffixIcon: const Icon(Icons.search),

                    border: InputBorder.none,

                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: kGreyColor),
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                    ),

                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: kGreyColor),
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                    ),

                    hint: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Search Here',
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
            );
          },

          debounceDuration: const Duration(milliseconds: 500),

          itemBuilder: (context, value) {
            return ListTile(
              leading: const Icon(Icons.directions_car),
              subtitle: Text(value.productHeader ?? ''),
            );
          },

          onSelected: (value) {
            Get.toNamed(
              AppRouteName.productDetailPage,
              parameters: {
                'id': value.id.toString(),
                'category': value.categoryProducts ?? '',
              },
            );
          },

          suggestionsCallback: (search) async {
            if (search.isEmpty) {
              return [];
            }

            await controller.getDataByHeader(search);

            return controller.productModel;
          },
        );
      },
    );
  }

  // =========================================================
  // BUILD
  // =========================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.backgroundColor,

      // =====================================================
      // FLOATING BUTTON
      // =====================================================
      floatingActionButton: Column(
        mainAxisAlignment: widget.isNeedScrollButton
            ? MainAxisAlignment.center
            : MainAxisAlignment.end,
        children: [
          Visibility(
            visible: widget.isNeedScrollButton,
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 300, top: 400),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          scrollController.animateTo(
                            scrollController.offset - 500,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                          );
                        },
                        child: Image.asset(
                          AppImages().buttonUp,
                          width: 5.w,
                          height: 5.h,
                        ),
                      ),
                      SizedBox(height: 70),
                      GestureDetector(
                        onTap: () {
                          scrollController.animateTo(
                            scrollController.offset + 500,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                          );
                        },
                        child: Image.asset(
                          AppImages().buttonDown,
                          width: 5.w,
                          height: 5.h,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
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

      // =====================================================
      // APP BAR
      // =====================================================
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: kWhiteColor,

        title: LayoutBuilder(
          builder: (context, constraints) {
            // =================================================
            // MOBILE
            // =================================================

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
                  const SizedBox(width: 10),
                ],
              );
            }

            // =================================================
            // DESKTOP / TABLET
            // =================================================

            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // =================================================
                // LOGO
                // =================================================
                GestureDetector(
                  onTap: () {
                    Get.toNamed(AppRouteName.home);
                  },
                  child: Container(
                    width: 180,
                    height: 55,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(AppImages().imageHomePage2),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),

                const Spacer(),

                // =================================================
                // BAGIAN KANAN
                // =================================================
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // =================================================
                    // TOP MENU
                    // =================================================
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // =================================================
                        // ABOUT US
                        // =================================================
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(AppRouteName.aboutUs);
                          },
                          child: activeAppbarElement(
                            title: 'ABOUT US',
                            isActive: isActiveRoute(AppRouteName.aboutUs),
                          ),
                        ),

                        // =================================================
                        // INSIGHT
                        // =================================================
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(AppRouteName.blogList);
                          },
                          child: activeAppbarElement(
                            title: 'INSIGHT',
                            isActive: false,
                          ),
                        ),

                        // =================================================
                        // GALLERY
                        // =================================================
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(AppRouteName.gallery);
                          },
                          child: activeAppbarElement(
                            title: 'GALLERY',
                            isActive: false,
                          ),
                        ),

                        // =================================================
                        // RESOURCES
                        // =================================================
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(AppRouteName.resources);
                          },
                          child: activeAppbarElement(
                            title: 'RESOURCES',
                            isActive: false,
                          ),
                        ),

                        // =================================================
                        // CAREERS
                        // =================================================
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(AppRouteName.careers);
                          },
                          child: activeAppbarElement(
                            title: 'CAREERS',
                            isActive: false,
                          ),
                        ),

                        // =================================================
                        // PEMBATAS
                        // =================================================
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 14),
                          child: Text(
                            '|',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        // =================================================
                        // LANGUAGE
                        // =================================================
                        const Text(
                          'LANGUAGE: EN',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 3),

                    // =================================================
                    // BOTTOM MENU
                    // =================================================
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // =================================================
                        // HOME
                        // =================================================
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(AppRouteName.home);
                          },
                          child: activeAppbarElement(
                            title: AppString().appBar0,
                            isActive: isActiveRoute(AppRouteName.home),
                          ),
                        ),

                        // =================================================
                        // PRODUCTS
                        // =================================================
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(AppRouteName.product);
                          },
                          child: GetBuilder<MainProductController>(
                            builder: (controller) {
                              return HoverDropdownMenu(
                                title: AppString().appBar1,

                                isActive: isProductActive(),

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

                        // =================================================
                        // SERVICES
                        // =================================================
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(AppRouteName.services);
                          },
                          child: HoverDropdownMenu(
                            title: AppString().appBar2,

                            isActive: isActiveRoute(AppRouteName.services),

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

                        // =================================================
                        // CATALOGUE
                        // =================================================
                        HoverDropdownMenu(
                          title: AppString().appBar3,

                          isActive: isSearchProductActive(),

                          items: List.generate(
                            homecontroller.categoryType.length,
                            (index) {
                              return HoverDropdownItem(
                                title: _formatCategoryName(
                                  homecontroller.categoryType[index].camelCase,
                                ),
                                onTap: () {
                                  final searchController =
                                      Get.find<Searchproductcontroller>();

                                  searchController.productModel.clear();

                                  searchController.clearText();

                                  searchController.update();

                                  Get.offNamed(
                                    '${AppRouteName.searchProduct}?flow=${Uri.encodeComponent(homecontroller.categoryType[index].toString())}',
                                  );
                                },
                              );
                            },
                          ),
                        ),

                        // =================================================
                        // INQUIRY
                        // =================================================
                        GestureDetector(
                          onTap: () {
                            try {
                              Get.toNamed(AppRouteName.inquiryPage);
                            } catch (e) {
                              print('Ini adalah error : $e');
                            }
                          },
                          child: activeAppbarElement(
                            title: 'INQUIRY',
                            isActive: false,
                          ),
                        ),

                        // =================================================
                        // CONTACTS
                        // =================================================
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(AppRouteName.contactPage);
                          },
                          child: activeAppbarElement(
                            title: AppString().appBar6,
                            isActive: isActiveRoute(AppRouteName.contactUs),
                          ),
                        ),

                        // =================================================
                        // SEARCH
                        // =================================================
                        const SizedBox(width: 25),

                        SizedBox(width: 195, child: search()),
                      ],
                    ),
                  ],
                ),
              ],
            );
          },
        ),

        automaticallyImplyLeading: isMobile(MediaQuery.of(context).size.width),
      ),

      // =====================================================
      // DRAWER MOBILE
      // =====================================================
      drawer: isMobile(MediaQuery.of(context).size.width)
          ? Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  DrawerHeader(child: Text(AppString().drawerTitle)),

                  ListTile(
                    title: Text(AppString().appBar1),
                    onTap: () {
                      Get.to(() => ProductPage());
                    },
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

      // =====================================================
      // BODY
      // =====================================================
      body: SingleChildScrollView(
        controller: scrollController,
        child: Column(
          children: [
            widget.pageWidget,

            widget.isNeedInquiryPage ? personaldata() : Container(),

            footer(),
          ],
        ),
      ),
    );
  }

  // =========================================================
  // FORMAT CATEGORY
  // =========================================================

  String _formatCategoryName(String? value) {
    if (value == null || value.isEmpty) {
      return '';
    }

    return value
        .replaceAllMapped(RegExp(r'([a-z])([A-Z])'), (m) => '${m[1]} ${m[2]}')
        .split(' ')
        .map((e) => '${e[0].toUpperCase()}${e.substring(1)}')
        .join(' ');
  }
}

// =============================================================
// HOVER DROPDOWN ITEM
// =============================================================

class HoverDropdownItem {
  final String title;
  final VoidCallback onTap;

  HoverDropdownItem({required this.title, required this.onTap});
}

// =============================================================
// HOVER DROPDOWN MENU
// =============================================================

class HoverDropdownMenu extends StatefulWidget {
  final String title;
  final List<HoverDropdownItem> items;

  final bool isActive;

  const HoverDropdownMenu({
    super.key,
    required this.title,
    required this.items,
    this.isActive = false,
  });

  @override
  State<HoverDropdownMenu> createState() => _HoverDropdownMenuState();
}

class _HoverDropdownMenuState extends State<HoverDropdownMenu> {
  final MenuController _controller = MenuController();

  bool _isHoverAnchor = false;
  bool _isHoverMenu = false;

  // =========================================================
  // CLOSE DROPDOWN
  // =========================================================

  void _checkClose() {
    Future.delayed(const Duration(milliseconds: 300), () {
      if (!_isHoverAnchor && !_isHoverMenu) {
        _controller.close();
      }
    });
  }

  // =========================================================
  // BUILD
  // =========================================================

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

      // =======================================================
      // DROPDOWN ITEMS
      // =======================================================
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

      // =======================================================
      // ANCHOR
      // =======================================================
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

          child: Stack(
            alignment: Alignment.bottomCenter,
            clipBehavior: Clip.none,
            children: [
              // TEXT
              AppbarElement(title: widget.title),

              // GARIS
              Positioned(
                bottom: -5,
                child: Container(
                  margin: EdgeInsets.only(right: 20),
                  width: 90,
                  height: 2,
                  decoration: BoxDecoration(
                    color: widget.isActive ? Colors.blue : Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
