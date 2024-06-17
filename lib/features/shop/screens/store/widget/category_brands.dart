import 'package:enyad_store_3/features/shop/controller/product/brand_controller.dart';
import 'package:enyad_store_3/utils/constants/sizes.dart';
import 'package:enyad_store_3/utils/helper/cloud_helper_function.dart';
import 'package:flutter/material.dart';

import '../../../../../common/shimmers/box_shimmer.dart';
import '../../../../../common/shimmers/list_tile_shimmer.dart';
import '../../../../../common/widgets/brands/brandshowcase.dart';
import '../../../models/category_model.dart';

class CategoryBrands extends StatelessWidget {
  const CategoryBrands({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final controller = BrandController.instance;
    return FutureBuilder(
        future: controller.getBrandsCategory(category.id),
        builder: (context, snapshot) {
          const loader = Column(
            children: [
              SListTitleShimmer(),
              SizedBox(height: SSize.spaceBtwItems),
              SBoxShimmer(),
              SizedBox(height: SSize.spaceBtwItems)
            ],
          );
          final widget = SCloudHelperFunction.checkMultipleRecordState(
              snapshot: snapshot, loader: loader);
          if (widget != null) return widget;
          final brands = snapshot.data!;
          return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: brands.length,
              itemBuilder: (_, index) {
                final brand = brands[index];
                return FutureBuilder(
                  future:
                      controller.getBrandProducts(brandId: brand.id, limit: 3),
                  builder: (context, snapshot) {
                    final widget =
                        SCloudHelperFunction.checkMultipleRecordState(
                            snapshot: snapshot, loader: loader);
                    if (widget != null) return widget;
                    final products = snapshot.data!;
                    return SBrandShowCase(
                        images: products.map((e) => e.thumbnail).toList(),
                        brand: brand);
                  },
                );
              });
        });
  }
}
