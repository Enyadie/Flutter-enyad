import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../screens/login/login.dart';

class OnBoardingController extends GetxController {
  static OnBoardingController get instance => Get.find();
  final storage = GetStorage();

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  final pageController = PageController();
  RxInt currentPageIndex =
      0.obs; //obs (observer) change design without using stateful widgets.

  void updatePackageIndicator(index) => currentPageIndex.value = index;

  void dotNavigationClick(index) {
    currentPageIndex.value = index;
    pageController.jumpTo(index);
  }

  void nextPage() {
    if (currentPageIndex.value == 2) {
      // if (kDebugMode) {
      //   print('----------Skip Button------------');
      //   print(storage.read('IsFirstRun'));
      // }
      storage.write('IsFirstRun', false);
      Get.to(() => const LoginScreen());
      // if (kDebugMode) {
      //   print('----------login------------');
      //   print(storage.read('IsFirstRun'));
      // }

      ///free memory and go to page
    } else {
      int page = currentPageIndex.value + 1;
      pageController.jumpToPage(page);
    }
  }

  void skipPage() {
    storage.write('IsFirstRun', false);
    Get.to(() => const LoginScreen());
    // currentPageIndex.value = 2;
    // pageController.jumpToPage(2);
  }
}
