import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:project/CMS/controller/cms_controller.dart';
import 'package:project/global%20widget/customButton.dart';
import 'package:project/theme/theme.dart';

Widget buildAddDataLayout({
  required String title,
  required List<Widget> leftFields,
  required List<Widget> rightFields,
  required VoidCallback onSubmit,
  required CmsController controller,
}) {
  return Container(
    margin: const EdgeInsets.only(left: 40, top: 80, bottom: 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(title, style: blackTextStyle.copyWith(fontSize: 30)),

        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(children: leftFields),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...rightFields,

                const SizedBox(height: 20),
                Row(
                  children: [
                    controller.productModelSingle?.drawing2d != null
                        ? Column(
                            children: [
                              Text(
                                'Gambar Sekarang',
                                style: blackTextStyle.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: CachedNetworkImage(
                                  width: 300,
                                  height: 200,
                                  imageUrl:
                                      controller
                                          .productModelSingle
                                          ?.drawing2d ??
                                      '',
                                  fit: BoxFit.contain,
                                  placeholder: (_, __) => const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                  errorWidget: (_, __, ___) => const Icon(
                                    Icons.broken_image,
                                    size: 55,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Container(),
                    SizedBox(width: 100),
                    Column(
                      children: [
                        customBlueAppBarButton(
                          onTap: () {
                            controller.pickAndUploadImage();
                          },
                          title: 'Pilih Gambar Baru',
                        ),
                        SizedBox(height: 20),
                        controller.bytes != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.memory(
                                  controller.bytes!,
                                  width: 300,
                                  height: 200,
                                  fit: BoxFit.contain,
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20),

                customBlueAppBarButton(onTap: onSubmit, title: 'Update'),
              ],
            ),
          ],
        ),
      ],
    ),
  );
}
