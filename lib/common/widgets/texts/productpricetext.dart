import 'package:flutter/material.dart';

class SProductPriceText extends StatelessWidget {
  const SProductPriceText({
    super.key,
    required this.price,
    this.isLarge = false,
    this.currencySign = '\$',
    this.lineThrough = false,
    this.maxLine = 1,
    this.textColor,
  });

  final String price, currencySign;
  final bool isLarge, lineThrough;
  final int maxLine;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Text(currencySign + price,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: isLarge
            ? Theme.of(context).textTheme.headlineMedium!.apply(
                  color: textColor,
                  decoration: lineThrough ? TextDecoration.lineThrough : null,
                )
            : Theme.of(context).textTheme.headlineSmall!.apply(
                color: textColor,
                decoration: lineThrough ? TextDecoration.lineThrough : null));
  }
}
