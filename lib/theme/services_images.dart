import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/route_manager.dart';
import 'package:get/utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/controller/globalController.dart';
import 'package:project/global%20widget/customButton.dart';
import 'package:project/theme/string.dart';
import 'package:project/theme/theme.dart';

class ServicesImages extends StatelessWidget {
  final String imag;
  final String title;
  final String htmlData;
  const ServicesImages({
    super.key,
    required this.imag,
    required this.title,
    required this.htmlData,
  });

  @override
  Widget build(BuildContext context) {
    var globalController = Get.find<GlobalController>();

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 140),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            width: 523,
            height: 608,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(imag),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Text(
                      title,
                      style: blackTextStyle.copyWith(
                        fontSize: 32,
                        fontWeight: bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 25),
                  Html(
                    data: htmlData,
                    style: {
                      "body": Style(
                        color: Colors.black87,
                        fontSize: FontSize(16),
                        fontWeight: FontWeight.w400,
                        lineHeight: const LineHeight(1.45),
                        margin: Margins.zero,
                        padding: HtmlPaddings.zero,
                        fontFamily: GoogleFonts.inter().fontFamily,
                      ),

                      "p": Style(margin: Margins.only(bottom: 14)),

                      "ul": Style(
                        margin: Margins.only(left: 24, bottom: 14),
                        padding: HtmlPaddings.zero,
                      ),

                      "li": Style(
                        color: Colors.black87,
                        margin: Margins.only(bottom: 10),
                        lineHeight: const LineHeight(1.4),
                      ),

                      "strong": Style(
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    },
                  ),

                  GestureDetector(
                    onTap: () {
                      globalController.openWhatsApp(
                        AppString().indocoolWhatsappNumber,
                        'Halo Saya Ingin Booking Service Schedule',
                      );
                    },
                    child: Container(
                      width: 200,
                      height: 40,
                      margin: EdgeInsets.only(top: 56),
                      decoration: BoxDecoration(
                        color: kBlueColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          'Book Service Schedule',
                          style: whiteTextStyle.copyWith(
                            fontSize: 14,
                            fontWeight: bold,
                          ),
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
    );
  }
}
