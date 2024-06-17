import 'package:enyad_store_3/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:enyad_store_3/common/widgets/texts/section_heading.dart';
import 'package:enyad_store_3/data/services/network_manager.dart';
import 'package:enyad_store_3/features/personalization/models/address_model.dart';
import 'package:enyad_store_3/features/personalization/screens/address/add_new_address.dart';
import 'package:enyad_store_3/features/personalization/screens/address/widgets/single_address.dart';
import 'package:enyad_store_3/utils/constants/colors.dart';
import 'package:enyad_store_3/utils/constants/image_strings.dart';
import 'package:enyad_store_3/utils/constants/sizes.dart';
import 'package:enyad_store_3/utils/helper/cloud_helper_function.dart';
import 'package:enyad_store_3/utils/helper/helper_function.dart';
import 'package:enyad_store_3/utils/popups/full_screen_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/repositories/address/address_repository.dart';
import '../../../data/repositories/authentication/authen_repository.dart';
import '../../../utils/popups/loaders.dart';

class AddressController extends GetxController {
  static AddressController get instance => Get.find();

  final name = TextEditingController();
  final phoneNumber = TextEditingController();
  final street = TextEditingController();
  final postalCode = TextEditingController();
  final city = TextEditingController();
  final state = TextEditingController();
  final country = TextEditingController();
  GlobalKey<FormState> addressFormKey = GlobalKey<FormState>();

  RxBool refreshData = true.obs;
  final Rx<AddressModel> selectedAddress = AddressModel.empty().obs;
  final addressRepo = Get.put(AddressRepository());

  Future<List<AddressModel>> getUserAddresses() async {
    try {
      final addresses = await addressRepo.getUserAddress();
      selectedAddress.value = addresses.firstWhere(
          (element) => element.selectedAddress,
          orElse: () => AddressModel.empty());
      return addresses;
    } catch (e) {
      SLoaders.errorSnackBar(title: 'Address Not Found', message: e.toString());
      return [];
    }
  }

  Future selectAddress(AddressModel newSelectAddress) async {
    try {
      Get.defaultDialog(
          title: '',
          onWillPop: () async {
            return false;
          },
          barrierDismissible: false,
          backgroundColor: Colors.transparent,
          content: const CircularProgressIndicator());
      // clear the field
      if (selectedAddress.value.id.isNotEmpty) {
        await addressRepo.updateSelectedField(selectedAddress.value.id, false);
      }

      // assign selected
      newSelectAddress.selectedAddress = true;
      selectedAddress.value = newSelectAddress;

      // set the selected field
      await addressRepo.updateSelectedField(selectedAddress.value.id, true);
      Get.back();
    } catch (e) {
      SLoaders.errorSnackBar(title: 'Selection Error!', message: e.toString());
    }
  }

  Future selectNewAddressPopup(BuildContext context) async {
    return showModalBottomSheet(
      context: context,
      builder: (_) => SRoundedContainer(
        backgroundColor: SHelperFunction.isDarkMode(context)
            ? SColors.darkerPurple
            : SColors.purple,
        showBorder: true,
        padding: const EdgeInsets.all(SSize.lg),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SSectionHeading(
                  showActionButton: false, title: 'Select Address'),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: SSize.lg),
                child: FutureBuilder(
                    future: getUserAddresses(),
                    builder: (_, snapshot) {
                      final response =
                          SCloudHelperFunction.checkMultipleRecordState(
                              showShimmer: false, snapshot: snapshot);
                      if (response != null) return response;

                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (_, index) => SSingleAddress(
                          address: snapshot.data![index],
                          onTap: () async {
                            await selectedAddress(snapshot.data![index]);
                            Get.back();
                          },
                        ),
                      );
                    }),
              ),
              const SizedBox(height: SSize.defautSpace * 2),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () => Get.to(() => const AddNewAddressScreen()),
                    child: const Text('Add new address')),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future addNewAddress() async {
    try {
      SFullScreenLoader.openLoadingDialog(
          'Saving Address', SImages.dockerAnimation);

      final isConnected = await NetworkManager.instance.isConnected();

      if (!isConnected) {
        SFullScreenLoader.stopLoading();
        return;
      }

      if (!addressFormKey.currentState!.validate()) {
        SFullScreenLoader.stopLoading();
        return;
      }

      final address = AddressModel(
          name: name.text.trim(),
          id: '',
          phoneNumber: phoneNumber.text.trim(),
          state: state.text.trim(),
          city: city.text.trim(),
          country: country.text.trim(),
          street: street.text.trim(),
          selectedAddress: true,
          dateTime: DateTime.now(),
          postalCode: postalCode.text.toString());

      final id = await addressRepo.saveAddress(address);

      ///update selected address status
      address.id = id;
      selectedAddress(address);

      SFullScreenLoader.stopLoading();
      SLoaders.successSnackBar(
          title: 'Success!', message: 'Your address have been updated.');

      refreshData.toggle();

      resetFormField();

      Navigator.of(Get.context!).pop();
    } catch (e) {
      SFullScreenLoader.stopLoading();
      SLoaders.errorSnackBar(
          title: 'Address Not Found!', message: e.toString());
    }
  }

  Future<void> deleteAddress(AddressModel address) async {
    try {
      SFullScreenLoader.openLoadingDialog(
          'Deleting Address', SImages.dockerAnimation);

      final isConnected = await NetworkManager.instance.isConnected();

      if (!isConnected) {
        SFullScreenLoader.stopLoading();
        return;
      }

      await addressRepo.deleteUserAddress(
          AuthenticationRepository.instance.authUser!.uid, address.id);

      if (address.selectedAddress) {
        selectedAddress(AddressModel.empty());
      }

      SFullScreenLoader.stopLoading();
      SLoaders.successSnackBar(
          title: 'Success!', message: 'Address deleted successfully.');

      refreshData.toggle();
    } catch (e) {
      SFullScreenLoader.stopLoading();
      SLoaders.errorSnackBar(
          title: 'Delete Error!', message: 'Failed to delete address.');
    }
  }

  void resetFormField() {
    name.clear();
    phoneNumber.clear();
    street.clear();
    postalCode.clear();
    city.clear();
    state.clear();
    country.clear();
    addressFormKey.currentState?.reset();
  }
}
