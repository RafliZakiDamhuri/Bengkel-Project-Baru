import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:project/appbar/appbar_element.dart';
import 'package:project/controller/homeController.dart';
import 'package:project/detail_product.dart';
import 'package:project/global%20widget/footer.dart';
import 'package:project/global%20widget/personalData.dart';
import 'package:project/model/allDataModel.dart';
import 'package:project/product_page.dart';
import 'package:project/search_product_page.dart';
import 'package:project/theme/app_images.dart';
import 'package:project/theme/services_page.dart';
import 'package:project/theme/string.dart';
import 'package:project/theme/theme.dart';
import 'package:sizer/sizer.dart';

class Globalappbar extends StatefulWidget {
  Widget pageWidget;
  Globalappbar({super.key, required this.pageWidget});

  @override
  State<Globalappbar> createState() => _GlobalappbarState();
}

class _GlobalappbarState extends State<Globalappbar> {
  bool isDesktop(double width) => width >= 900;

  bool isTablet(double width) => width >= 600 && width < 900;

  bool isMobile(double width) => width < 600;

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
      floatingActionButton: Image.asset(
        AppImages().il_whastapp,
        width: 5.w,
        height: 5.h,
      ),
      appBar: AppBar(
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
                  // Gunakan Expanded di sini agar bagian kiri mengambil sisa ruang yang ada
                  // sehingga spaceBetween di Row utama bisa mendorong menu kanan ke pojok.
                  Row(
                    // Sekarang spaceAround akan bekerja karena sudah ada ruang dari Expanded
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // Logo dan Judul
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 50.w,
                            height: 100,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(AppImages().imageHomePage2),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                        ],
                      ),

                      const SizedBox(
                        width: 20,
                      ), // Jarak antara judul dan search bar
                      // Bagian Search
                    ],
                  ),

                  // Row Menu Kanan (Tetap di pojok kanan)
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: () => Get.to(() => ProductPage()),
                        child: AppbarElement(title: AppString().appBar1),
                      ),
                      GestureDetector(
                        onTap: () => Get.to(() => ServicesPage()),
                        child: AppbarElement(title: AppString().appBar2),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.to(SearchProductPage());
                        },
                        child: AppbarElement(title: AppString().appBar3),
                      ),

                      AppbarElement(title: AppString().appBar4),
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
                  ListTile(title: Text(AppString().appBar1), onTap: () {}),
                  ListTile(title: Text(AppString().appBar2), onTap: () {}),
                  ListTile(title: Text(AppString().appBar3), onTap: () {}),
                ],
              ),
            )
          : null,
      body: SingleChildScrollView(
        child: Column(children: [widget.pageWidget, personaldata(), footer()]),
      ),
    );
  }
}
