import 'package:cached_network_image/cached_network_image.dart';
import 'package:enyad_store_3/common/shimmers/shimmer.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helper/helper_function.dart';

class SCircularImage extends StatelessWidget {
  const SCircularImage({
    super.key,
    this.fit = BoxFit.cover,
    required this.image,
    this.isNetworkImage = false,
    this.overlayColor,
    this.backgroundColor,
    this.width = 56,
    this.height = 56,
    this.padding = SSize.sm,
  });

  final BoxFit? fit;
  final String image;
  final bool isNetworkImage;
  final Color? overlayColor, backgroundColor;
  final double width, height, padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: const EdgeInsets.all(SSize.sm),
      decoration: BoxDecoration(
        color:
            SHelperFunction.isDarkMode(context) ? SColors.black : SColors.white,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Center(
        child: ClipOval(
          child: isNetworkImage
              ? CachedNetworkImage(
                  imageUrl: image,
                  fit: fit,
                  width: width,
                  height: height,
                  color: overlayColor,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      const SShimmerEffect(
                          width: 100, height: 100, radius: 100),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                )
              : Image.asset(
                  image,
                  fit: fit,
                  width: width,
                  height: height,
                  color: overlayColor,
                ),
        ),
      ),
    );
  }
}
