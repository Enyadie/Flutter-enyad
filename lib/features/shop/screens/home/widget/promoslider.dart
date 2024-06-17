import 'package:carousel_slider/carousel_slider.dart';
import 'package:enyad_store_3/common/shimmers/shimmer.dart';
import 'package:enyad_store_3/features/shop/controller/banner/banner_controller.dart';
import 'package:enyad_store_3/utils/constants/colors.dart';
import 'package:enyad_store_3/utils/device/device_utility.dart';
import 'package:enyad_store_3/utils/helper/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/widgets/custom_shapes/containers/circular_container.dart';
import '../../../../../common/widgets/image/rounded_image.dart';
import '../../../../../utils/constants/sizes.dart';

class SPromoSlider extends StatelessWidget {
  const SPromoSlider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BannerController());
    final dark = SHelperFunction.isDarkMode(context);

    ///new instance of home controller
    return Obx(() {
      if (controller.isLoading.value) {
        return const SShimmerEffect(width: double.infinity, height: 200);
      } else if (controller.banners.isEmpty) {
        return const SizedBox();
      } else {
        return Column(
          children: [
            CarouselSlider(
              options: CarouselOptions(
                  height: 200,
                  viewportFraction: 0.9,
                  onPageChanged: (index, _) =>
                      controller.updatePageIndicator(index)),
              items: controller.banners
                  .map((banner) => Padding(
                        padding: const EdgeInsets.only(right: 2),
                        child: SRoundedImage(
                          isNetworkImage: true,
                          fit: BoxFit.fill,
                          width: 450,
                          backgroundColor:
                              dark ? SColors.darkerGrey : SColors.grey,
                          imageUrl: banner.imageUrl,
                          onPressed: () => Get.toNamed(banner.targetScreen),
                        ),
                      ))
                  .toList(),
            ),
            const SizedBox(height: SSize.spaceBtwItems),
            Center(
              child: Obx(() {
                final int bannerCount = controller.banners.length;
                const double spacing = 2;
                final double indicatorWidth =
                    (SDeviceUtils.getScreenWidth(context) / 2 -
                            (bannerCount - 1) * spacing) /
                        bannerCount;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: SSize.md),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      for (int i = 0; i < bannerCount; i++)
                        SRoundedContainer(
                          width: indicatorWidth,
                          // width: 25,
                          height: 9,
                          margin: EdgeInsets.symmetric(
                              horizontal: i == bannerCount ? 0 : 1),
                          backgroundColor:
                              controller.carouselCurrentIndex.value == i
                                  ? dark
                                      ? SColors.purple
                                      : SColors.darkerPurple
                                  : SColors.grey,
                        ),
                    ],
                  ),
                );
              }),
            ),
          ],
        );
      }
    });
  }
}
