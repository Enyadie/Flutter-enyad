import 'package:enyad_store_3/common/widgets/texts/product_title_text.dart';
import 'package:enyad_store_3/common/widgets/texts/productpricetext.dart';
import 'package:enyad_store_3/common/widgets/texts/section_heading.dart';
import 'package:enyad_store_3/features/shop/controller/product/variation_controller.dart';
import 'package:enyad_store_3/utils/constants/colors.dart';
import 'package:enyad_store_3/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/widgets/chips/choice_chip.dart';
import '../../../../../common/widgets/custom_shapes/containers/circular_container.dart';
import '../../../../../utils/constants/enums.dart';
import '../../../../../utils/helper/helper_function.dart';
import '../../../models/product_model.dart';

class SProductAttributes extends StatelessWidget {
  const SProductAttributes({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final dark = SHelperFunction.isDarkMode(context);
    final controller = Get.put(VariationController());

    return Obx(
      () => Column(
        children: [
          if (product.productType == ProductType.variable.toString())
            const SizedBox(height: SSize.sm),

          ///display variation price and stock
          if (controller.selectedVariation.value.id.isNotEmpty)

            ///---validate---
            SRoundedContainer(
              padding: const EdgeInsets.symmetric(
                  horizontal: SSize.md, vertical: SSize.sm),
              backgroundColor: dark ? SColors.darkerGrey : SColors.grey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      ///stock status
                      const SSectionHeading(
                          title: 'Variations', showActionButton: false),
                      const SizedBox(width: SSize.spaceBtwItems),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              if (controller.selectedVariation.value.salePrice >
                                  0)
                                const Text(
                                  'Price',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: SColors.primary),
                                ),
                              const SizedBox(width: SSize.spaceBtwItems / 2),
                              Text(
                                ///Actual price
                                '\$${controller.selectedVariation.value.price}',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .apply(
                                        decorationColor: SColors.red,
                                        decoration: TextDecoration.lineThrough,
                                        color: dark
                                            ? SColors.white
                                            : SColors.black),
                              ),
                            ],
                          ),

                          ///sale price
                          Row(
                            children: [
                              const Text(
                                'Sale Price',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: SColors.red),
                              ),
                              const SizedBox(width: SSize.spaceBtwItems / 2),
                              SProductPriceText(
                                  price: controller.getVariationPrice()),
                            ],
                          ),

                          ///stock
                          Row(
                            children: [
                              const SProductTitleText(
                                title: 'Stock',
                                smallSize: true,
                              ),
                              const SizedBox(width: SSize.spaceBtwItems / 2),
                              Text(
                                controller.variationStockStatus.value,
                                style: Theme.of(context).textTheme.titleMedium,
                              )
                            ],
                          ),
                          SProductTitleText(
                            title: controller
                                    .selectedVariation.value.description ??
                                '',
                            smallSize: true,
                            maxLine: 4,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          const SizedBox(height: SSize.spaceBtwItems),

          ///---attributes---
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...product.productAttributes!
                  .map((attribute) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SSectionHeading(
                              title: attribute.name ?? '',
                              showActionButton: false),
                          const SizedBox(height: SSize.spaceBtwItems / 2),
                          Obx(
                            () => Wrap(
                              spacing: 10,
                              children: attribute.values!.map((attributeValue) {
                                final isSelected = controller
                                        .selectedAttributes[attribute.name] ==
                                    attributeValue;
                                final available = controller
                                    .getAttributesAvailabilityInVariation(
                                        product.productVariations!,
                                        attribute.name!)
                                    .contains(attributeValue);

                                return SChoiceChip(
                                    selected: isSelected,
                                    text: attributeValue,
                                    onSelected: available
                                        ? (isSelected) {
                                            if (isSelected && available) {
                                              controller.onAttributesSelected(
                                                  product,
                                                  attribute.name ?? '',
                                                  attributeValue);
                                            }
                                          }
                                        : null);
                              }).toList(),
                            ),
                          ),
                        ],
                      ))
                  .toList(),
            ],
          ),
        ],
      ),
    );
  }
}
