import 'package:enyad_store_3/utils/helper/helper_function.dart';
import 'package:flutter/material.dart';

import '../../../../utils/constants/colors.dart';
import '../curved_edges/curve_edge_widget.dart';
import 'circular_container.dart';

class SPrimaryHeaderContainer extends StatelessWidget {
  const SPrimaryHeaderContainer({
    super.key,
    required this.child,
    this.height,
  });

  final Widget child;
  final double? height;

  @override
  Widget build(BuildContext context) {
    final dark = SHelperFunction.isDarkMode(context);
    return SCurveEdgeWidget(
      child: Container(
        width: double.infinity,
        height: height,
        color: dark ? SColors.darkerPurple : SColors.purple,
        child: Stack(
          children: [
            Positioned(
                top: -150,
                right: -250,
                child: SRoundedContainer(
                  backgroundColor: SColors.textWhite.withOpacity(0.1),
                  width: 400,
                  height: 400,
                  radius: 100,
                )),
            Positioned(
                top: 150,
                right: -250,
                child: SRoundedContainer(
                    backgroundColor: SColors.textWhite.withOpacity(0.1),
                    width: 400,
                    height: 400,
                    radius: 100)),
            Positioned(
                top: -150,
                left: -250,
                child: SRoundedContainer(
                    backgroundColor: SColors.textWhite.withOpacity(0.1),
                    width: 400,
                    height: 400,
                    radius: 100)),
            Positioned(
                top: 150,
                left: -250,
                child: SRoundedContainer(
                    backgroundColor: SColors.textWhite.withOpacity(0.1),
                    width: 400,
                    height: 400,
                    radius: 100)),
            child,
          ],
        ),
      ),
    );
  }
}
