import 'package:enyad_store_3/utils/constants/colors.dart';
import 'package:enyad_store_3/utils/helper/helper_function.dart';
import 'package:flutter/material.dart';

class SSectionHeading extends StatelessWidget {
  const SSectionHeading({
    super.key,
    this.textColor,
    this.showActionButton = true,
    required this.title,
    this.buttonTitle = 'View all',
    this.onPressed,
  });

  final Color? textColor;
  final bool showActionButton;
  final String title, buttonTitle;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    final dark = SHelperFunction.isDarkMode(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .apply(color: textColor),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        if (showActionButton)
          TextButton(
            onPressed: onPressed,
            child: Text(buttonTitle,
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .apply(color: dark ? SColors.grey : SColors.darkerGrey)),
          )
      ],
    );
  }
}
