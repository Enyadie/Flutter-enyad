import 'package:enyad_store_3/common/widgets/appbar/appBar.dart';
import 'package:enyad_store_3/common/widgets/loaders/animation_loader.dart';
import 'package:enyad_store_3/features/shop/controller/product/cart_item_controller.dart';
import 'package:enyad_store_3/features/shop/screens/cart/widgets/cart_items.dart';
import 'package:enyad_store_3/navigation_menu.dart';
import 'package:enyad_store_3/utils/constants/colors.dart';
import 'package:enyad_store_3/utils/constants/image_strings.dart';
import 'package:enyad_store_3/utils/constants/sizes.dart';
import 'package:enyad_store_3/utils/helper/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../checkout/checkout.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CartItemController.instance;
    final dark = SHelperFunction.isDarkMode(context);
    return Obx(
      () => Scaffold(
        backgroundColor: dark ? SColors.darkerPurple : SColors.purple,
        appBar: SAppBar(
          title: Text('Cart',
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .apply(color: dark ? SColors.grey : SColors.lightGrey)),
          showBackButton: true,
          showBackground: false,
          buttonBackgroundColor: true,
        ),
        body: Obx(() {
          final emptyWidget = SAnimationLoaderWidget(
            text: 'EMPTY CART',
            animation: SImages.emptyCart,
            showAction: true,
            actionText: 'Try adding some products.',
            onActionPressed: () => Get.off(() => const NavigationMenu()),
          );
          return controller.cartItems.isEmpty
              ? emptyWidget
              : const SingleChildScrollView(
                  child: Padding(
                      padding: EdgeInsets.all(SSize.defautSpace),

                      ///---items in cart---
                      child: SCartItems()),
                );
        }),
        bottomNavigationBar: (controller.cartItems.isEmpty)
            ? const SizedBox()
            : Padding(
                padding: const EdgeInsets.all(SSize.defautSpace / 1.5),
                child: ElevatedButton(
                  onPressed: () => Get.to(() => const CheckoutScreen()),
                  child: Obx(() =>
                      Text('Checkout  \$${controller.totalCartPrice.value}')),
                ),
              ),
      ),
    );
  }
}
