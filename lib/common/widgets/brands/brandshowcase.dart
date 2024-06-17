import 'package:enyad_store_3/common/widgets/image/rounded_image.dart';
import 'package:enyad_store_3/features/shop/models/brand_model.dart';
import 'package:enyad_store_3/features/shop/screens/brands/brand_products.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helper/helper_function.dart';
import '../custom_shapes/containers/circular_container.dart';
import 'brand_card.dart';

class SBrandShowCase extends StatelessWidget {
  const SBrandShowCase({
    super.key,
    required this.images,
    required this.brand,
  });

  final List<String> images;
  final BrandModel brand;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.to(() => SBrandProducts(brand: brand)),
      child: SRoundedContainer(
        showBorder: true,
        borderColor: SColors.darkerGrey,
        backgroundColor: Colors.transparent,
        padding: const EdgeInsets.all(SSize.md),
        margin: const EdgeInsets.only(bottom: SSize.spaceBtwItems),
        child: Column(
          children: [
            ///brand with product count
            SBrandCard(
              showBorder: false,
              brand: brand,
            ),

            /// if need add const SizedBox(height: SSize.spaceBtwItems),

            ///brand with top 3 products
            Row(
              children: images
                  .map((image) => brandTopProductsImageWidget(image, context))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget brandTopProductsImageWidget(String image, context) {
    final dark = SHelperFunction.isDarkMode(context);
    return Expanded(
      child: SRoundedContainer(
        height: 90,

        ///was 80
        showBorder: true,
        borderColor: dark ? SColors.darkerGrey : SColors.grey,
        // padding: const EdgeInsets.all(SSize.sm / 1.5),
        margin: const EdgeInsets.only(right: SSize.sm),
        backgroundColor: dark ? SColors.darkerGrey : SColors.light,
        child: SRoundedImage(
          isNetworkImage: true,
          imageUrl: image,
          fit: BoxFit.fill,
          applyImageRadius: true,
        ),
      ),
    );
  }
}
