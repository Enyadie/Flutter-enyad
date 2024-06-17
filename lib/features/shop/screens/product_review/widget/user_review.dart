import 'package:cached_network_image/cached_network_image.dart';
import 'package:enyad_store_3/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:enyad_store_3/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:enyad_store_3/common/widgets/products/rating/productrating.dart';
import 'package:enyad_store_3/utils/constants/colors.dart';
import 'package:enyad_store_3/utils/constants/image_strings.dart';
import 'package:enyad_store_3/utils/constants/sizes.dart';
import 'package:enyad_store_3/utils/helper/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:readmore/readmore.dart';

import '../../../../../common/shimmers/shimmer.dart';
import '../../../../personalization/controller/user_controller.dart';
import '../../../../personalization/screens/profile/profile.dart';

class UserReviewCard extends StatelessWidget {
  const UserReviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    final networkImage = controller.user.value.profilePicture;
    final image = networkImage.isNotEmpty ? networkImage : SImages.user;
    final dark = SHelperFunction.isDarkMode(context);
    return SPrimaryHeaderContainer(
      child: Padding(
        padding: const EdgeInsets.all(SSize.sm),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    controller.imageUploading.value
                        ? const SShimmerEffect(
                            width: 10,
                            height: 10,
                            radius: 10,
                          )
                        : GestureDetector(
                            onTap: () => Get.to(() => const ProfileScreen()),
                            child: CircleAvatar(
                              backgroundImage:
                                  CachedNetworkImageProvider(image),
                            ),
                          ),
                    const SizedBox(width: SSize.spaceBtwItems),
                    Text('Roshane Erskine',
                        style: Theme.of(context).textTheme.titleLarge),
                  ],
                ),
                IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))
              ],
            ),
            const SizedBox(height: SSize.spaceBtwItems),

            ///---Review---
            Row(
              children: [
                const SRatingBarIndicator(rating: 2.5),
                const SizedBox(width: SSize.spaceBtwItems),
                Text('12 May,2024',
                    style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
            const SizedBox(height: SSize.spaceBtwItems),
            const ReadMoreText(
              'This is a review',
              trimLines: 2,
              trimMode: TrimMode.Line,
              trimExpandedText: ' Show less',
              trimCollapsedText: ' Show more',
              moreStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: SColors.primary),
              lessStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: SColors.red),
            ),
            const SizedBox(height: SSize.spaceBtwItems),

            ///---Company Review---
            SRoundedContainer(
              backgroundColor: dark ? SColors.darkerGrey : SColors.grey,
              child: Padding(
                padding: const EdgeInsets.all(SSize.md),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Enyad Store',
                            style: Theme.of(context).textTheme.titleMedium),
                        Text('12 May,2024',
                            style: Theme.of(context).textTheme.bodyMedium),
                      ],
                    ),
                    const SizedBox(height: SSize.spaceBtwItems),
                    const ReadMoreText(
                      "this is a response",
                      trimLines: 2,
                      trimMode: TrimMode.Line,
                      trimExpandedText: ' Show less',
                      trimCollapsedText: ' Show more',
                      moreStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: SColors.primary),
                      lessStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: SColors.red),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: SSize.spaceBtwSections),
          ],
        ),
      ),
    );
  }
}
