import 'package:enyad_store_3/common/shimmers/vertical_shimmer.dart';
import 'package:enyad_store_3/features/shop/controller/product/all_products.dart';
import 'package:enyad_store_3/features/shop/screens/home/widget/home_appbar.dart';
import 'package:enyad_store_3/features/shop/screens/home/widget/promoslider.dart';
import 'package:enyad_store_3/utils/constants/colors.dart';
import 'package:enyad_store_3/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/widgets/custom_shapes/containers/primary_header_container.dart';
import '../../../../common/shimmers/category_shimmer.dart';
import '../../../../common/widgets/custom_shapes/containers/searchcontainer.dart';
import '../../../../common/widgets/layout/grid_layout.dart';
import '../../../../common/widgets/products/product_cards/product_card_vertical.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../utils/helper/helper_function.dart';
import '../../controller/category/category_controller.dart';
import '../../controller/product/productcontroller.dart';
import 'widget/home_categories.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = SHelperFunction.isDarkMode(context);
    final controller = Get.put(ProductController());
    final categoryController = Get.put(CategoryController());
    return Scaffold(
      appBar: AppBar(
          backgroundColor: dark ? SColors.darkerPurple : SColors.purple,
          toolbarHeight: 5),
      backgroundColor: dark ? SColors.darkerPurple : SColors.purple,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SPrimaryHeaderContainer(
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Column(
                  children: [
                    /// custom appbar
                    const SHomeAppBar(),
                    const SizedBox(height: SSize.spaceBtwSections),

                    ///custom searchbar
                    const SSearchContainer(text: 'Search products'),
                    const SizedBox(height: SSize.spaceBtwSections),

                    ///categories
                    Obx(() {
                      if (categoryController.featuredCategories.isEmpty) {
                        return const SizedBox();
                      }
                      if (categoryController.isLoading.value) {
                        return const SCategoryShimmer();
                      } else {
                        return const Column(
                          children: [
                            ///headings
                            Padding(
                              padding: EdgeInsets.only(left: SSize.defautSpace),
                              child: SSectionHeading(
                                title: 'Categories',
                                showActionButton: false,
                                textColor: SColors.white,
                              ),
                            ),
                            SizedBox(height: SSize.spaceBtwItems),

                            ///categories
                            SHomeCategories()
                          ],
                        );
                      }
                    }),
                  ],
                ),
              ),
            ),

            ///body
            SPrimaryHeaderContainer(
              child: Column(
                children: [
                  ///slider popular
                  const SPromoSlider(),

                  ///heading
                  Padding(
                    padding: const EdgeInsets.only(
                        left: SSize.defautSpace,
                        right: SSize.defautSpace,
                        top: SSize.sm),
                    child: SSectionHeading(
                        title: 'Popular Products',
                        onPressed: () => Get.to(() => SAllProductsScreen(
                              title: 'Popular Products',
                              futureMethod: controller.getAllFeaturedProducts(),

                              ///can also use this query
                              // query: FirebaseFirestore.instance
                              //     .collection('Products')
                              //     .where('IsFeatured', isEqualTo: true)
                              //     .limit(30),
                            )),
                        textColor: SColors.white),
                  ),
                  // const SizedBox(height: SSize.spaceBtwItems),

                  ///popular products
                  Padding(
                    padding: const EdgeInsets.all(SSize.defautSpace),
                    child: Obx(() {
                      if (controller.isLoading.value) {
                        return const SVerticalShimmer();
                      }
                      if (controller.featuredProducts.isEmpty) {
                        controller.isLoading;
                        return Expanded(
                          child: SPrimaryHeaderContainer(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('No Data founds',
                                    style:
                                        Theme.of(context).textTheme.bodyMedium),
                                const SizedBox(height: SSize.sm),
                                const SVerticalShimmer(),
                              ],
                            ),
                          ),
                        );
                      } else {
                        return SGridLayout(
                          itemCount: controller.featuredProducts.length,
                          itemBuilder: (_, index) => SProductCardVertical(
                            product: controller.featuredProducts[index],
                          ),
                        );
                      }
                    }),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
