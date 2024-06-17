import 'package:enyad_store_3/features/shop/models/cart_item_model.dart';
import 'package:enyad_store_3/utils/helper/helper_function.dart';
import 'package:flutter/material.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../image/rounded_image.dart';
import '../../texts/brand_title_with_verified_icon.dart';
import '../../texts/product_title_text.dart';

class SCartItem extends StatelessWidget {
  const SCartItem({
    super.key,
    required this.cartItem,
  });

  final CartItemModel cartItem;

  @override
  Widget build(BuildContext context) {
    final dark = SHelperFunction.isDarkMode(context);
    return Row(
      children: [
        SRoundedImage(
          isNetworkImage: true,
          border: Border.all(
              width: 2, color: dark ? SColors.darkerGrey : SColors.darkGrey),
          imageUrl: cartItem.image ?? '',
          width: 60,
          height: 60,
          padding: const EdgeInsets.all(SSize.sm / 2.5),
          fit: BoxFit.fill,
        ),

        ///---title--
        const SizedBox(width: SSize.spaceBtwItems),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SBrandTitleWithVerifiedicon(
                title: cartItem.brandName ?? '',
                textColor: dark ? SColors.grey : SColors.lightGrey,
              ),
              Flexible(
                child: SProductTitleText(
                  textColor: dark ? SColors.grey : SColors.lightGrey,
                  title: cartItem.title,
                  maxLine: 1,
                ),
              ),

              ///--attribute---
              Text.rich(
                TextSpan(
                  children: (cartItem.selectedVariation ?? {})
                      .entries
                      .map((e) => TextSpan(
                            children: [
                              TextSpan(
                                  text: e.key,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .apply(
                                          color: dark
                                              ? SColors.grey
                                              : SColors.lightGrey)),
                              const WidgetSpan(
                                  child: SizedBox(width: SSize.sm)),
                              TextSpan(
                                  text: e.value,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .apply(
                                          color: dark
                                              ? SColors.grey
                                              : SColors.lightGrey)),
                            ],
                          ))
                      .toList(),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
