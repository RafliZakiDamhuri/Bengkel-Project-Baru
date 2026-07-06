import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:project/controller/mainProductController.dart';
import 'package:project/global%20widget/baseLayoutWrapper.dart';
import 'package:project/global%20widget/customButton.dart';
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
      return Stack(
        children: [
          Image.asset(
            AppImages().incoCoolProductList,
            width: double.infinity,
            fit: BoxFit.fitWidth,
          ),

          Padding(
            padding: const EdgeInsets.only(left: 120, top: 165),
            child: SizedBox(
              width: Get.width / 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'INDOCOOL PRODUCT\nPORTFOLIO',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 40),
                  Row(
                    children: [
                      Expanded(
                        child: Html(
                          data: AppString().productListDescription,
                          style: {
                            "body": Style(
                              color: Colors.white,
                              fontSize: FontSize(24),
                              margin: Margins.zero,
                              padding: HtmlPaddings.zero,
                              lineHeight: const LineHeight(1.5),
                            ),
                            "p": Style(margin: Margins.only(bottom: 12)),
                            "ul": Style(
                              margin: Margins.only(left: 20, bottom: 12),
                            ),
                            "li": Style(color: Colors.white),
                            "strong": Style(fontWeight: FontWeight.bold),
                          },
                        ),
                      ),
                      SizedBox(width: 180),
                    ],
                  ),
                  const SizedBox(height: 50),
                  customBlueAppBarButton(
                    onTap: () {
                      mainProductController.downloadPdfWeb(
                        AppString().productListPdfUrl,
                        pdfName: "All Products Line Up Catalogue.pdf",
                      );
                    },
                    title: 'Request Catalogue',
                  ),
                ],
              ),
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
      required url,
      String? pdfName,
    }) {
      return InkWell(
        onTap: () {
          mainProductController.downloadPdfWeb(
            url,
            pdfName: pdfName ?? "file.pdf",
          );
        },
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
            final data = mainProductController.mainProductModel?[index];

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1200),
                  child: Container(
                    padding: const EdgeInsets.all(40),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.black12, width: 1),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 24,
                          offset: const Offset(0, 8),
                        ),
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(
                          data?.imageUrl ?? '',
                          width: 300,
                          height: 300,
                        ),
                        const SizedBox(width: 80),
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
                              learnMoreButton(
                                url: data?.pdfData ?? '',
                                pdfName: '${data?.productName}.pdf',
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
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
                        learnMoreButton(
                          url: data?.pdfData ?? '',
                          pdfName: data?.productName ?? '',
                        ),
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
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          productIntroductionContent(),
          Center(child: mainProductContent()),
        ],
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
