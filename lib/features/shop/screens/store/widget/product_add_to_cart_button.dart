import 'package:enyad_store_3/features/shop/controller/product/cart_item_controller.dart';
import 'package:enyad_store_3/features/shop/models/product_model.dart';
import 'package:enyad_store_3/features/shop/screens/product_details/product_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/enums.dart';
import '../../../../../utils/constants/sizes.dart';

class ProductCardAddToCartButton extends StatelessWidget {
  const ProductCardAddToCartButton({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final cartController = CartItemController.instance;
    return InkWell(
      onTap: () {
        if (product.productType == ProductType.single.toString()) {
          final cartItem = cartController.convertToCartItem(product, 1);
          cartController.addOneToCart(cartItem);
        } else {
          Get.to(() => ProductDetailScreen(product: product));
        }
      },
      child: Obx(() {
        final productQuantityInCart =
            cartController.getProductQuantityInCart(product.id);
        return Container(
          decoration: BoxDecoration(
            color:
                productQuantityInCart > 0 ? SColors.secondary : SColors.primary,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(SSize.cardRadiusMd),
              bottomRight: Radius.circular(SSize.productImageRadius),
            ),
          ),
          child: SizedBox(
              width: SSize.iconlg,
              height: SSize.iconlg * 2,
              child: Center(
                  child: productQuantityInCart > 0
                      ? Text(productQuantityInCart.toString(),
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .apply(color: Colors.white))
                      : const Icon(
                          Iconsax.add,
                          color: SColors.white,
                        ))),
        );
      }),
    );
  }
}
