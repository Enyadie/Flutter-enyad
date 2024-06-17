import 'package:enyad_store_3/common/widgets/appbar/appBar.dart';
import 'package:enyad_store_3/features/shop/screens/product_review/widget/rating_indicator.dart';
import 'package:enyad_store_3/features/shop/screens/product_review/widget/user_review.dart';
import 'package:enyad_store_3/utils/constants/sizes.dart';
import 'package:enyad_store_3/utils/helper/helper_function.dart';
import 'package:flutter/material.dart';

import '../../../../common/widgets/products/rating/productrating.dart';
import '../../../../utils/constants/colors.dart';

class ProductReviewScreen extends StatelessWidget {
  const ProductReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = SHelperFunction.isDarkMode(context);
    return Scaffold(
      backgroundColor: dark ? SColors.darkerPurple : Colors.purple,
      appBar: const SAppBar(
        title: Text(
          'Customer Reviews & Ratings',
        ),
        showBackButton: true,
      ),

      ///---rating---
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(SSize.sm),

          ///default space it should be
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                  "Ratings and Reviews are from customers like yourself who have reviewed this item, which may have piqued your interest."),
              const SizedBox(height: SSize.spaceBtwItems),
              const SOverAllProductRating(),
              const SRatingBarIndicator(rating: 3.5),
              Text(
                "6,300",
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .apply(color: dark ? SColors.grey : SColors.lightGrey),
              ),
              const SizedBox(height: SSize.spaceBtwSections),

              ///User review
              const UserReviewCard(),
              const UserReviewCard(),
              const UserReviewCard(),
            ],
          ),
        ),
      ),
    );
  }
}
