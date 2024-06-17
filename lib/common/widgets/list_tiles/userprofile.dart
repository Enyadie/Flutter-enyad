import 'package:enyad_store_3/features/personalization/controller/user_controller.dart';
import 'package:enyad_store_3/features/personalization/screens/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/constants/sizes.dart';
import '../../shimmers/shimmer.dart';
import '../image/circular_image.dart';

class SUserProfileTile extends StatelessWidget {
  const SUserProfileTile({
    super.key,
    required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Padding(
      padding: const EdgeInsets.only(bottom: SSize.sm),
      child: ListTile(
        leading: Obx(() {
          final networkImage = controller.user.value.profilePicture;
          final image = networkImage.isNotEmpty ? networkImage : SImages.user;
          return GestureDetector(
            onTap: () => Get.to(() => const ProfileScreen()),
            child: controller.imageUploading.value
                ? const SShimmerEffect(
                    width: 50,
                    height: 50,
                    radius: 50,
                  )
                : SCircularImage(
                    isNetworkImage: networkImage.isNotEmpty,
                    fit: BoxFit.fill,
                    image: image,
                    width: 56,
                    height: 56,
                    padding: 0),
          );
        }),
        title: Text(controller.user.value.fullName,
            style: Theme.of(context)
                .textTheme
                .headlineSmall!
                .apply(color: SColors.white)),
        subtitle: Text(controller.user.value.email,
            style: Theme.of(context)
                .textTheme
                .labelSmall!
                .apply(color: SColors.white)),
        trailing: IconButton(
            onPressed: onPressed,
            icon: const Icon(Iconsax.edit, color: SColors.white)),
      ),
    );
  }
}
