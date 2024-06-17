import 'package:enyad_store_3/common/shimmers/shimmer.dart';
import 'package:enyad_store_3/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class SListTitleShimmer extends StatelessWidget {
  const SListTitleShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(
          children: [
            SShimmerEffect(width: 50, height: 50, radius: 50),
            SizedBox(width: SSize.spaceBtwItems),
            Column(
              children: [
                SShimmerEffect(width: 100, height: 15),
                SizedBox(width: SSize.spaceBtwItems),
                SShimmerEffect(width: 80, height: 12),
              ],
            )
          ],
        )
      ],
    );
  }
}
