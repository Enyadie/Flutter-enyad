import 'package:enyad_store_3/common/widgets/appbar/appBar.dart';
import 'package:enyad_store_3/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:enyad_store_3/common/widgets/list_tiles/settings_menu.dart';
import 'package:enyad_store_3/features/personalization/screens/address/address.dart';
import 'package:enyad_store_3/features/shop/screens/cart/cart.dart';
import 'package:enyad_store_3/features/shop/screens/order/order.dart';
import 'package:enyad_store_3/utils/constants/colors.dart';
import 'package:enyad_store_3/utils/helper/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/list_tiles/userprofile.dart';
import '../../../../data/repositories/authentication/authen_repository.dart';
import '../../../../uploadoptions.dart';
import '../../../../utils/constants/sizes.dart';
import '../../controller/user_controller.dart';
import '../profile/profile.dart';

class ProfileSettingScreen extends StatelessWidget {
  const ProfileSettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    final dark = SHelperFunction.isDarkMode(context);
    return Scaffold(
      backgroundColor: dark ? SColors.darkerPurple : SColors.purple,
      drawer: Drawer(
        backgroundColor: dark ? SColors.darkerPurple : SColors.purple,
        child: ListView(
          children: [
            Center(
              child: DrawerHeader(
                child: Text(
                  'App Settings',
                  style: Theme.of(context).textTheme.headlineMedium!.apply(
                        color: dark ? SColors.grey : SColors.lightGrey,
                      ),
                ),
              ),
            ),
            SSettingMenuTile(
              icon: Iconsax.document_upload,
              title: 'Load Data',
              subTitle: 'Upload to Cloud Storage',
              onTap: () => Get.to(() => const UploadOptionsScreen()),
            ),
            const SizedBox(
              height: SSize.spaceBtwSections,
            ),
            SSettingMenuTile(
              icon: Iconsax.location,
              title: 'Location',
              subTitle: 'Set current location',
              trailing: Switch(value: false, onChanged: (value) {}),
              onTap: () {},
            ),
            const SizedBox(
              height: SSize.spaceBtwSections,
            ),
            SSettingMenuTile(
              icon: Iconsax.sms_notification,
              title: 'Notifications',
              subTitle: 'Turn on post notifications',
              trailing: Switch(value: false, onChanged: (value) {}),
              onTap: () {},
            ),
            const SizedBox(
              height: SSize.spaceBtwSections,
            ),
            SSettingMenuTile(
              icon: Iconsax.security_user,
              title: 'Safe Mode',
              subTitle: 'Parental search',
              trailing: Switch(value: false, onChanged: (value) {}),
              onTap: () {},
            ),
            const SizedBox(
              height: SSize.spaceBtwSections,
            ),
            SSettingMenuTile(
              icon: Iconsax.image,
              title: 'Image Quality',
              subTitle: 'Improves image quality',
              trailing: Switch(value: false, onChanged: (value) {}),
              onTap: () {},
            ),
          ],
        ),
      ),
      body: Builder(
        builder: (context) => SingleChildScrollView(
          child: Column(
            children: [
              ///---header---
              Column(
                children: [
                  ///---appBar---
                  SAppBar(
                    title: Text('Account',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .apply(color: SColors.white)),
                    showBackground: false,
                  ),

                  ///---profile---
                  SRoundedContainer(
                    backgroundColor: Colors.transparent,
                    showBorder: true,
                    child: SUserProfileTile(
                        onPressed: () => Get.to(() => const ProfileScreen())),
                  ),
                ],
              ),

              ///---body---
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: SSize.defautSpace),
                child: Column(
                  children: [
                    SAppBar(
                      title: Text(
                        'App Settings',
                        style: TextStyle(
                            color: dark ? SColors.grey : SColors.lightGrey),
                      ),
                      showBackButton: false,
                      showBackground: false,
                      actions: [
                        IconButton(
                          icon: Icon(
                            Icons.settings,
                            color: dark ? SColors.grey : SColors.lightGrey,
                          ),
                          onPressed: () => Scaffold.of(context).openDrawer(),
                        ),
                      ],
                    ),

                    ///---app setting---
                    SAppBar(
                      title: Text('Account Settings',
                          style: TextStyle(
                              color: dark ? SColors.grey : SColors.lightGrey)),
                      showBackButton: false,
                      showBackground: false,
                    ),
                    SSettingMenuTile(
                      icon: Iconsax.safe_home,
                      title: 'My Address',
                      subTitle: 'Set delivery address',
                      onTap: () => Get.to(() => const UserAddressScreen()),
                    ),
                    SSettingMenuTile(
                      icon: Iconsax.shopping_cart,
                      title: 'My Cart',
                      subTitle: 'View products for checkout',
                      onTap: () => Get.to(() => const CartScreen()),
                    ),
                    SSettingMenuTile(
                      icon: Iconsax.bag_tick,
                      title: 'My Orders',
                      subTitle: 'Ordered products',
                      onTap: () => Get.to(() => const OrderScreen()),
                    ),
                    SSettingMenuTile(
                      icon: Iconsax.card_add,
                      title: 'Payment Details',
                      subTitle: 'Add your payment details',
                      onTap: () {},
                    ),
                    SSettingMenuTile(
                      icon: Iconsax.ticket_discount,
                      title: 'My Coupons',
                      subTitle: 'List of all discount coupons',
                      onTap: () {},
                    ),
                    SSettingMenuTile(
                      icon: Iconsax.notification,
                      title: 'Notifications',
                      subTitle: 'Set Reminders',
                      onTap: () {},
                    ),
                    SSettingMenuTile(
                      icon: Iconsax.security,
                      title: 'Account Privacy',
                      subTitle: 'Manage your data usage and connected accounts',
                      onTap: () {},
                    ),
                    const SizedBox(height: SSize.spaceBtwSections),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                          onPressed: () =>
                              AuthenticationRepository.instance.logout(),
                          child: Text('LogOut',
                              style: TextStyle(
                                  color: dark
                                      ? SColors.grey
                                      : SColors.lightGrey))),
                    ),
                    const SizedBox(height: SSize.spaceBtwSections * 2.5),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
