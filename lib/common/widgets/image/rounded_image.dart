import 'package:cached_network_image/cached_network_image.dart';
import 'package:enyad_store_3/common/shimmers/shimmer.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants/sizes.dart';

class SRoundedImage extends StatelessWidget {
  const SRoundedImage({
    super.key,
    this.height,
    this.width,
    required this.imageUrl,
    this.applyImageRadius = true,
    this.isNetworkImage = false,
    this.border,
    this.backgroundColor,
    this.fit = BoxFit.contain,
    this.padding,
    this.onPressed,
    this.borderRadius = SSize.md,
    this.cachedImage = false,
  });

  final double? height, width;
  final String imageUrl;
  final bool cachedImage;
  final bool applyImageRadius, isNetworkImage;
  final BoxBorder? border;
  final Color? backgroundColor;
  final BoxFit? fit;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onPressed;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        padding: padding,
        decoration: BoxDecoration(
          border: border,
          color: backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: ClipRRect(
          borderRadius: applyImageRadius
              ? BorderRadius.circular(borderRadius)
              : BorderRadius.zero,
          child: isNetworkImage
              ? CachedNetworkImage(
                  fit: fit,
                  imageUrl: imageUrl,
                  progressIndicatorBuilder: (_, __, downloadProgress) =>
                      SShimmerEffect(
                          width: double.infinity, height: height ?? 220),
                  errorWidget: (context, url, error) =>
                      const SShimmerEffect(width: double.infinity, height: 220),
                )
              : Image(
                  fit: fit,
                  image: AssetImage(imageUrl) as ImageProvider,
                ),
        ),
      ),
    );
  }
}
