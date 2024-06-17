import 'package:enyad_store_3/common/widgets/icons/circular_icon.dart';
import 'package:enyad_store_3/features/shop/controller/product/cart_item_controller.dart';
import 'package:enyad_store_3/utils/constants/colors.dart';
import 'package:enyad_store_3/utils/constants/sizes.dart';
import 'package:enyad_store_3/utils/helper/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:iconsax/iconsax.dart';

import '../../../models/product_model.dart';

class SBottomAddToCart extends StatelessWidget {
  const SBottomAddToCart({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller = CartItemController();
    controller.updateAddedProducts(product);
    final dark = SHelperFunction.isDarkMode(context);

    return Obx(
      () => Container(
        padding: const EdgeInsets.symmetric(
            horizontal: SSize.defautSpace, vertical: SSize.defautSpace / 2),
        decoration: BoxDecoration(
          color: dark ? SColors.darkerGrey : SColors.grey,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(SSize.cardRadiusLg),
            topRight: Radius.circular(SSize.cardRadiusLg),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SCircularIcon(
                    icon: Iconsax.minus,
                    backgroundColor: SColors.red,
                    width: 40,
                    height: 40,
                    color: SColors.white,
                    onPressed: () {
                      controller.productQuantityInCart.value < 1
                          ? null
                          : controller.productQuantityInCart.value -= 1;
                    }),
                const SizedBox(width: SSize.spaceBtwItems),
                Text(controller.productQuantityInCart.value.toString(),
                    style: Theme.of(context).textTheme.titleSmall),
                const SizedBox(width: SSize.spaceBtwItems),
                SCircularIcon(
                    icon: Iconsax.add,
                    backgroundColor: Colors.green,
                    width: 40,
                    height: 40,
                    color: SColors.white,
                    onPressed: () {
                      controller.productQuantityInCart.value += 1;
                    }),
              ],
            ),
            ElevatedButton(
              onPressed: controller.productQuantityInCart.value < 1
                  ? null
                  : () => controller.addToCart(product),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(SSize.md),
                backgroundColor: SColors.primary,
                side: const BorderSide(color: SColors.darkerPurple),
              ),
              child: const Text(
                'Add to Cart',
                style: TextStyle(color: SColors.lightGrey),
              ),
            )
          ],
        ),
      ),
    );
  }
}
