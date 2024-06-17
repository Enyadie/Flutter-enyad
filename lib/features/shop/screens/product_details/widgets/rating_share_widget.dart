import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../utils/constants/sizes.dart';

class SRatingAndShare extends StatelessWidget {
  const SRatingAndShare({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ///---rating---
        Row(
          children: [
            const Icon(Iconsax.star5, color: Colors.amber, size: 30),
            const SizedBox(width: SSize.spaceBtwItems / 2),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                      text: '10.5',
                      style: Theme.of(context).textTheme.bodyLarge),
                  TextSpan(
                      text: ' (200)',
                      style: Theme.of(context).textTheme.bodyLarge)
                ],
              ),
            )
          ],
        ),

        ///---share button---
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.share, size: SSize.iconMd),
        ),
      ],
    );
  }
}
