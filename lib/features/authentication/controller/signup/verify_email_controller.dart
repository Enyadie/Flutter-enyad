import 'dart:async';

import 'package:enyad_store_3/common/widgets/success_screen/success_screen.dart';
import 'package:enyad_store_3/data/repositories/authentication/authen_repository.dart';
import 'package:enyad_store_3/utils/constants/image_strings.dart';
import 'package:enyad_store_3/utils/constants/text_strings.dart';
import 'package:enyad_store_3/utils/popups/loaders.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class VerifyEmailController extends GetxController {
  static VerifyEmailController get instance => Get.find();

  ///send email when verify screen appear and set timer to auto redirect.
  @override
  void onInit() {
    autoRedirectTimer();
    sendEmailVerification();
    super.onInit();
  }

  ///send email
  sendEmailVerification() async {
    try {
      await AuthenticationRepository.instance.sendEmailVerification();
      SLoaders.successSnackBar(
          title: 'Email Sent',
          message: 'Please check your inbox to verify your email.');
    } catch (e) {
      SLoaders.errorSnackBar(
          title: 'Oh No!', message: 'Something went wrong. Please try again.');
    }
  }

  ///verification timer
  autoRedirectTimer() {
    Timer.periodic(const Duration(seconds: 1), (timer) async {
      await FirebaseAuth.instance.currentUser?.reload();
      final user = FirebaseAuth.instance.currentUser;
      if (user?.emailVerified ?? false) {
        timer.cancel();
        Get.off(
          () => SuccessScreen(
            title: SText.accountCreated,
            subTitle: SText.accountCreatedSubTitle,
            image: SImages.successIllustration,
            onPressed: () => AuthenticationRepository.instance.screenRedirect(),
          ),
        );
      }
    });
  }

  ///manually check if the email is verified
  checkVerificationStatus() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null && currentUser.emailVerified) {
      Get.off(
        () => SuccessScreen(
          title: SText.accountCreated,
          subTitle: SText.accountCreatedSubTitle,
          image: SImages.successIllustration,
          onPressed: () => AuthenticationRepository.instance.screenRedirect(),
        ),
      );
    }
  }
}
