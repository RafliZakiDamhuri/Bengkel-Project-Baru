import 'package:flutter/material.dart';
import 'package:project/global_widget/app_asset_image.dart';
import 'package:project/theme/theme.dart';

class ProductFeatureData {
  final String title;
  final String description;
  final String label;

  const ProductFeatureData({
    required this.title,
    required this.description,
    required this.label,
  });
}

class ProductSectionHeading extends StatelessWidget {
  final String text;

  const ProductSectionHeading({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          text,
          textAlign: TextAlign.center,
          style: blackTextStyle.copyWith(
            fontSize: 28,
            fontWeight: FontWeight.w900,
          ),
        ),
      ],
    );
  }
}

class ProductPlaceholderImage extends StatelessWidget {
  final double? width;
  final double height;
  final String label;
  final bool showBorder;

  const ProductPlaceholderImage({
    super.key,
    this.width,
    required this.height,
    this.label = 'Image Placeholder',
    this.showBorder = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.infinity,
      height: height,
      decoration: BoxDecoration(
        color: const Color(0xFFE8ECF2),
        border: showBorder ? Border.all(color: const Color(0xFFC9D2DE)) : null,
        borderRadius: showBorder ? BorderRadius.circular(8) : null,
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.image_outlined,
              size: 36,
              color: Color(0xFF9AA7B8),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                label,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xFF7D8A9B),
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductShowcaseCard extends StatelessWidget {
  final double width;
  final double imageHeight;
  final String label;
  final String caption;

  const ProductShowcaseCard({
    super.key,
    required this.width,
    required this.imageHeight,
    required this.label,
    required this.caption,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFD9DEE7)),
        borderRadius: BorderRadius.circular(10),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          ProductPlaceholderImage(
            width: width,
            height: imageHeight,
            label: label,
            showBorder: false,
          ),
          Container(
            width: double.infinity,
            color: const Color(0xFFF1F4F8),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Text(
              caption,
              textAlign: TextAlign.center,
              style: blackTextStyle.copyWith(
                fontSize: 14,
                fontWeight: semiBold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProductFeatureCard extends StatelessWidget {
  final String title;
  final String description;
  final String label;
  final double imageHeight;
  final String? imageAssets;

  const ProductFeatureCard({
    super.key,
    required this.title,
    required this.description,
    required this.label,
    required this.imageHeight,
    this.imageAssets,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFD9DEE7)),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          (imageAssets != null && imageAssets!.isNotEmpty)
              ? AppAssetImage(
                  imageAssets!,
                  width: double.infinity,
                  height: imageHeight,
                  fit: BoxFit.cover,
                )
              : ProductPlaceholderImage(
                  width: double.infinity,
                  height: imageHeight,
                  label: label,
                  showBorder: false,
                ),
          Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: blackTextStyle.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  description,
                  textAlign: TextAlign.center,
                  style: blackTextStyle.copyWith(fontSize: 14, height: 1.6),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProductLabeledCard extends StatelessWidget {
  final String title;
  final String? description;
  final String? imageAssets;

  const ProductLabeledCard({
    super.key,
    required this.title,
    this.description,
    this.imageAssets,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFD9DEE7)),
        borderRadius: BorderRadius.circular(10),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 0.86,
            child: (imageAssets != null && imageAssets!.isNotEmpty)
                ? AppAssetImage(imageAssets!, fit: BoxFit.cover)
                : ProductPlaceholderImage(
                    width: double.infinity,
                    height: double.infinity,
                    label: title,
                    showBorder: false,
                  ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 14, 14, 16),
            child: Column(
              children: [
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: blackTextStyle.copyWith(
                    fontSize: 14,
                    fontWeight: bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProductApplicationCard extends StatelessWidget {
  final String title;
  final double imageHeight;
  final String? imageAssets;

  const ProductApplicationCard({
    super.key,
    required this.title,
    required this.imageHeight,
    this.imageAssets,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        (imageAssets != null && imageAssets!.isNotEmpty)
            ? ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: AppAssetImage(
                  imageAssets!,
                  width: double.infinity,
                  height: imageHeight,
                  fit: BoxFit.cover,
                ),
              )
            : ProductPlaceholderImage(
                width: double.infinity,
                height: imageHeight,
                label: '$title Image',
              ),
        const SizedBox(height: 12),
        Text(
          title,
          textAlign: TextAlign.center,
          style: blackTextStyle.copyWith(fontSize: 14, fontWeight: semiBold),
        ),
      ],
    );
  }
}
