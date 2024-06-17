import 'package:enyad_store_3/common/widgets/texts/brandtitletext.dart';
import 'package:enyad_store_3/utils/constants/colors.dart';
import 'package:enyad_store_3/utils/constants/enums.dart';
import 'package:enyad_store_3/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class SBrandTitleWithVerifiedicon extends StatelessWidget {
  const SBrandTitleWithVerifiedicon({
    super.key,
    required this.title,
    this.maxLines = 1,
    this.textColor,
    this.iconColor = SColors.primary,
    this.textAlign = TextAlign.center,
    this.brandTextSize = TextSizes.small,
  });

  final String title;
  final int maxLines;
  final Color? textColor, iconColor;
  final TextAlign? textAlign;
  final TextSizes brandTextSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible( ///from different screen sizes to wrap content
          child: SBrandTitleText(
            title: title,
            color: textColor,
            maxLines: maxLines,
            textAlign: textAlign,
            brandTextSize: brandTextSize,
          ),
        ),
        const SizedBox(width: SSize.xs),
        Icon(
          Iconsax.verify5,
          color: iconColor,
          size: SSize.md,
        )
      ],
    );
  }
}
