import 'package:flutter/material.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';

class SRoundedContainer extends StatelessWidget {
  const SRoundedContainer({
    Key? key,
    this.width,
    this.height,
    this.radius = SSize.cardRadiusLg,
    this.padding,
    this.child,
    this.backgroundColor = SColors.white,
    this.margin,
    this.showBorder = false,
    this.borderColor = SColors.borderPrimary,
  }) : super(key: key);

  final double? width;
  final double? height;
  final double radius;
  final bool showBorder;
  final Widget? child;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final Color backgroundColor;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        border: showBorder ? Border.all(color: borderColor) : null,
        borderRadius: BorderRadius.circular(radius),
        color: backgroundColor,
      ),
      child: child,
    );
  }
}
