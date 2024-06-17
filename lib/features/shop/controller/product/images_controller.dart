import 'package:cached_network_image/cached_network_image.dart';
import 'package:enyad_store_3/features/shop/models/product_model.dart';
import 'package:enyad_store_3/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImagesController extends GetxController {
  static ImagesController get instance => Get.find();

  RxString selectedProductImage = ''.obs;

  List<String> getAllProductImages(ProductModel product) {
    ///wont add duplicate image url
    Set<String> images = {};

    images.add(product.thumbnail);

    selectedProductImage.value = product.thumbnail;

    if (product.images != null) {
      images.addAll(product.images!);
    }

    if (product.productVariations != null ||
        product.productVariations!.isNotEmpty) {
      images.addAll(
          product.productVariations!.map((variation) => variation.image));
    }

    return images.toList();
  }

  void showEnlargedImage(String image) {
    Get.to(
      fullscreenDialog: true,
      () => Dialog.fullscreen(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: SSize.defautSpace * 2,
                  horizontal: SSize.defautSpace),
              child: CachedNetworkImage(imageUrl: image),
            ),
            const SizedBox(height: SSize.spaceBtwItems),
            Align(
              alignment: Alignment.bottomCenter,
              widthFactor: 200,
              child: OutlinedButton(
                  onPressed: () => Get.back(), child: const Text('Exit')),
            )
          ],
        ),
      ),
    );
  }
}
