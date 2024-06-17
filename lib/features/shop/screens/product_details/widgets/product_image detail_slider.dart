import 'package:enyad_store_3/features/shop/controller/product/images_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/widgets/appbar/appBar.dart';
import '../../../../../common/widgets/image/rounded_image.dart';
import '../../../../../common/widgets/products/favourite_icon/favourite_icon.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helper/helper_function.dart';
import '../../../models/product_model.dart';

class SProductImageSlider extends StatelessWidget {
  const SProductImageSlider({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ImagesController());
    final images = controller.getAllProductImages(product);
    final dark = SHelperFunction.isDarkMode(context);
    return SingleChildScrollView(
      child: Stack(
        children: [
          ///---Large Image---
          Center(
            child: Padding(
              padding: const EdgeInsets.only(
                  top: SSize.defautSpace / 2, left: SSize.sm, right: SSize.sm),
              child: Obx(() {
                final image = controller.selectedProductImage.value;
                return SRoundedImage(
                  onPressed: () => controller.showEnlargedImage(image),
                  isNetworkImage: true,
                  padding: const EdgeInsets.only(
                      bottom: SSize.sm * 10, left: SSize.sm, right: SSize.sm),
                  backgroundColor: dark ? SColors.darkerPurple : SColors.purple,
                  imageUrl: image,
                  height: 400,
                  width: double.infinity,
                  fit: BoxFit.fill,
                );
              }),
            ),
          ),

          ///---slider image---
          Positioned(
            right: 0,
            bottom: 0,
            left: 0,
            child: SizedBox(
              height: 80,
              child: Center(
                child: ListView.separated(
                  separatorBuilder: (_, __) =>
                      const SizedBox(width: SSize.spaceBtwItems / 2),
                  itemCount: images.length,
                  shrinkWrap: true,
                  physics: const AlwaysScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (_, index) => Obx(() {
                    final imageSelected =
                        controller.selectedProductImage.value == images[index];
                    return SRoundedImage(
                        onPressed: () => controller.selectedProductImage.value =
                            images[index],
                        fit: BoxFit.fill,
                        isNetworkImage: true,
                        width: 80,
                        backgroundColor: dark ? SColors.dark : SColors.white,
                        border: Border.all(
                            width: 4,
                            color: imageSelected
                                ? SColors.secondary
                                : Colors.transparent),
                        padding: const EdgeInsets.all(SSize.sm / 2),
                        imageUrl: images[index]);
                  }),
                ),
              ),
            ),
          ),

          ///---appbar---
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            child: SAppBar(
              showBackground: false,
              showBackButton: false,
              backButtonSize: SSize.lg * 1.5,
              actions: [
                SFavouriteIcon(
                  productId: product.id,
                  backgroundColor: SColors.purple,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
