import 'package:flutter/material.dart';

class SProductTitleText extends StatelessWidget {
  const SProductTitleText({
    super.key,
    required this.title,
    this.smallSize = false,
    this.maxLine = 2,
    this.textAlign = TextAlign.left,
    this.textColor,
  });

  final String title;
  final bool smallSize;
  final int maxLine;
  final TextAlign? textAlign;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: !smallSize
              ? Theme.of(context).textTheme.labelLarge
              : Theme.of(context).textTheme.titleSmall!.apply(color: textColor),
          overflow: TextOverflow.ellipsis,
          maxLines: maxLine,
          textAlign: textAlign,
        )
      ],
    );
  }
}
