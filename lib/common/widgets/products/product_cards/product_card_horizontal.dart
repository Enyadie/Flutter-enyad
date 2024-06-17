import 'package:enyad_store_3/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:enyad_store_3/common/widgets/image/rounded_image.dart';
import 'package:enyad_store_3/common/widgets/texts/brand_title_with_verified_icon.dart';
import 'package:enyad_store_3/common/widgets/texts/product_title_text.dart';
import 'package:enyad_store_3/common/widgets/texts/productpricetext.dart';
import 'package:enyad_store_3/features/shop/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../features/shop/controller/product/productcontroller.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/enums.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helper/helper_function.dart';
import '../favourite_icon/favourite_icon.dart';

class SProductCardHorizontal extends StatelessWidget {
  const SProductCardHorizontal({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller = ProductController.instance;
    final salePercentage =
        controller.calculateSalePercentage(product.price, product.salePrice);
    final dark = SHelperFunction.isDarkMode(context);
    return SRoundedContainer(
      width: 360,

      ///double.infinite
      // padding: const EdgeInsets.all(1),
      showBorder: true,
      radius: SSize.productImageRadius,
      backgroundColor: dark ? SColors.darkerPurple : SColors.purple,

      // boxShadow: [SShadowStyle.horizontalProductShadow], when using container

      child: Row(
        children: [
          ///---thumbnail---
          SRoundedContainer(
            height: 160,
            padding: const EdgeInsets.all(2),
            backgroundColor: dark ? SColors.dark : SColors.light,
            child: Stack(
              children: [
                SizedBox(
                  width: 160,
                  height: 160,
                  child: SRoundedImage(
                    isNetworkImage: true,
                    fit: BoxFit.fill,
                    imageUrl: product.thumbnail,
                    applyImageRadius: true,
                  ),
                ),

                ///Sale tag
                Positioned(
                  top: 0,
                  child: SRoundedContainer(
                    radius: SSize.sm,
                    backgroundColor: SColors.purple.withOpacity(1),
                    padding: const EdgeInsets.symmetric(
                        horizontal: SSize.sm, vertical: SSize.xs * 1.2),
                    child: Text('$salePercentage%',
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge!
                            .apply(color: SColors.white)),
                  ),
                ),

                ///heart icon
                Positioned(
                  top: -10,
                  right: -9,
                  child: SFavouriteIcon(
                    productId: product.id,
                  ),
                ),
              ],
            ),
          ),

          ///---details---
          SizedBox(
            width: 180,
            child: Padding(
              padding: const EdgeInsets.only(
                  top: SSize.sm, left: SSize.sm, bottom: SSize.sm / 4.5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SProductTitleText(title: product.title, smallSize: true),
                      const SizedBox(height: SSize.spaceBtwItems / 2),
                      SBrandTitleWithVerifiedicon(title: product.brand!.name)
                    ],
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ///Cost
                      Expanded(
                        flex: 4,
                        child: Column(
                          children: [
                            if (product.productType ==
                                    ProductType.single.toString() &&
                                product.salePrice > 0)
                              Padding(
                                padding: const EdgeInsets.only(left: SSize.sm),
                                child: Text(
                                  '\$${product.price.toString()}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium!
                                      .apply(
                                          decoration:
                                              TextDecoration.lineThrough),
                                ),
                              ),
                            Padding(
                              padding: const EdgeInsets.only(left: SSize.sm),
                              child: SProductPriceText(
                                price: controller.getProductPrice(product),
                              ),
                            ),
                          ],
                        ),
                      ),

                      ///add to cart
                      Expanded(
                        flex: 1,
                        child: Container(
                          decoration: const BoxDecoration(
                            color: SColors.primary,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(SSize.cardRadiusMd),
                              bottomRight:
                                  Radius.circular(SSize.productImageRadius),
                            ),
                          ),
                          child: const SizedBox(
                              width: SSize.iconlg,
                              height: SSize.iconlg,
                              child: Center(
                                  child: Icon(
                                Iconsax.add,
                                color: SColors.white,
                              ))),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
