import 'package:enyad_store_3/features/shop/controller/product/cart_item_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../../../../common/widgets/products/cart/add_remove_button.dart';
import '../../../../../common/widgets/products/cart/cart_item.dart';
import '../../../../../common/widgets/texts/productpricetext.dart';
import '../../../../../utils/constants/sizes.dart';

class SCartItems extends StatelessWidget {
  const SCartItems({super.key, this.showAddRemoveButtons = true});

  final bool showAddRemoveButtons;

  @override
  Widget build(BuildContext context) {
    final cartController = CartItemController.instance;

    return Obx(
      () => ListView.separated(
        shrinkWrap: true,
        itemCount: cartController.cartItems.length,
        itemBuilder: (_, index) => Obx(() {
          final item = cartController.cartItems[index];
          return Column(
            children: [
              ///---item---
              SCartItem(
                cartItem: item,
              ),
              if (showAddRemoveButtons)
                const SizedBox(height: SSize.spaceBtwItems),

              ///---add and remove button---
              if (showAddRemoveButtons)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // flutter config
                    Row(
                      children: [
                        const SizedBox(width: 75),
                        SQuantityAddAndRemoveButton(
                          quantity: item.quantity,
                          add: () => cartController.addOneToCart(item),
                          remove: () => cartController.removeOneFromCart(item),
                        ),
                      ],
                    ),
                    SProductPriceText(
                        price: (item.price * item.quantity).toStringAsFixed(2))
                  ],
                ),
            ],
          );
        }),
        separatorBuilder: (_, __) => const SizedBox(
          height: SSize.spaceBtwSections,
        ),
      ),
    );
  }
}
