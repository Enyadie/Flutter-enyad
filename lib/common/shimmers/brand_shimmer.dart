import 'package:enyad_store_3/common/shimmers/shimmer.dart';
import 'package:enyad_store_3/common/widgets/layout/grid_layout.dart';
import 'package:flutter/material.dart';

class SBrandsShimmer extends StatelessWidget {
  const SBrandsShimmer({super.key, this.itemCount = 4});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return SGridLayout(
        itemCount: itemCount,
        itemBuilder: (_, __) => const SShimmerEffect(width: 300, height: 80));
  }
}
