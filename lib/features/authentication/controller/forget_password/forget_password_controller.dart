import 'package:enyad_store_3/data/repositories/authentication/authen_repository.dart';
import 'package:enyad_store_3/features/authentication/screens/passwordconfig/resetpassword.dart';
import 'package:enyad_store_3/utils/constants/image_strings.dart';
import 'package:enyad_store_3/utils/popups/full_screen_loader.dart';
import 'package:enyad_store_3/utils/popups/loaders.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../data/services/network_manager.dart';

class ForgetPasswordController extends GetxController {
  static ForgetPasswordController get instance => Get.find();

  final email = TextEditingController();

  GlobalKey<FormState> forgetPasswordFormKey = GlobalKey<FormState>();

  sendPasswordResetEmail() async {
    try {
      SFullScreenLoader.openLoadingDialog(
          'Processing...', SImages.dockerAnimation);

      final isConnected = await NetworkManager.instance.isConnected();

      if (!isConnected) {
        SFullScreenLoader.stopLoading();
        return;
      }
      if (!forgetPasswordFormKey.currentState!.validate()) {
        SFullScreenLoader.stopLoading();
        return;
      }

      await AuthenticationRepository.instance
          .sendResetPasswordEmail(email.text.trim());
      SFullScreenLoader.stopLoading();

      SLoaders.successSnackBar(
          title: 'Email Sent', message: 'Reset Password link Sent');
      Get.to(() => ResetPasswordScreen(email: email.text.trim()));
    } catch (e) {
      SFullScreenLoader.stopLoading();
      SLoaders.errorSnackBar(title: 'Oh No', message: e.toString());
    }
  }

  resendPasswordResetEmail(String email) async {
    try {
      SFullScreenLoader.openLoadingDialog(
          'Processing...', SImages.dockerAnimation);

      final isConnected = await NetworkManager.instance.isConnected();

      if (!isConnected) {
        SFullScreenLoader.stopLoading();
        return;
      }

      await AuthenticationRepository.instance.sendResetPasswordEmail(email);
      SFullScreenLoader.stopLoading();

      SLoaders.successSnackBar(
          title: 'Email Sent', message: 'Reset Password link Sent');
    } catch (e) {
      SFullScreenLoader.stopLoading();
      SLoaders.errorSnackBar(title: 'Oh No', message: e.toString());
    }
  }
}
