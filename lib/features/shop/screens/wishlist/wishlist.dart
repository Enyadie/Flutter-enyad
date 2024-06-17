import 'package:enyad_store_3/common/shimmers/vertical_shimmer.dart';
import 'package:enyad_store_3/common/widgets/appbar/appBar.dart';
import 'package:enyad_store_3/common/widgets/icons/circular_icon.dart';
import 'package:enyad_store_3/common/widgets/layout/grid_layout.dart';
import 'package:enyad_store_3/common/widgets/loaders/animation_loader.dart';
import 'package:enyad_store_3/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:enyad_store_3/features/shop/controller/product/favourites_controller.dart';
import 'package:enyad_store_3/features/shop/screens/home/home.dart';
import 'package:enyad_store_3/navigation_menu.dart';
import 'package:enyad_store_3/utils/constants/colors.dart';
import 'package:enyad_store_3/utils/constants/image_strings.dart';
import 'package:enyad_store_3/utils/constants/sizes.dart';
import 'package:enyad_store_3/utils/helper/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/custom_shapes/containers/primary_header_container.dart';

class WishListScreen extends StatelessWidget {
  const WishListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FavouritesController());
    final dark = SHelperFunction.isDarkMode(context);

    return Scaffold(
      backgroundColor: dark ? SColors.darkerPurple : SColors.purple,
      appBar: SAppBar(
        title: Text('Wishlist',
            style: Theme.of(context)
                .textTheme
                .headlineMedium!
                .apply(color: Colors.white)),
        actions: [
          SCircularIcon(
            icon: Iconsax.add,
            backgroundColor: Colors.transparent,
            color: Colors.white,
            onPressed: () => Get.to(const HomeScreen()),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: SPrimaryHeaderContainer(
          child: Padding(
            padding: const EdgeInsets.all(SSize.defautSpace),
            child: Column(
              children: [
                Obx(
                  () => FutureBuilder(
                      future: controller.favouriteProducts(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const SVerticalShimmer(itemCount: 8);
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return SAnimationLoaderWidget(
                            text: 'Oh Dear! WishList is Empty',
                            animation: SImages.empty,
                            showAction: true,
                            actionText: 'Item\'s needed',
                            onActionPressed: () =>
                                Get.off(() => const NavigationMenu()),
                          );
                        } else {
                          final products = snapshot.data!;
                          return SGridLayout(
                              itemCount: products.length,
                              itemBuilder: (_, index) => SProductCardVertical(
                                    product: products[index],
                                  ));
                        }
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
