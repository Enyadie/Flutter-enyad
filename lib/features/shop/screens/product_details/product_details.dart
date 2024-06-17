import 'package:enyad_store_3/common/widgets/appbar/appBar.dart';
import 'package:enyad_store_3/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:enyad_store_3/common/widgets/texts/section_heading.dart';
import 'package:enyad_store_3/features/shop/screens/product_details/widgets/bottom_add_to_cart_widget.dart';
import 'package:enyad_store_3/features/shop/screens/product_details/widgets/product_attributes.dart';
import 'package:enyad_store_3/features/shop/screens/product_details/widgets/product_image%20detail_slider.dart';
import 'package:enyad_store_3/features/shop/screens/product_details/widgets/product_meta_data.dart';
import 'package:enyad_store_3/features/shop/screens/product_details/widgets/rating_share_widget.dart';
import 'package:enyad_store_3/features/shop/screens/product_review/product_reviews.dart';
import 'package:enyad_store_3/utils/constants/colors.dart';
import 'package:enyad_store_3/utils/constants/sizes.dart';
import 'package:enyad_store_3/utils/helper/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:readmore/readmore.dart';

import '../../../../common/widgets/custom_shapes/containers/searchcontainer.dart';
import '../../../../utils/constants/enums.dart';
import '../../models/product_model.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final dark = SHelperFunction.isDarkMode(context);
    return Scaffold(
      appBar: const SAppBar(
        showBackButton: false,
        actions: [
          Expanded(flex: 3, child: SSearchContainer(text: 'Search products')),
        ],
      ),
      backgroundColor: dark ? SColors.darkerPurple : SColors.purple,
      bottomNavigationBar: SBottomAddToCart(product: product),
      body: SPrimaryHeaderContainer(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ///---image Slider---
                    SProductImageSlider(
                      product: product,
                    ),

                    SPrimaryHeaderContainer(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          right: SSize.defautSpace / 2,
                          left: SSize.defautSpace / 2,
                        ),
                        child: Column(
                          children: [
                            const SRatingAndShare(),

                            ///---price title---
                            SProductMetaData(product: product),

                            ///---attributes---
                            if (product.productType !=
                                ProductType.single.toString())
                              SProductAttributes(product: product),
                            if (product.productType !=
                                ProductType.single.toString())
                              const SizedBox(height: SSize.spaceBtwSections),

                            ///---checkout btn---
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                  onPressed: () {},
                                  child: const Text('Checkout')),
                            ),
                            const SizedBox(height: SSize.spaceBtwSections),

                            ///---description---
                            const SSectionHeading(
                              title: 'Description',
                              showActionButton: false,
                            ),
                            const SizedBox(height: SSize.spaceBtwSections),
                            ReadMoreText(
                              product.description ?? '',
                              style: const TextStyle(fontSize: 15),
                              trimLines: 2,
                              trimMode: TrimMode.Line,
                              moreStyle: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue),
                              lessStyle: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: SColors.red),
                            ),

                            const SizedBox(height: SSize.spaceBtwSections),

                            ///---review---
                            Divider(
                                color: dark
                                    ? SColors.lightGrey
                                    : SColors.darkerGrey),
                            const SizedBox(height: SSize.spaceBtwSections),
                            SSectionHeading(
                                title: 'Reviews(2)',
                                onPressed: () =>
                                    Get.to(() => const ProductReviewScreen())),
                            const SizedBox(height: SSize.spaceBtwSections),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
