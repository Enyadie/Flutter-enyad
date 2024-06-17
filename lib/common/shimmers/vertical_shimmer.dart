import 'package:enyad_store_3/common/shimmers/shimmer.dart';
import 'package:enyad_store_3/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

import '../widgets/layout/grid_layout.dart';

class SVerticalShimmer extends StatelessWidget {
  const SVerticalShimmer({super.key, this.itemCount = 4});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return SGridLayout(
      itemCount: itemCount,
      itemBuilder: (_, __) => const SizedBox(
        width: 180,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SShimmerEffect(width: 180, height: 180),
            SizedBox(height: SSize.spaceBtwItems / 2),
            SShimmerEffect(width: 160, height: 20),
            SizedBox(height: SSize.spaceBtwItems / 2),
            SShimmerEffect(width: 120, height: 20),
          ],
        ),
      ),
    );
  }
}
