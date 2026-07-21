import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:project/global%20widget/globalAppBar.dart';
import 'package:project/product_detail_title.dart';
import 'package:project/routes/routes_name.dart';
import 'package:project/theme/theme.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Globalappbar(
      pageWidget: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// KIRI
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProductDetailTitle(title1: 'Catalog Number', title2: 'ISCR001'),
                ProductDetailTitle(title1: 'Makes', title2: 'Komatsu'),
                ProductDetailTitle(title1: 'Equipment Type', title2: 'Truck'),
                ProductDetailTitle(title1: 'Models', title2: 'HD785-7'),
                ProductDetailTitle(title1: 'Industry', title2: 'Mining'),
                ProductDetailTitle(
                  title1: 'OEM Part Number',
                  title2: '1111-223',
                ),
                ProductDetailTitle(
                  title1: 'Product Type',
                  title2: 'Radiator Assembly',
                ),
                ProductDetailTitle(
                  title1: 'Product Type Design',
                  title2: 'Removable Tube',
                ),
                ProductDetailTitle(title1: 'Material Type', title2: 'Copper'),
                ProductDetailTitle(
                  title1: 'Description / Application',
                  title2:
                      'Scratch Build Removable Tube Copper\nRadiator Assembly',
                ),

                const SizedBox(height: 80),

                GestureDetector(
                  onTap: () {
                    Get.toNamed(AppRouteName.searchProduct);
                  },
                  child: Container(
                    width: 280,
                    height: 67,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          'assets/images/Rectangle 48_result.webp',
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'REQUEST A QUOTE',
                          style: whiteTextStyle.copyWith(
                            fontSize: 14,
                            fontWeight: bold,
                          ),
                        ),
                        SizedBox(width: 8),
                        Container(
                          width: 20,
                          height: 17,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                'assets/images/Logo-SHop 1_result.webp',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(width: 120),

            /// KANAN
            Column(
              children: [
                Container(
                  width: 340,
                  height: 340,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Image.asset(
                    'assets/images/Detail1.png',
                    fit: BoxFit.contain,
                  ),
                ),

                const SizedBox(height: 10),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: const Text(
                        '2D Drawing Front and Side View',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),

                    const SizedBox(width: 25),

                    GestureDetector(
                      onTap: () {},
                      child: const Text(
                        '3D Drawing',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
