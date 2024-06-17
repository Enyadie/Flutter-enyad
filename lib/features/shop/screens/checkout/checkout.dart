import 'package:enyad_store_3/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:enyad_store_3/features/shop/controller/product/cart_item_controller.dart';
import 'package:enyad_store_3/features/shop/controller/product/order_controller.dart';
import 'package:enyad_store_3/features/shop/screens/cart/widgets/cart_items.dart';
import 'package:enyad_store_3/features/shop/screens/checkout/widgets/billing_address_section.dart';
import 'package:enyad_store_3/features/shop/screens/checkout/widgets/billing_amount_section.dart';
import 'package:enyad_store_3/features/shop/screens/checkout/widgets/billing_payment_section.dart';
import 'package:enyad_store_3/utils/constants/sizes.dart';
import 'package:enyad_store_3/utils/helper/pricing_calculator.dart';
import 'package:enyad_store_3/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/appbar/appBar.dart';
import '../../../../common/widgets/products/cart/coupon_widget.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/helper/helper_function.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartController = CartItemController.instance;
    final subTotal = cartController.totalCartPrice.value;
    final orderController = Get.put(OrderController());
    final totalAmount = SPricingCalculator.calculateTotalPrice(subTotal, 'JMD');
    final dark = SHelperFunction.isDarkMode(context);
    return Scaffold(
      backgroundColor: dark ? SColors.darkerPurple : SColors.purple,
      appBar: SAppBar(
        showBackground: false,
        title: Text('Checkout',
            style: Theme.of(context)
                .textTheme
                .headlineSmall!
                .apply(color: dark ? SColors.grey : SColors.lightGrey)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(SSize.defautSpace),
          child: Column(
            children: [
              ///---Items---
              const SCartItems(showAddRemoveButtons: false),
              const SizedBox(height: SSize.spaceBtwSections),

              ///---coupons---
              const SCouponCode(),
              const SizedBox(height: SSize.spaceBtwSections),

              ///---billings---
              SRoundedContainer(
                showBorder: true,
                padding: const EdgeInsets.all(SSize.md),
                backgroundColor: dark ? SColors.darkGrey : SColors.grey,
                child: Column(
                  children: [
                    ///---pricing--
                    const SBillingAmountSection(),
                    const SizedBox(height: SSize.spaceBtwItems),

                    Divider(color: dark ? SColors.white : SColors.black),
                    const SizedBox(height: SSize.spaceBtwItems),

                    ///---payment method---
                    const SBillingPaymentSection(),
                    const SizedBox(height: SSize.spaceBtwItems),

                    ///---address
                    const SBillingAddressSection(),
                    const SizedBox(height: SSize.spaceBtwItems),
                  ],
                ),
              )
            ],
          ),
        ),
      ),

      ///checkout
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(SSize.defautSpace / 1.5),
        child: ElevatedButton(
          onPressed: subTotal > 0
              ? () => orderController.processOrder(totalAmount)
              : () => SLoaders.warningSnackBar(
                  title: 'Empty Cart',
                  message: "UNABLE TO PROCESS!\n Add item to Empty Cart."),
          child: Text('Checkout  \$$totalAmount'),
        ),
      ),
    );
  }
}
