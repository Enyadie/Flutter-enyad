import 'package:enyad_store_3/common/widgets/image/circular_image.dart';
import 'package:enyad_store_3/common/widgets/texts/brand_title_with_verified_icon.dart';
import 'package:enyad_store_3/common/widgets/texts/product_title_text.dart';
import 'package:enyad_store_3/common/widgets/texts/productpricetext.dart';
import 'package:enyad_store_3/features/shop/models/product_model.dart';
import 'package:enyad_store_3/utils/constants/enums.dart';
import 'package:flutter/material.dart';

import '../../../../../common/widgets/custom_shapes/containers/circular_container.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helper/helper_function.dart';
import '../../../controller/product/productcontroller.dart';

class SProductMetaData extends StatelessWidget {
  const SProductMetaData({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final dark = SHelperFunction.isDarkMode(context);
    final controller = ProductController.instance;
    final salePercentage =
        controller.calculateSalePercentage(product.price, product.salePrice);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            ///---saletag---
            SRoundedContainer(
              radius: SSize.sm,
              backgroundColor: Colors.yellow.withOpacity(1),
              padding: const EdgeInsets.symmetric(
                  horizontal: SSize.sm, vertical: SSize.xs),
              child: Text('$salePercentage%',
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge!
                      .apply(color: SColors.black)),
            ),
            const SizedBox(width: SSize.spaceBtwItems),

            ///---price---
            if (product.productType == ProductType.single.toString() &&
                product.salePrice > 0)
              Text('\$${product.price}',
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .apply(decoration: TextDecoration.lineThrough)),
            if (product.productType == ProductType.single.toString() &&
                product.salePrice > 0)
              const SizedBox(width: SSize.spaceBtwItems),

            SProductPriceText(
                price: controller.getProductPrice(product), isLarge: true),
          ],
        ),

        ///---title---
        const SizedBox(height: SSize.spaceBtwItems / 3),
        SProductTitleText(
          title: product.title,
          smallSize: true,
        ),
        const SizedBox(height: SSize.spaceBtwItems / 3),

        ///---stack status---
        Row(
          children: [
            const SProductTitleText(title: 'Status', smallSize: true),
            const SizedBox(width: SSize.spaceBtwItems / 1.5),
            Text(controller.getStockStatus(product.stock),
                style: Theme.of(context).textTheme.titleMedium),
          ],
        ),

        ///---brand---
        const SizedBox(height: SSize.spaceBtwItems / 1.5),
        Row(
          children: [
            SCircularImage(
              // isNetworkImage: true,
              width: 90,
              height: 50,
              fit: BoxFit.fill,
              image: product.brand != null ? product.brand!.image : '',
              overlayColor: dark ? SColors.white : SColors.black,
            ),
            const SizedBox(width: SSize.spaceBtwItems / 1.5),
            SBrandTitleWithVerifiedicon(
                title: product.brand != null ? product.brand!.name : '',
                brandTextSize: TextSizes.large),
          ],
        ),
        if (product.productType != ProductType.variable.toString())
          const SizedBox(height: SSize.spaceBtwItems),
      ],
    );
  }
}
