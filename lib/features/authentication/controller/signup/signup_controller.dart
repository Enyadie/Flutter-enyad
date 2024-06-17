import 'package:enyad_store_3/data/repositories/authentication/authen_repository.dart';
import 'package:enyad_store_3/data/repositories/user/user_repository.dart';
import 'package:enyad_store_3/features/authentication/screens/signup/verify_email.dart';
import 'package:enyad_store_3/utils/constants/image_strings.dart';
import 'package:enyad_store_3/utils/popups/full_screen_loader.dart';
import 'package:enyad_store_3/utils/popups/loaders.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../data/services/network_manager.dart';
import '../../models/user_model.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  ///to save memory don't have to recreate

  final hidePassword = true.obs;
  final privacyChecked = false.obs;
  final email = TextEditingController();
  final lastName = TextEditingController();
  final firstName = TextEditingController();
  final username = TextEditingController();
  final password = TextEditingController();
  final phoneNumber = TextEditingController();
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  ///key from validation

  void signup() async {
    try {
      ///start loading
      SFullScreenLoader.openLoadingDialog(
          'Processing your information,it will take some time...',
          SImages.dockerAnimation);

      ///check internet
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        SFullScreenLoader.stopLoading();
        return;
      }

      ///validation
      if (!signupFormKey.currentState!.validate()) {
        SFullScreenLoader.stopLoading();
        return;
      }

      ///privacy policy check
      if (!privacyChecked.value) {
        SLoaders.warningSnackBar(
          title: 'Accept Privacy Policy',
          message:
              'In order to create an account, you must read and accept the Privacy Policy & Terms of Use.',
        );
        return;
      }

      ///register user to firebase
      final userDetail = await AuthenticationRepository.instance
          .registerEmailAndPassword(email.text.trim(), password.text.trim());

      /// save authenticated user data to firebase
      final newUser = UserModel(
        id: userDetail.user!.uid,
        firstName: firstName.text.trim(),
        lastName: lastName.text.trim(),
        username: username.text.trim(),
        email: email.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        profilePicture: '',
      );
      final userRepository = Get.put(UserRepository());
      await userRepository.saveUserData(newUser);

      SFullScreenLoader.stopLoading();

      ///success message
      SLoaders.successSnackBar(
          title: 'Congratulations',
          message:
              'Your profile has been created! Verify your email to continue.');

      ///verify screen
      Get.to(() => VerifyEmailScreen(email: email.text.trim()));
    } catch (e) {
      SFullScreenLoader.stopLoading();
      SLoaders.errorSnackBar(
          title: 'Oh No!', message: 'Something went wrong. Please try again.');
    }
  }
}
