import 'package:enyad_store_3/features/shop/models/brand_model.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/enums.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helper/helper_function.dart';
import '../custom_shapes/containers/circular_container.dart';
import '../image/circular_image.dart';
import '../texts/brand_title_with_verified_icon.dart';

class SBrandCard extends StatelessWidget {
  const SBrandCard({
    super.key,
    required this.showBorder,
    this.onTap,
    required this.brand,
  });

  final BrandModel brand;
  final bool showBorder;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final dark = SHelperFunction.isDarkMode(context);
    return GestureDetector(
      onTap: onTap,
      child: SRoundedContainer(
        padding: const EdgeInsets.all(SSize.sm),
        showBorder: showBorder,
        borderColor: SColors.primary,
        backgroundColor: Colors.transparent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /// ---- text ---
            SBrandTitleWithVerifiedicon(
              title: brand.name,
              brandTextSize: TextSizes.large,
              textColor: dark ? SColors.grey : SColors.dark,
            ),
            const SizedBox(height: SSize.spaceBtwItems / 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ///---icons ---
                Flexible(
                  child: SCircularImage(
                    width: 110,
                    padding: 0,
                    isNetworkImage: true,
                    image: brand.image,
                    backgroundColor: Colors.transparent,
                  ),
                ),
              ],
            ),
            const SizedBox(height: SSize.spaceBtwItems / 2),
            Text(
              '${brand.productCount ?? 0} Products',
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .apply(color: dark ? SColors.grey : SColors.dark),
            ),
          ],
        ),
      ),
    );
  }
}
