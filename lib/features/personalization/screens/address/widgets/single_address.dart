import 'package:enyad_store_3/features/personalization/controller/address_controller.dart';
import 'package:enyad_store_3/features/personalization/models/address_model.dart';
import 'package:enyad_store_3/utils/constants/colors.dart';
import 'package:enyad_store_3/utils/constants/sizes.dart';
import 'package:enyad_store_3/utils/helper/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/widgets/custom_shapes/containers/circular_container.dart';

class SSingleAddress extends StatelessWidget {
  const SSingleAddress({super.key, required this.address, required this.onTap});

  final AddressModel address;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final controller = AddressController.instance;
    final dark = SHelperFunction.isDarkMode(context);
    return Obx(() {
      final selectedAddressId = controller.selectedAddress.value.id;
      final selectedAddress = selectedAddressId == address.id;

      return InkWell(
        onTap: onTap,
        onLongPress: () => Get.defaultDialog(
          contentPadding: const EdgeInsets.all(SSize.md),
          title: 'Delete Address',
          middleText: 'Are you sure you want to delete this address?',
          confirm: ElevatedButton(
            onPressed: () => {
              controller.deleteAddress(address),
              Navigator.pop(context),
            },
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
        ),
        child: SRoundedContainer(
          padding: const EdgeInsets.only(
              top: SSize.md, left: SSize.md, bottom: SSize.md),
          width: double.infinity,
          showBorder: true,
          backgroundColor:
              selectedAddress ? SColors.darkerGrey : Colors.transparent,
          borderColor: selectedAddress
              ? Colors.transparent
              : dark
                  ? SColors.darkerGrey
                  : SColors.grey,
          margin: const EdgeInsets.only(bottom: SSize.spaceBtwItems),
          child: Stack(
            children: [
              Positioned(
                top: 0,
                right: 5,
                child: Icon(
                  selectedAddress ? Icons.check_circle : null,
                  color: selectedAddress
                      ? dark
                          ? Colors.lightGreen
                          : Colors.green
                      : null,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    address.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: SSize.sm / 2),
                  Text(address.formattedPhoneNum,
                      maxLines: 1, overflow: TextOverflow.ellipsis),
                  const SizedBox(height: SSize.sm / 2),
                  Text(
                    address.toString(),
                    softWrap: true,
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}
