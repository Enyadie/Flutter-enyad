import 'package:enyad_store_3/common/widgets/appbar/appBar.dart';
import 'package:enyad_store_3/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:enyad_store_3/common/widgets/image/rounded_image.dart';
import 'package:enyad_store_3/common/widgets/products/product_cards/product_card_horizontal.dart';
import 'package:enyad_store_3/common/widgets/texts/section_heading.dart';
import 'package:enyad_store_3/features/shop/controller/category/category_controller.dart';
import 'package:enyad_store_3/features/shop/controller/product/all_products.dart';
import 'package:enyad_store_3/features/shop/models/category_model.dart';
import 'package:enyad_store_3/utils/constants/colors.dart';
import 'package:enyad_store_3/utils/constants/image_strings.dart';
import 'package:enyad_store_3/utils/constants/sizes.dart';
import 'package:enyad_store_3/utils/helper/cloud_helper_function.dart';
import 'package:enyad_store_3/utils/helper/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/shimmers/horizonatal_shimmer.dart';

class SubCategoryScreen extends StatelessWidget {
  const SubCategoryScreen({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final controller = CategoryController.instance;
    final dark = SHelperFunction.isDarkMode(context);
    return Scaffold(
      backgroundColor: dark ? SColors.darkerPurple : SColors.purple,
      appBar: SAppBar(
        title: Text(
          category.name,
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .apply(color: SColors.white),
        ),
        showBackButton: true,
        buttonBackgroundColor: true,
      ),
      body: SPrimaryHeaderContainer(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(SSize.defautSpace),
            child: Column(
              children: [
                ///---banner---
                SRoundedImage(
                    height: 200,
                    fit: BoxFit.fill,
                    border: Border.all(
                        color: dark ? SColors.darkerGrey : SColors.darkGrey,
                        width: 2),
                    width: double.infinity,
                    imageUrl: SImages.shirt_image,
                    applyImageRadius: true),
                const SizedBox(height: SSize.spaceBtwSections),

                ///---subCategory---
                FutureBuilder(
                    future: controller.getSubCategories(category.id),
                    builder: (context, snapshot) {
                      const loader = SHorizontalShimmer();
                      final widget =
                          SCloudHelperFunction.checkMultipleRecordState(
                              snapshot: snapshot, loader: loader);
                      if (widget != null) return widget;
                      if (snapshot.hasError) {
                        return const Center(
                            child: Text('Error loading subcategories'));
                      }
                      if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(
                            child: Text('No subcategories found.'));
                      }
                      final subCategories = snapshot.data!;
                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: subCategories.length,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (_, index) {
                            final subCategory = subCategories[index];
                            return FutureBuilder(
                                future: controller.getCategoryProducts(
                                    categoryId: subCategory.id),
                                builder: (context, snapshot) {
                                  final widget = SCloudHelperFunction
                                      .checkMultipleRecordState(
                                          snapshot: snapshot);
                                  if (widget != null) return widget;
                                  if (snapshot.hasError) {
                                    return const Center(
                                        child: Text('Error loading products'));
                                  }
                                  if (!snapshot.hasData ||
                                      snapshot.data!.isEmpty) {
                                    return const Center(
                                        child: Text('No products found.'));
                                  }
                                  final products = snapshot.data!;
                                  return Column(
                                    children: [
                                      SSectionHeading(
                                        title: subCategory.name,
                                        textColor: SColors.white,
                                        onPressed: () => Get.to(
                                          () => SAllProductsScreen(
                                            title: subCategory.name,
                                            futureMethod:
                                                controller.getCategoryProducts(
                                                    categoryId: subCategory.id,
                                                    limit: -1),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                          height: SSize.spaceBtwSections / 2),
                                      SizedBox(
                                        height: 125,
                                        child: ListView.separated(
                                          itemCount: products.length,
                                          scrollDirection: Axis.horizontal,
                                          separatorBuilder: (context, index) =>
                                              const SizedBox(
                                                  width: SSize.sm / 2),
                                          itemBuilder: (context, index) =>
                                              SProductCardHorizontal(
                                                  product: products[index]),
                                        ),
                                      ),
                                      const SizedBox(
                                          height: SSize.spaceBtwSections / 2),
                                    ],
                                  );
                                });
                          });
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
