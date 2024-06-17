import 'package:enyad_store_3/data/repositories/authentication/authen_repository.dart';
import 'package:enyad_store_3/data/services/network_manager.dart';
import 'package:enyad_store_3/features/authentication/models/user_model.dart';
import 'package:enyad_store_3/features/authentication/screens/login/login.dart';
import 'package:enyad_store_3/utils/constants/image_strings.dart';
import 'package:enyad_store_3/utils/constants/sizes.dart';
import 'package:enyad_store_3/utils/popups/full_screen_loader.dart';
import 'package:enyad_store_3/utils/popups/loaders.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../data/repositories/user/user_repository.dart';
import '../screens/profile/widgets/re_authenticate_user_login.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  final loadingProfile = false.obs;
  final imageUploading = false.obs;
  final userRepository = Get.put(UserRepository());
  Rx<UserModel> user = UserModel.empty().obs;

  final hidePassword = false.obs;
  final verifyEmail = TextEditingController();
  final verifyPassword = TextEditingController();
  final verifyRepository = Get.put(UserRepository());

  GlobalKey<FormState> reAuthFormKey = GlobalKey<FormState>();

  ///any change it rewrite the user data

  @override
  void onInit() {
    super.onInit();
    getUserData();
  }

  ///get user data
  Future<void> getUserData() async {
    try {
      loadingProfile.value = true;
      final user = await userRepository.getUserDetails();
      this.user(user);
    } catch (e) {
      user(UserModel.empty());
    } finally {
      loadingProfile.value = false;
    }
  }

  ///save user record form any registration platform
  Future<void> saverUserRecord(UserCredential? userCredentials) async {
    try {
      ///refresh user record if its not stored
      await getUserData();

      ///if there is no user record stored
      if (user.value.id.isEmpty) {
        if (userCredentials != null) {
          ///separate display name first and last
          final nameParts =
              UserModel.nameParts(userCredentials.user!.displayName ?? '');
          final username = UserModel.generateUserName(
              userCredentials.user!.displayName ?? '');

          ///map the data
          final user = UserModel(
            id: userCredentials.user!.uid,
            firstName: nameParts[0],
            lastName:
                nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '',
            username: username,
            email: userCredentials.user!.email ?? '',
            phoneNumber: userCredentials.user!.phoneNumber ?? '',
            profilePicture: userCredentials.user!.photoURL ?? '',
          );

          ///save the data
          await userRepository.saveUserData(user);
        }
      }
    } catch (e) {
      SLoaders.errorSnackBar(
          title: 'Data not saved',
          message:
              'Something went wrong while saving your information. Please try again in your Profile.');
    }
  }

  void deleteAccountWarningPopUp() {
    Get.defaultDialog(
      contentPadding: const EdgeInsets.all(SSize.md),
      title: 'Delete Account',
      middleText:
          'Are you sure you want to delete your account? This action is irreversible and all your account details will be lost.',
      confirm: ElevatedButton(
        onPressed: () => deleteAccount(),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          side: const BorderSide(color: Colors.red),
        ),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: SSize.lg),
          child: Text('Delete'),
        ),
      ),
      cancel: OutlinedButton(
        onPressed: () => navigator?.pop(Get.overlayContext!),
        child: const Text('Cancel'),
      ),
    );
  }

  void deleteAccount() async {
    try {
      SFullScreenLoader.openLoadingDialog('Process', SImages.dockerAnimation);

      final auth = AuthenticationRepository.instance;
      final provider =
          auth.authUser!.providerData.map((e) => e.providerId).first;

      if (provider.isNotEmpty) {
        if (provider == 'google.com') {
          await auth.screenRedirect();
          await auth.deleteAccount();

          SFullScreenLoader.stopLoading();
          Get.offAll(() => const LoginScreen());
        } else if (provider == 'password') {
          SFullScreenLoader.stopLoading();
          Get.to(() => const ReAuthUserLogin());
        }
      }
    } catch (e) {
      SFullScreenLoader.stopLoading();
      SLoaders.errorSnackBar(
          title: 'Oh No!',
          message: 'Delete account failed. Please try again...');
    }
  }

  Future<void> reAuthenticateUserEmailAndPassword() async {
    try {
      SFullScreenLoader.openLoadingDialog(
          'Processing', SImages.dockerAnimation);

      final isConnected = await NetworkManager.instance.isConnected();

      if (!isConnected) {
        SFullScreenLoader.stopLoading();
        return;
      }

      if (!reAuthFormKey.currentState!.validate()) {
        SFullScreenLoader.stopLoading();
        return;
      }

      await AuthenticationRepository.instance
          .reAuthenticateWithEmailAndPassword(
              verifyEmail.text.trim(), verifyPassword.text.trim());
      await AuthenticationRepository.instance.deleteAccount();
      SFullScreenLoader.stopLoading();
      Get.offAll(() => const LoginScreen());
    } catch (e) {
      SFullScreenLoader.stopLoading();
      SLoaders.errorSnackBar(
          title: 'Oh No!', message: 'Check internet. Please try again...');
    }
  }

  ///upload profile image
  uploadUserProfileImage() async {
    try {
      final image = await ImagePicker().pickImage(
          source: ImageSource.gallery,
          imageQuality: 80,
          maxHeight: 512,
          maxWidth: 512);
      if (image != null) {
        imageUploading.value = true;
        final imageUrl =
            await UserRepository().uploadImage('Users/Images/Profile', image);

        Map<String, dynamic> json = {'ProfilePicture': imageUrl};

        await UserRepository().updateSingleField(json);

        user.value.profilePicture = imageUrl;
        user.refresh();
        SLoaders.successSnackBar(
            title: 'Congratulations',
            message: 'Your profile picture has been successfully updated!');
      }
    } catch (e) {
      SLoaders.errorSnackBar(
          title: 'Oh No!',
          message: 'Something went wrong. Please try again...');
    } finally {
      imageUploading.value = false;
    }
  }
}
