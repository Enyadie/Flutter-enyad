import 'package:enyad_store_3/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:enyad_store_3/common/widgets/image/rounded_image.dart';
import 'package:enyad_store_3/common/widgets/texts/brand_title_with_verified_icon.dart';
import 'package:enyad_store_3/features/shop/controller/product/productcontroller.dart';
import 'package:enyad_store_3/features/shop/models/product_model.dart';
import 'package:enyad_store_3/utils/constants/colors.dart';
import 'package:enyad_store_3/utils/helper/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../features/shop/screens/product_details/product_details.dart';
import '../../../../features/shop/screens/store/widget/product_add_to_cart_button.dart';
import '../../../../utils/constants/enums.dart';
import '../../../../utils/constants/sizes.dart';
import '../../texts/product_title_text.dart';
import '../../texts/productpricetext.dart';
import '../favourite_icon/favourite_icon.dart';

class SProductCardVertical extends StatelessWidget {
  const SProductCardVertical({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller = ProductController.instance;
    final salePercentage =
        controller.calculateSalePercentage(product.price, product.salePrice);
    final dark = SHelperFunction.isDarkMode(context);
    return GestureDetector(
      onTap: () => Get.to(() => ProductDetailScreen(
            product: product,
          )),
      child: SRoundedContainer(
        backgroundColor: Colors.transparent,
        showBorder: true,
        child: Column(
          children: [
            ///thumbnail
            SRoundedContainer(
              // padding: const EdgeInsets.all(SSize.sm / 2),
              showBorder: true,
              height: 150,
              width: double.infinity,

              /// width was 120
              backgroundColor: dark ? SColors.lightGrey : SColors.light,
              child: Stack(
                children: [
                  SizedBox(
                    ///can remove size box
                    width: double.infinity,
                    height: 200,

                    ///was height 220
                    child: SRoundedImage(
                      fit: BoxFit.fill,
                      imageUrl: product.thumbnail,
                      applyImageRadius: true,
                      isNetworkImage: true,
                    ),
                  ),

                  if (salePercentage != null)

                    ///Sale tag
                    Positioned(
                      top: 0,
                      child: SRoundedContainer(
                        radius: SSize.lg,
                        backgroundColor: SColors.purple.withOpacity(1),
                        padding: const EdgeInsets.symmetric(
                            horizontal: SSize.sm, vertical: SSize.xs * 1.2),
                        child: Text('$salePercentage%',
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge!
                                .apply(
                                    color: dark
                                        ? SColors.grey
                                        : SColors.lightGrey)),
                      ),
                    ),

                  ///heart icon
                  Positioned(
                      top: -10,
                      right: -8,
                      child: SFavouriteIcon(
                        productId: product.id,
                      )),
                ],
              ),
            ),
            const SizedBox(height: SSize.spaceBtwItems / 3),

            ///Details
            Padding(
              padding: const EdgeInsets.only(left: SSize.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SProductTitleText(
                      title: product.title,
                      smallSize: true,
                      textColor: dark ? SColors.grey : SColors.lightGrey),
                  const SizedBox(height: SSize.spaceBtwItems / 2),
                  SBrandTitleWithVerifiedicon(
                      title: product.brand!.name,
                      textColor: dark ? SColors.grey : SColors.lightGrey),
                ],
              ),
            ),

            // Todo: spacer needed
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ///Cost
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                                    decoration: TextDecoration.lineThrough,
                                    decorationColor: SColors.red,
                                    color: dark
                                        ? SColors.grey
                                        : SColors.lightGrey),
                          ),
                        ),
                      Padding(
                        padding: const EdgeInsets.only(left: SSize.sm),
                        child: SProductPriceText(
                          isLarge: false,
                          textColor: dark ? SColors.grey : SColors.lightGrey,
                          price: controller.getProductPrice(product),
                        ),
                      ),
                    ],
                  ),
                ),

                ///add to cart
                Expanded(
                  flex: 1,
                  child: ProductCardAddToCartButton(product: product),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
