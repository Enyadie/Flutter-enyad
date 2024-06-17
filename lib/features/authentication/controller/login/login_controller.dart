import 'package:enyad_store_3/data/repositories/authentication/authen_repository.dart';
import 'package:enyad_store_3/data/services/network_manager.dart';
import 'package:enyad_store_3/features/personalization/controller/user_controller.dart';
import 'package:enyad_store_3/utils/constants/image_strings.dart';
import 'package:enyad_store_3/utils/popups/full_screen_loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../utils/popups/loaders.dart';

class LoginController extends GetxController {
  static RxBool rememberMe = false.obs;
  final hidePassword = true.obs;
  final localStorage = GetStorage();
  final email = TextEditingController();
  final password = TextEditingController();

  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final userController = Get.put(UserController());

  @override
  void onInit() {
    super.onInit();
    email.text = localStorage.read('REMEMBER_ME_EMAIL') ?? '';
    password.text = localStorage.read('REMEMBER_ME_PASSWORD') ?? '';
  }

  ///password email login
  Future<void> emailAndPasswordSignIn() async {
    try {
      SFullScreenLoader.openLoadingDialog(
          'Logging you in...', SImages.dockerAnimation);

      ///check internet
      final isConnected = await NetworkManager.instance.isConnected();

      if (!isConnected) {
        SFullScreenLoader.stopLoading();
        return;
      }

      if (!loginFormKey.currentState!.validate()) {
        SFullScreenLoader.stopLoading();
        return;
      }

      if (rememberMe.value) {
        rememberMe = true.obs;
        localStorage.write('REMEMBER_ME_EMAIL', email.text.trim());
        localStorage.write('REMEMBER_ME_PASSWORD', password.text.trim());
      } else {
        localStorage.write('REMEMBER_ME_EMAIL', '');
        localStorage.write('REMEMBER_ME_PASSWORD', '');
        rememberMe = false.obs;
      }

      final userCredentials = await AuthenticationRepository.instance
          .loginWithEmailAndPassword(email.text.trim(), password.text.trim());

      SFullScreenLoader.stopLoading();

      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      SFullScreenLoader.stopLoading();
    }
  }

  ///google login
  Future<void> googleSignIn() async {
    try {
      ///check internet using custom net manager
      SFullScreenLoader.openLoadingDialog(
          'Logging you in...', SImages.dockerAnimation);

      final isConnected = await NetworkManager.instance.isConnected();

      if (!isConnected) {
        SFullScreenLoader.stopLoading();
        return;
      }

      ///Google Authentication
      final userCredentials =
          await AuthenticationRepository.instance.signInWithGoogle();

      ///save user records
      await userController.saverUserRecord(userCredentials);

      SFullScreenLoader.stopLoading();

      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      SFullScreenLoader.stopLoading();
      SLoaders.errorSnackBar(title: 'Oh No', message: e.toString());
    }
  }
}
