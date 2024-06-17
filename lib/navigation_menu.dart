import 'package:enyad_store_3/features/personalization/screens/settings/profile_setting.dart';
import 'package:enyad_store_3/features/shop/screens/home/home.dart';
import 'package:enyad_store_3/features/shop/screens/wishlist/wishlist.dart';
import 'package:enyad_store_3/utils/constants/colors.dart';
import 'package:enyad_store_3/utils/helper/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'features/shop/screens/store/shop.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    final dark = SHelperFunction.isDarkMode(context);
    return Scaffold(
      bottomNavigationBar: Obx(
        /// use only to accommodate obs else error this is the observer
        () => NavigationBar(
          height: 65,
          elevation: 0,
          selectedIndex: controller.selectedIndex.value,

          ///to get rx int value
          onDestinationSelected: (index) =>
              controller.selectedIndex.value = index,
          backgroundColor: dark ? SColors.darkerPurple : SColors.light,
          indicatorColor: dark
              ? SColors.white.withOpacity(0.1)
              : SColors.black.withOpacity(0.1),

          destinations: const [
            NavigationDestination(
              selectedIcon: Icon(Iconsax.home5),
              icon: Icon(Iconsax.home4),
              label: 'Home',
            ),
            NavigationDestination(
              selectedIcon: Icon(Iconsax.shop5),
              icon: Icon(Iconsax.shop4),
              label: 'Shop',
            ),
            NavigationDestination(
              selectedIcon: Icon(Iconsax.heart5),
              icon: Icon(Iconsax.heart4),
              label: 'Wishlist',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.person_2_rounded),
              icon: Icon(Iconsax.user4),
              label: 'Profile',
            ),
          ],
        ),
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  ///obs (observer) = whats being observed by obx, make compatible with the stateless widget not to reduce speed of app to recreate screens

  final screens = [
    const HomeScreen(),
    const ShopScreen(),
    const WishListScreen(),
    const ProfileSettingScreen()
  ];
}
