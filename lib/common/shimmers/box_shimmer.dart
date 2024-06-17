import 'package:enyad_store_3/common/shimmers/shimmer.dart';
import 'package:enyad_store_3/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class SBoxShimmer extends StatelessWidget {
  const SBoxShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(
          children: [
            Expanded(child: SShimmerEffect(width: 150, height: 110)),
            SizedBox(width: SSize.spaceBtwItems),
            Expanded(child: SShimmerEffect(width: 150, height: 110)),
            SizedBox(width: SSize.spaceBtwItems),
            Expanded(child: SShimmerEffect(width: 150, height: 110))
          ],
        ),
      ],
    );
  }
}
