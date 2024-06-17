import 'package:enyad_store_3/common/widgets/appbar/appBar.dart';
import 'package:enyad_store_3/common/widgets/appbar/tabbar.dart';
import 'package:enyad_store_3/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:enyad_store_3/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:enyad_store_3/common/widgets/custom_shapes/containers/searchcontainer.dart';
import 'package:enyad_store_3/common/widgets/layout/grid_layout.dart';
import 'package:enyad_store_3/common/widgets/products/cart/cart_menu_icon.dart';
import 'package:enyad_store_3/common/widgets/texts/section_heading.dart';
import 'package:enyad_store_3/features/shop/controller/category/category_controller.dart';
import 'package:enyad_store_3/features/shop/screens/brands/all_brands.dart';
import 'package:enyad_store_3/features/shop/screens/brands/brand_products.dart';
import 'package:enyad_store_3/features/shop/screens/store/widget/category_tab.dart';
import 'package:enyad_store_3/utils/constants/colors.dart';
import 'package:enyad_store_3/utils/constants/sizes.dart';
import 'package:enyad_store_3/utils/helper/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/shimmers/brand_shimmer.dart';
import '../../../../common/widgets/brands/brand_card.dart';
import '../../controller/product/brand_controller.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final brandController = Get.put(BrandController());
    final categories = CategoryController.instance.featuredCategories;
    final dark = SHelperFunction.isDarkMode(context);
    return DefaultTabController(
      length: categories.length,
      child: Scaffold(
        backgroundColor: dark ? SColors.darkerPurple : SColors.purple,
        appBar: SAppBar(
            title: Text('Shop',
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium!
                    .apply(color: Colors.white)),
            actions: const [SCartCounterIcon(iconColor: SColors.white)]),
        body: NestedScrollView(
          headerSliverBuilder: (_, innerIsBoxScrolled) {
            return [
              SliverAppBar(
                automaticallyImplyLeading: false,
                pinned: true,
                floating: true,
                backgroundColor: dark ? SColors.black : SColors.white,
                expandedHeight: 500,

                ///was 500

                flexibleSpace: SPrimaryHeaderContainer(
                  child: ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      /// ---Search Bar ---
                      const Padding(
                        padding: EdgeInsets.all(SSize.defautSpace),
                        child: SSearchContainer(
                          text: 'Search in Shop',
                          icon: Iconsax.search_favorite,
                          showBorder: true,
                          showBackground: false,
                          padding: EdgeInsets.zero,
                        ),
                      ),

                      /// ---Featured Brands ---
                      Container(
                        padding: const EdgeInsets.only(
                            left: SSize.defautSpace, right: SSize.defautSpace),
                        color: dark ? SColors.darkerPurple : SColors.purple,
                        child: SSectionHeading(
                            title: 'Featured Products',
                            textColor: dark ? SColors.grey : SColors.lightGrey,
                            onPressed: () =>
                                Get.to(() => const SAllBrandsScreen())),
                      ),

                      SRoundedContainer(
                        margin:
                            const EdgeInsets.symmetric(horizontal: SSize.sm),
                        padding: const EdgeInsets.all(SSize.md),
                        backgroundColor: dark ? SColors.dark : SColors.grey,
                        child: Obx(() {
                          if (brandController.isLoading.value) {
                            return const SBrandsShimmer(itemCount: 4);
                          }
                          if (brandController.featuredBrands.isEmpty) {
                            return Center(
                              child: Text(
                                'No featured products.',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .apply(color: SColors.black),
                              ),
                            );
                          }
                          return SGridLayout(
                              itemCount: brandController.featuredBrands.length,
                              mainAxisExtent: 125,

                              ///was 80
                              itemBuilder: (_, index) {
                                final brand =
                                    brandController.featuredBrands[index];
                                return SBrandCard(
                                  onTap: () => Get.to(
                                      () => SBrandProducts(brand: brand)),
                                  showBorder: true,
                                  brand: brand,
                                );
                              });
                        }),
                      ),
                    ],
                  ),
                ),

                ///Tabs
                bottom: STabBar(
                    tabs: categories
                        .map((category) => Tab(child: Text(category.name)))
                        .toList()),
              ),
            ];
          },
          body: SPrimaryHeaderContainer(
            child: TabBarView(
              children: categories
                  .map((category) => SCategoryTab(category: category))
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }
}
