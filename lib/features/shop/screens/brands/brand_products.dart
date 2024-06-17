import 'package:enyad_store_3/common/shimmers/vertical_shimmer.dart';
import 'package:enyad_store_3/common/widgets/brands/brand_card.dart';
import 'package:enyad_store_3/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:enyad_store_3/features/shop/controller/product/brand_controller.dart';
import 'package:enyad_store_3/features/shop/models/brand_model.dart';
import 'package:enyad_store_3/utils/constants/colors.dart';
import 'package:enyad_store_3/utils/constants/sizes.dart';
import 'package:enyad_store_3/utils/helper/helper_function.dart';
import 'package:flutter/material.dart';

import '../../../../common/widgets/appbar/appBar.dart';
import '../../../../common/widgets/products/Filter/filter.dart';

class SBrandProducts extends StatelessWidget {
  const SBrandProducts({super.key, required this.brand});

  final BrandModel brand;

  @override
  Widget build(BuildContext context) {
    final dark = SHelperFunction.isDarkMode(context);
    final controller = BrandController.instance;
    return Scaffold(
      backgroundColor: dark ? SColors.darkerPurple : SColors.purple,
      appBar:
          // AppBar(
          //   title: Text(brand.name),
          // ),
          SAppBar(
        showBackground: true,
        buttonBackgroundColor: true,
        showBackButton: true,
        title: Text(
          brand.name,
          style: Theme.of(context)
              .textTheme
              .headlineMedium!
              .apply(color: dark ? SColors.grey : SColors.lightGrey),
        ),
      ),
      body: SPrimaryHeaderContainer(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(SSize.defautSpace),
            child: Column(
              children: [
                ///---Brand details---
                SBrandCard(showBorder: true, brand: brand),
                const SizedBox(height: SSize.spaceBtwSections),
                FutureBuilder(
                    future: controller.getBrandProducts(brandId: brand.id),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const SVerticalShimmer(); // or any other loading widget
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else if (snapshot.data == null) {
                        return const Text(
                            'No data available'); // or any other placeholder widget
                      }
                      final brandProducts = snapshot.data!;
                      return SSortableProducts(
                        products: brandProducts,
                      );
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
