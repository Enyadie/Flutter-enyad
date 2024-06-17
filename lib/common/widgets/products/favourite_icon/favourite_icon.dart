import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../features/shop/controller/product/favourites_controller.dart';
import '../../../../utils/constants/colors.dart';
import '../../icons/circular_icon.dart';

class SFavouriteIcon extends StatelessWidget {
  const SFavouriteIcon(
      {super.key,
      this.backgroundColor = Colors.transparent,
      required this.productId});

  final Color? backgroundColor;
  final String productId;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FavouritesController());
    return Obx(
      () => SCircularIcon(
        icon:
            controller.isFavourite(productId) ? Iconsax.heart5 : Iconsax.heart,
        color: controller.isFavourite(productId) ? SColors.error : null,
        backgroundColor: backgroundColor,
        size: 35,
        onPressed: () => controller.toggleFavouriteProduct(productId),
      ),
    );
  }
}
