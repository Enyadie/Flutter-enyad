import 'package:enyad_store_3/features/shop/models/product_model.dart';
import 'package:enyad_store_3/features/shop/screens/all_products/all_products_controller.dart';
import 'package:enyad_store_3/utils/helper/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../layout/grid_layout.dart';
import '../product_cards/product_card_vertical.dart';

class SSortableProducts extends StatelessWidget {
  const SSortableProducts({
    super.key,
    required this.products,
  });

  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AllProductsController());
    final dark = SHelperFunction.isDarkMode(context);
    controller.assignProducts(products);
    return Column(
      children: [
        ///---dropdown---
        DropdownButtonFormField(
          decoration: InputDecoration(
              prefixIcon: const Icon(Iconsax.sort),
              prefixIconColor: dark ? SColors.grey : Colors.white),
          value: controller.selectedSortedOption.value,
          onChanged: (value) {
            controller.sortProducts(value!);
          },
          dropdownColor: dark ? SColors.darkerPurple : SColors.purple,
          style: TextStyle(color: dark ? SColors.grey : SColors.lightGrey),
          iconEnabledColor: dark ? SColors.grey : Colors.white,
          items: [
            'Name',
            'Higher Price',
            'Lower Price',
            'Sale',
            'Newest',
            'Popularity',
          ]
              .map((option) =>
                  DropdownMenuItem(value: option, child: Text(option)))
              .toList(),
        ),
        const SizedBox(height: SSize.spaceBtwSections),

        ///---products---
        Obx(
          () => SGridLayout(
              itemCount: controller.products.length,
              itemBuilder: (_, index) => SProductCardVertical(
                    product: controller.products[index],
                  )),
        )
      ],
    );
  }
}
