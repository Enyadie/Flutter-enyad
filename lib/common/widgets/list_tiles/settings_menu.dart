import 'package:enyad_store_3/utils/constants/colors.dart';
import 'package:enyad_store_3/utils/helper/helper_function.dart';
import 'package:flutter/material.dart';

class SSettingMenuTile extends StatelessWidget {
  const SSettingMenuTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subTitle,
    this.trailing,
    this.onTap,
    this.showBackGround = true,
  });

  final IconData icon;
  final String title, subTitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  final bool showBackGround;

  @override
  Widget build(BuildContext context) {
    final dark = SHelperFunction.isDarkMode(context);
    if (showBackGround) {
      return ListTile(
        leading: Icon(
          icon,
          size: 32,
          color: SColors.primary,
        ),
        title: Text(title,
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .apply(color: dark ? SColors.grey : SColors.lightGrey)),
        subtitle: Text(subTitle,
            style: Theme.of(context)
                .textTheme
                .labelMedium!
                .apply(color: dark ? SColors.grey : SColors.lightGrey)),
        trailing: trailing,
        onTap: onTap,
      );
    } else {
      return ListTile(
        leading: Icon(
          icon,
          size: 32,
          color: SColors.primary,
        ),
        title: Text(title,
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .apply(color: dark ? SColors.grey : SColors.lightGrey)),
        subtitle: Text(subTitle,
            style: Theme.of(context)
                .textTheme
                .labelMedium!
                .apply(color: dark ? SColors.grey : SColors.lightGrey)),
        trailing: trailing,
        onTap: onTap,
      );
    }
  }
}
