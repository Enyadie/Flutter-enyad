import 'package:enyad_store_3/common/widgets/loaders/animation_loader.dart';
import 'package:enyad_store_3/features/shop/controller/product/order_controller.dart';
import 'package:enyad_store_3/navigation_menu.dart';
import 'package:enyad_store_3/utils/constants/colors.dart';
import 'package:enyad_store_3/utils/constants/image_strings.dart';
import 'package:enyad_store_3/utils/constants/sizes.dart';
import 'package:enyad_store_3/utils/helper/cloud_helper_function.dart';
import 'package:enyad_store_3/utils/helper/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../common/widgets/custom_shapes/containers/circular_container.dart';

class SOrderListItems extends StatelessWidget {
  const SOrderListItems({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrderController());
    final dark = SHelperFunction.isDarkMode(context);
    return FutureBuilder(
        future: controller.getUsersOrder(),
        builder: (context, snapshot) {
          final emptyWidget = SAnimationLoaderWidget(
            text: 'Whoops! No orders as yet',
            animation: SImages.emptyCart,
            showAction: true,
            actionText: 'Add products',
            onActionPressed: () => Get.offAll(() => const NavigationMenu()),
          );

          final response = SCloudHelperFunction.checkMultipleRecordState(
              snapshot: snapshot, nothingFound: emptyWidget);

          if (response != null) return response;

          final orders = snapshot.data!;

          return ListView.separated(
            shrinkWrap: true,
            itemCount: orders.length,
            separatorBuilder: (_, __) => const SizedBox(
              height: SSize.spaceBtwItems,
            ),
            itemBuilder: (_, index) {
              final order = orders[index];
              return SRoundedContainer(
                padding: const EdgeInsets.all(SSize.md),
                borderColor: dark ? SColors.lightGrey : SColors.grey,
                showBorder: true,
                radius: SSize.borderRadiusLg * 3,
                backgroundColor: dark ? SColors.darkerPurple : SColors.purple,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ///---row 1st---
                    Row(
                      ///---icon---
                      children: [
                        const Icon(Iconsax.car),
                        const SizedBox(width: SSize.spaceBtwItems / 2),

                        ///---Status and date---
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(order.orderStatusText,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .apply(
                                          color: SColors.primary,
                                          fontWeightDelta: 2)),
                              Text(order.formattedOrderDate,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall),
                            ],
                          ),
                        ),
                        IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Iconsax.arrow_right_34,
                              size: SSize.iconSm,
                              color:
                                  dark ? SColors.lightGrey : SColors.darkGrey,
                            ))
                      ],
                    ),
                    const SizedBox(height: SSize.spaceBtwItems),

                    ///---row 2nd---

                    ///---icon---
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              const Icon(Iconsax.tag),
                              const SizedBox(width: SSize.spaceBtwItems / 2),

                              ///---Order---
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text('Order',
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium),
                                    Text(order.id,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        ///---row 3rd---
                        Expanded(
                          child: Row(
                            children: [
                              const Icon(Iconsax.calendar),
                              const SizedBox(width: SSize.spaceBtwItems / 2),

                              ///---date shipping---
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text('Shipping Date',
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium),
                                    Text(order.formattedDeliveryDate,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        });
  }
}
