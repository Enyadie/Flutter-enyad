import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helper/helper_function.dart';
import '../../icons/circular_icon.dart';

class SQuantityAddAndRemoveButton extends StatelessWidget {
  const SQuantityAddAndRemoveButton({
    super.key,
    required this.quantity,
    this.add,
    this.remove,
  });

  final int quantity;
  final VoidCallback? add, remove;

  @override
  Widget build(BuildContext context) {
    final dark = SHelperFunction.isDarkMode(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SCircularIcon(
          icon: Iconsax.minus,
          width: 40,
          height: 40,
          color: SColors.white,
          size: SSize.md,
          backgroundColor: dark ? SColors.red.withOpacity(0.7) : SColors.red,
          onPressed: remove,
        ),
        const SizedBox(width: SSize.spaceBtwItems),
        Text(quantity.toString(),
            style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(width: SSize.spaceBtwItems),
        SCircularIcon(
          icon: Iconsax.add,
          width: 40,
          height: 40,
          color: SColors.white,
          size: SSize.md,
          backgroundColor: dark ? Colors.green.withOpacity(0.7) : Colors.green,
          onPressed: add,
        ),
      ],
    );
  }
}
