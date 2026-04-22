import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:project/controller/mainProductController.dart';
import 'package:project/global%20widget/baseLayoutWrapper.dart';
import 'package:project/global%20widget/footer.dart';
import 'package:project/global%20widget/globalAppBar.dart';
import 'package:project/global%20widget/personalData.dart';
import 'package:project/theme/app_images.dart';
import 'package:project/theme/string.dart';
import 'package:project/theme/theme.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(MainProductController());
    var mainProductController = Get.find<MainProductController>();
    Widget headerProduct({String? description, String? image}) {
      return Container(
        margin: EdgeInsets.only(right: 24),
        child: Column(
          children: [
            Image.asset(image ?? '', width: 300, height: 300),
            SizedBox(height: 19),
            Text(description ?? '', style: blackTextStyle),
          ],
        ),
      );
    }

    Widget productIntroductionContent() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppString().introductionTextTitle,
                style: blackTextStyle.copyWith(
                  fontSize: 36,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                AppString().introductionTextSubtitle,
                style: blackTextStyle.copyWith(
                  fontSize: 20,

                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(right: 24),
            child: Image.asset(
              AppImages().imgIntroductionProductImage,
              width: 800,
              height: 800,
            ),
          ),
        ],
      );
    }

    Widget productIntroductionContentMobile() {
      return Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                AppString().introductionTextTitle,
                style: blackTextStyle.copyWith(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                AppString().introductionTextSubtitle,
                style: blackTextStyle.copyWith(
                  fontSize: 16,

                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          SizedBox(height: 24),
          Image.asset(AppImages().imgIntroductionProductImage),
        ],
      );
    }

    Widget learnMoreButton({
      String text = "Learn More",
      required VoidCallback onTap,
    }) {
      return InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.black12),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                text,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 8),
              const Icon(Icons.arrow_forward, size: 18),
            ],
          ),
        ),
      );
    }

    Widget mainProductContent() {
      return Column(
        children: List.generate(
          mainProductController.mainProductModel?.length ?? 0,
          (index) {
            var data = mainProductController.mainProductModel?[index];
            return Container(
              width: Get.width,
              color: lightGrey,
              child: Container(
                margin: EdgeInsets.only(left: 140, right: 500, top: 80),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.network(
                      data?.imageUrl ?? '',
                      width: 400,
                      height: 400,
                    ),
                    SizedBox(width: 100),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data?.productName ?? '',

                            style: blackTextStyle.copyWith(
                              fontSize: 32,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 26),
                          Text(
                            data?.description.replaceAll(r'\n', '\n') ?? '',
                            style: blackTextStyle.copyWith(fontSize: 12),
                          ),
                          const SizedBox(height: 26),
                          learnMoreButton(onTap: () {}),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
    }

    Widget mainProductContentMobile() {
      return Container(
        width: Get.width,
        color: lightGrey,
        margin: EdgeInsets.only(top: 40),
        child: Container(
          margin: EdgeInsets.only(top: 40, left: 12, right: 12),

          child: Column(
            children: List.generate(
              mainProductController.mainProductModel?.length ?? 0,
              (index) {
                var data = mainProductController.mainProductModel?[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      data?.productName ?? '',

                      style: blackTextStyle.copyWith(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Image.network(data?.imageUrl ?? ''),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 26),
                        Text(
                          data?.description.replaceAll(r'\n', '\n') ?? '',
                          style: blackTextStyle.copyWith(fontSize: 12),
                        ),
                        const SizedBox(height: 12),
                        learnMoreButton(onTap: () {}),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      );
    }

    Widget desktopWidget() {
      return Container(
        margin: EdgeInsets.only(top: 20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: headerProduct(
                    description: AppString().productHeaderDescription1,
                    image: AppImages().imgHeaderProduct1,
                  ),
                ),
                Container(
                  child: headerProduct(
                    description: AppString().productHeaderDescription2,
                    image: AppImages().imgHeaderProduct2,
                  ),
                ),
                Container(
                  child: headerProduct(
                    description: AppString().productHeaderDescription3,
                    image: AppImages().imgHeaderProduct3,
                  ),
                ),
                Container(
                  child: headerProduct(
                    description: AppString().productHeaderDescription4,
                    image: AppImages().imgHeaderProduct4,
                  ),
                ),
                Container(
                  child: headerProduct(
                    description: AppString().productHeaderDescription5,
                    image: AppImages().imgHeaderProduct5,
                  ),
                ),
              ],
            ),

            productIntroductionContent(),
            mainProductContent(),
          ],
        ),
      );
    }

    Widget mobileWidget() {
      return Container(
        margin: EdgeInsets.only(top: 24),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                margin: EdgeInsets.only(left: 12, right: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: headerProduct(
                        description: AppString().productHeaderDescription1,
                        image: AppImages().imgHeaderProduct1,
                      ),
                    ),
                    Container(
                      child: headerProduct(
                        description: AppString().productHeaderDescription2,
                        image: AppImages().imgHeaderProduct2,
                      ),
                    ),
                    Container(
                      child: headerProduct(
                        description: AppString().productHeaderDescription3,
                        image: AppImages().imgHeaderProduct3,
                      ),
                    ),
                    Container(
                      child: headerProduct(
                        description: AppString().productHeaderDescription4,
                        image: AppImages().imgHeaderProduct4,
                      ),
                    ),
                    Container(
                      child: headerProduct(
                        description: AppString().productHeaderDescription5,
                        image: AppImages().imgHeaderProduct5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 40),
            productIntroductionContentMobile(),
            mainProductContentMobile(),
          ],
        ),
      );
    }

    return GetBuilder<MainProductController>(
      initState: (state) async {
        await mainProductController.getProduct();
      },
      builder: (controller) {
        return Globalappbar(
          pageWidget: SingleChildScrollView(
            child: Column(
              children: [
                ResponsiveLayout(
                  mobile: mobileWidget(),
                  desktop: desktopWidget(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
