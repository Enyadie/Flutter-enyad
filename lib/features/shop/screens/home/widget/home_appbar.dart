import 'package:enyad_store_3/features/personalization/controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/shimmers/shimmer.dart';
import '../../../../../common/widgets/appbar/appBar.dart';
import '../../../../../common/widgets/products/cart/cart_menu_icon.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/text_strings.dart';

class SHomeAppBar extends StatelessWidget {
  const SHomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());
    return SAppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(SText.homeAppBarTitle,
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .apply(color: SColors.grey),
              maxLines: 2),
          Obx(() {
            if (controller.loadingProfile.value) {
              return const SShimmerEffect(width: 85, height: 15);
            } else {
              return Text(controller.user.value.fullName,
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .apply(color: SColors.white));
            }
          }),
        ],
      ),
      actions: const [
        SCartCounterIcon(
          iconColor: SColors.white,
        )
      ],
    );
  }
}
