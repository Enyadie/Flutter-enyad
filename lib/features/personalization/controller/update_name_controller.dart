import 'package:enyad_store_3/data/repositories/user/user_repository.dart';
import 'package:enyad_store_3/data/services/network_manager.dart';
import 'package:enyad_store_3/features/personalization/controller/user_controller.dart';
import 'package:enyad_store_3/features/personalization/screens/profile/profile.dart';
import 'package:enyad_store_3/utils/constants/image_strings.dart';
import 'package:enyad_store_3/utils/popups/full_screen_loader.dart';
import 'package:enyad_store_3/utils/popups/loaders.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class UpdateNameController extends GetxController {
  static UpdateNameController get instance => Get.find();

  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final userController = UserController.instance;
  final userRepository = Get.put(UserRepository());

  GlobalKey<FormState> updateFirstAndLastNameFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    initializeNames();
    super.onInit();
  }

  ///get data
  Future<void> initializeNames() async {
    firstName.text = userController.user.value.firstName;
    lastName.text = userController.user.value.lastName;
  }

  Future<void> updateFirstAndLastName() async {
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

      if (!updateFirstAndLastNameFormKey.currentState!.validate()) {
        SFullScreenLoader.stopLoading();
        return;
      }

      Map<String, dynamic> name = {
        'FirstName': firstName.text.trim(),
        'LastName': lastName.text.trim()
      };
      await userRepository.updateSingleField(name);

      userController.user.value.firstName = firstName.text.trim();
      userController.user.value.lastName = lastName.text.trim();

      SFullScreenLoader.stopLoading();

      SLoaders.successSnackBar(
          title: 'Congratulations', message: "Name updated successfully.");

      Get.offAll(() => const ProfileScreen());
    } catch (e) {
      SFullScreenLoader.stopLoading();
      SLoaders.errorSnackBar(title: 'Oh No!', message: 'Update name failed.');
    }
  }
}
