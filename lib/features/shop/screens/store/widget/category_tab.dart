import 'package:enyad_store_3/common/shimmers/vertical_shimmer.dart';
import 'package:enyad_store_3/common/widgets/layout/grid_layout.dart';
import 'package:enyad_store_3/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:enyad_store_3/common/widgets/texts/section_heading.dart';
import 'package:enyad_store_3/features/shop/controller/category/category_controller.dart';
import 'package:enyad_store_3/features/shop/controller/product/all_products.dart';
import 'package:enyad_store_3/features/shop/models/category_model.dart';
import 'package:enyad_store_3/features/shop/screens/store/widget/category_brands.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../utils/constants/sizes.dart';

class SCategoryTab extends StatelessWidget {
  const SCategoryTab({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final controller = CategoryController.instance;
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Padding(
          padding: const EdgeInsets.all(SSize.defautSpace),
          child: Column(
            children: [
              ///---Brands---
              CategoryBrands(category: category),
              const SizedBox(height: SSize.spaceBtwItems),

              ///---Products---
              FutureBuilder(
                  future:
                      controller.getCategoryProducts(categoryId: category.id),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const SVerticalShimmer(); // or any other loading widget
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (snapshot.data == null) {
                      return const Text(
                          'No data available'); // or any other placeholder widget
                    }
                    final products = snapshot.data!;

                    return Column(
                      children: [
                        SSectionHeading(
                          title: 'Products for you',
                          onPressed: () => Get.to(
                            SAllProductsScreen(
                              title: category.name,
                              futureMethod: controller.getCategoryProducts(
                                  categoryId: category.id, limit: -1),
                            ),
                          ),
                        ),
                        const SizedBox(height: SSize.spaceBtwItems),
                        SGridLayout(
                          itemCount: products.length,
                          itemBuilder: (_, index) =>
                              SProductCardVertical(product: products[index]),
                        )
                      ],
                    );
                  }),
            ],
          ),
        ),
      ],
    );
  }
}
