import 'package:enyad_store_3/common/shimmers/shimmer.dart';
import 'package:enyad_store_3/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class SHorizontalShimmer extends StatelessWidget {
  const SHorizontalShimmer({super.key, this.itemCount = 4});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      margin: const EdgeInsets.only(bottom: SSize.spaceBtwSections),
      child: ListView.separated(
        itemCount: itemCount,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) => const SizedBox(width: 180),
        itemBuilder: (_, __) => const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SShimmerEffect(width: 120, height: 120),
                SizedBox(width: SSize.spaceBtwItems),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: SSize.spaceBtwItems / 2),
                    SShimmerEffect(width: 160, height: 15),
                    SizedBox(height: SSize.spaceBtwItems / 2),
                    SShimmerEffect(width: 110, height: 15),
                    SizedBox(height: SSize.spaceBtwItems / 2),
                    SShimmerEffect(width: 80, height: 15),
                    Spacer(),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
