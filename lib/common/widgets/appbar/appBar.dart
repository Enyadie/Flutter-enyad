import 'package:enyad_store_3/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:enyad_store_3/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/device/device_utility.dart';
import '../../../utils/helper/helper_function.dart';

class SAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SAppBar({
    super.key,
    this.title,
    this.showBackButton = false,
    this.leadingIcon,
    this.actions,
    this.leadingOnPressed,
    this.buttonBackgroundColor = false,
    this.showBackground = true,
    this.backButtonSize,
  });

  final Widget? title;
  final bool showBackButton;
  final IconData? leadingIcon;
  final List<Widget>? actions;
  final VoidCallback? leadingOnPressed;
  final bool buttonBackgroundColor;
  final bool showBackground;
  final double? backButtonSize;

  @override
  Widget build(BuildContext context) {
    final dark = SHelperFunction.isDarkMode(context);
    if (!showBackground) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: SSize.sm),
        child: AppBar(
          automaticallyImplyLeading: false,
          leading: showBackButton
              ? Container(
                  color: Colors.transparent,
                  child: IconButton(
                    onPressed: () {
                      if (Get.previousRoute.isNotEmpty) {
                        Get.back();
                      } else {
                        Navigator.of(Get.context!).pop();
                      }
                    },
                    icon: Icon(Iconsax.arrow_left,
                        size: backButtonSize,
                        color: buttonBackgroundColor
                            ? SColors.white
                            : dark
                                ? SColors.white
                                : SColors.black),
                  ),
                )
              : leadingIcon != null
                  ? Container(
                      color: Colors.transparent,
                      child: IconButton(
                        onPressed: leadingOnPressed,
                        icon: Icon(
                          leadingIcon,
                        ),
                      ),
                    )
                  : null,
          title: title,
          actions: actions,
        ),
      );
    }
    if (!showBackground) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: SSize.md),
        child: AppBar(
          automaticallyImplyLeading: false,
          leading: showBackButton
              ? Container(
                  color: Colors.transparent,
                  child: IconButton(
                    onPressed: () {
                      if (Get.previousRoute.isNotEmpty) {
                        Get.back();
                      } else {
                        Navigator.of(Get.context!).pop();
                      }
                    },
                    icon: Icon(Iconsax.arrow_left,
                        size: backButtonSize,
                        color: buttonBackgroundColor
                            ? SColors.white
                            : dark
                                ? SColors.white
                                : SColors.black),
                  ),
                )
              : leadingIcon != null
                  ? Container(
                      color: Colors.transparent,
                      child: IconButton(
                        onPressed: leadingOnPressed,
                        icon: Icon(leadingIcon),
                      ),
                    )
                  : null,
          title: title,
          actions: actions,
        ),
      );
    } else {
      return SPrimaryHeaderContainer(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: SSize.md),
          child: AppBar(
            automaticallyImplyLeading: false,
            leading: showBackButton
                ? Container(
                    color: Colors.transparent,
                    child: IconButton(
                      onPressed: () {
                        if (Get.previousRoute.isNotEmpty) {
                          Get.back();
                        } else {
                          Navigator.of(Get.context!).pop();
                        }
                      },
                      icon: Icon(Iconsax.arrow_left,
                          size: backButtonSize,
                          color: buttonBackgroundColor
                              ? SColors.white
                              : dark
                                  ? SColors.white
                                  : SColors.black),
                    ),
                  )
                : leadingIcon != null
                    ? Container(
                        color: Colors.transparent,
                        child: IconButton(
                          onPressed: leadingOnPressed,
                          icon: Icon(leadingIcon),
                        ),
                      )
                    : null,
            title: title,
            actions: actions,
          ),
        ),
      );
    }
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(SDeviceUtils.getAppBarHeight());
}
