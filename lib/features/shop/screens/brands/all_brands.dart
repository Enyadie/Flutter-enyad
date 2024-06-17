import 'package:enyad_store_3/common/widgets/brands/brand_card.dart';
import 'package:enyad_store_3/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:enyad_store_3/common/widgets/layout/grid_layout.dart';
import 'package:enyad_store_3/features/shop/controller/product/brand_controller.dart';
import 'package:enyad_store_3/features/shop/screens/brands/brand_products.dart';
import 'package:enyad_store_3/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/shimmers/brand_shimmer.dart';
import '../../../../common/widgets/appbar/appBar.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/helper/helper_function.dart';

class SAllBrandsScreen extends StatelessWidget {
  const SAllBrandsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final brandController = BrandController.instance;
    final dark = SHelperFunction.isDarkMode(context);
    return Scaffold(
      backgroundColor: dark ? SColors.darkerPurple : SColors.purple,
      appBar: SAppBar(
        title: Text('Brand', style: Theme.of(context).textTheme.headlineMedium),
        showBackButton: true,
        buttonBackgroundColor: true,
      ),
      body: SPrimaryHeaderContainer(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(SSize.defautSpace),
            child: Column(
              children: [
                const SSectionHeading(
                  title: 'Brands',
                  showActionButton: false,
                ),
                const SizedBox(height: SSize.spaceBtwItems),
                Obx(() {
                  if (brandController.isLoading.value) {
                    return const SBrandsShimmer(itemCount: 4);
                  }
                  if (brandController.allBrands.isEmpty) {
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
                      itemCount: brandController.allBrands.length,
                      mainAxisExtent: 125,

                      ///was 80
                      itemBuilder: (_, index) {
                        final brand = brandController.allBrands[index];
                        return SBrandCard(
                          showBorder: true,
                          brand: brand,
                          onTap: () => Get.to(() => SBrandProducts(
                                brand: brand,
                              )),
                        );
                      });
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
