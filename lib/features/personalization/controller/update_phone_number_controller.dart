import 'package:enyad_store_3/data/repositories/user/user_repository.dart';
import 'package:enyad_store_3/data/services/network_manager.dart';
import 'package:enyad_store_3/features/personalization/controller/user_controller.dart';
import 'package:enyad_store_3/features/personalization/screens/profile/profile.dart';
import 'package:enyad_store_3/utils/constants/image_strings.dart';
import 'package:enyad_store_3/utils/popups/full_screen_loader.dart';
import 'package:enyad_store_3/utils/popups/loaders.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../authentication/models/user_model.dart';

class UpdatePhoneNumberController extends GetxController {
  static UpdatePhoneNumberController get instance => Get.find();

  final phoneNumber = TextEditingController();
  final userController = UserController.instance;
  final userRepository = Get.put(UserRepository());

  GlobalKey<FormState> updatePhoneNumberFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    initializePhone();
    super.onInit();
  }

  ///get data
  Future<void> initializePhone() async {
    phoneNumber.text = userController.user.value.phoneNumber;
  }

  Future<void> updatePhoneNumber() async {
    try {
      SFullScreenLoader.openLoadingDialog(
          'Updating, Please Wait...', SImages.dockerAnimation);

      final isConnected = await NetworkManager.instance.isConnected();

      if (!isConnected) {
        SFullScreenLoader.stopLoading();
        SLoaders.errorSnackBar(
            title: 'No Internet Connection',
            message: 'Please check your connection and try again.');
        return;
      }

      if (!updatePhoneNumberFormKey.currentState!.validate()) {
        SFullScreenLoader.stopLoading();
        return;
      }

      final userDoc = await userRepository.getUserDetails();
      final currentPhoneNumber = userDoc.phoneNumber;

      if (currentPhoneNumber.isEmpty) {
        // Save the new user data with the new phone number
        final updatedUser = UserModel(
          id: userDoc.id,
          firstName: userDoc.firstName,
          email: userDoc.email,
          phoneNumber: phoneNumber.text.trim(),
          lastName: userDoc.lastName,
          username: userDoc.username,
          profilePicture: userDoc.profilePicture,
          // Add other fields from userDoc
        );
        await userRepository.saveUserData(updatedUser);
      } else {
        // Update the phone number
        Map<String, dynamic> phone = {'PhoneNumber': phoneNumber.text.trim()};
        await userRepository.updateSingleField(phone);
      }

      userController.user.value.phoneNumber = phoneNumber.text.trim();

      SFullScreenLoader.stopLoading();

      SLoaders.successSnackBar(
          title: 'Congratulations',
          message: "Phone Number updated successfully.");

      Get.offAll(() => const ProfileScreen());
    } catch (e) {
      SFullScreenLoader.stopLoading();
      SLoaders.errorSnackBar(
          title: 'Oh No!', message: 'Phone Number Update failed.');
    }
  }
}
