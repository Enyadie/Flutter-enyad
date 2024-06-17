import 'package:enyad_store_3/common/shimmers/shimmer.dart';
import 'package:enyad_store_3/common/widgets/appbar/appBar.dart';
import 'package:enyad_store_3/common/widgets/image/circular_image.dart';
import 'package:enyad_store_3/common/widgets/texts/section_heading.dart';
import 'package:enyad_store_3/features/personalization/controller/gender_selection.dart';
import 'package:enyad_store_3/features/personalization/screens/profile/widgets/change_phone_number.dart';
import 'package:enyad_store_3/features/personalization/screens/profile/widgets/change_username.dart';
import 'package:enyad_store_3/features/personalization/screens/profile/widgets/profile_menu.dart';
import 'package:enyad_store_3/utils/constants/colors.dart';
import 'package:enyad_store_3/utils/constants/image_strings.dart';
import 'package:enyad_store_3/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/helper/copy_to_clipboard.dart';
import '../../controller/user_controller.dart';
import 'widgets/change_name.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GenderSelectionController genderController =
        Get.put(GenderSelectionController());
    final CopyToClipboardController copyToClipboardController =
        Get.put(CopyToClipboardController());
    final controller = UserController.instance;
    return Scaffold(
      appBar: const SAppBar(
        showBackground: false,
        showBackButton: true,
        title: Text('Profile'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
              left: SSize.defautSpace,
              right: SSize.defautSpace,
              bottom: SSize.defautSpace),
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    Obx(
                      () {
                        final networkImage =
                            controller.user.value.profilePicture;
                        final image = networkImage.isNotEmpty
                            ? networkImage
                            : SImages.user;
                        return GestureDetector(
                          onTap: () => controller.uploadUserProfileImage(),
                          child: controller.imageUploading.value
                              ? const SShimmerEffect(
                                  width: 100,
                                  height: 100,
                                  radius: 100,
                                )
                              : SCircularImage(
                                  isNetworkImage: networkImage.isNotEmpty,
                                  image: image,
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.fill),
                        );
                      },
                    ),
                    TextButton(
                        onPressed: () => controller.uploadUserProfileImage(),
                        child: const Text('Change Profile Picture'))
                  ],
                ),
              ),
              const SizedBox(height: SSize.spaceBtwItems / 2),
              const Divider(),
              const SizedBox(height: SSize.spaceBtwItems),
              const SSectionHeading(
                  title: 'Profile Information', showActionButton: false),
              const SizedBox(height: SSize.spaceBtwItems),
              SProfileMenu(
                  onPressed: () => Get.to(() => const ChangeName()),
                  title: 'Name:',
                  value: controller.user.value.fullName),
              const SizedBox(height: SSize.spaceBtwItems / 2),
              SProfileMenu(
                  onPressed: () => Get.to(() => const ChangeUsername()),
                  title: 'Username:',
                  value: controller.user.value.username),
              const SizedBox(height: SSize.spaceBtwItems / 2),
              const Divider(),
              const SizedBox(height: SSize.spaceBtwItems),
              const SSectionHeading(
                  title: 'Personal Information', showActionButton: false),
              const SizedBox(height: SSize.spaceBtwItems),
              SProfileMenu(
                onPressed: () => copyToClipboardController
                    .copyToClipboard(controller.user.value.id),
                title: 'User ID:',
                value: controller.user.value.id,
                icon: Iconsax.copy,
              ),
              SProfileMenu(
                  icon: Iconsax.copy,
                  onPressed: () => copyToClipboardController
                      .copyToClipboard(controller.user.value.email),
                  title: 'E-Mail:',
                  value: controller.user.value.email),
              SProfileMenu(
                  onPressed: () => Get.to(() => const ChangePhoneNumber()),
                  title: 'Phone #:',
                  value: controller.user.value.phoneNumber),
              SProfileMenu(
                  onPressed: () =>
                      genderController.showGenderSelectionDialog(context),
                  title: 'Gender:',
                  value: 'Male'),
              SProfileMenu(
                  onPressed: () {},
                  title: 'Date of Birth:',
                  value: '18 Sept,1994'),
              const Divider(),
              const SizedBox(height: SSize.spaceBtwItems),
              Center(
                child: TextButton(
                    onPressed: () => controller.deleteAccountWarningPopUp(),
                    child: const Text(
                      'Delete Account',
                      style: TextStyle(color: SColors.red),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
