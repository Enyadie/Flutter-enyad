import 'package:enyad_store_3/common/shimmers/shimmer.dart';
import 'package:enyad_store_3/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class SCategoryShimmer extends StatelessWidget {
  const SCategoryShimmer({super.key, this.itemCount = 10});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 115,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        separatorBuilder: (_, __) => const SizedBox(width: SSize.spaceBtwItems),
        itemCount: itemCount,
        itemBuilder: (_, __) {
          return const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Image
              SShimmerEffect(width: 85, height: 85),
              SizedBox(height: SSize.spaceBtwItems / 2),

              ///Text
              SShimmerEffect(width: 85, height: 10),
            ],
          );
        },
      ),
    );
  }
}
