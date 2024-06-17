import 'package:enyad_store_3/common/widgets/image/circular_image.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helper/helper_function.dart';

class SVerticalImageText extends StatelessWidget {
  const SVerticalImageText({
    super.key,
    required this.image,
    required this.title,
    this.textColor = SColors.white,
    this.backgroundColor,
    this.onTap,
    this.isNetworkImage = true,
  });

  final String image, title;
  final Color textColor;
  final Color? backgroundColor;
  final bool isNetworkImage;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final dark = SHelperFunction.isDarkMode(context);
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(right: SSize.spaceBtwItems),
        child: Column(
          children: [
            ///circular icon
            Column(
              children: [
                SCircularImage(
                  image: image,
                  fit: BoxFit.fitWidth,
                  padding: SSize.sm * 1.2,
                  isNetworkImage: isNetworkImage,
                  overlayColor: dark ? SColors.primary : SColors.purple,
                ),
                // Import cached_network_image into yamal
                ///text below icons
                const SizedBox(height: SSize.spaceBtwItems / 2),
                SizedBox(
                  // width: 75,
                  child: Text(
                    title,
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium!
                        .apply(color: textColor),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
