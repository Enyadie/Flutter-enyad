import 'package:enyad_store_3/data/repositories/user/user_repository.dart';
import 'package:enyad_store_3/data/services/network_manager.dart';
import 'package:enyad_store_3/features/personalization/controller/user_controller.dart';
import 'package:enyad_store_3/features/personalization/screens/profile/profile.dart';
import 'package:enyad_store_3/utils/constants/image_strings.dart';
import 'package:enyad_store_3/utils/popups/full_screen_loader.dart';
import 'package:enyad_store_3/utils/popups/loaders.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class UpdateUsernameController extends GetxController {
  static UpdateUsernameController get instance => Get.find();

  final username = TextEditingController();
  final userController = UserController.instance;
  final userRepository = Get.put(UserRepository());

  GlobalKey<FormState> updateUsernameFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    initializeUsernames();
    super.onInit();
  }

  ///get data
  Future<void> initializeUsernames() async {
    username.text = userController.user.value.username;
  }

  Future<void> updateUsername() async {
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

      if (!updateUsernameFormKey.currentState!.validate()) {
        SFullScreenLoader.stopLoading();
        return;
      }

      Map<String, dynamic> userName = {
        'Username': username.text.trim(),
      };
      await userRepository.updateSingleField(userName);

      userController.user.value.firstName = username.text.trim();

      SFullScreenLoader.stopLoading();

      SLoaders.successSnackBar(
          title: 'Congratulations', message: "Username updated successfully.");

      Get.offAll(() => const ProfileScreen());
    } catch (e) {
      SFullScreenLoader.stopLoading();
      SLoaders.errorSnackBar(title: 'Oh No!', message: 'Update name failed.');
    }
  }
}
