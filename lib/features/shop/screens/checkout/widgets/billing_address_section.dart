import 'package:enyad_store_3/features/personalization/controller/address_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../../../../common/widgets/texts/section_heading.dart';
import '../../../../../utils/constants/sizes.dart';

class SBillingAddressSection extends StatelessWidget {
  const SBillingAddressSection({super.key});

  @override
  Widget build(BuildContext context) {
    final addressController = AddressController.instance;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SSectionHeading(
            title: 'Shipping Address',
            buttonTitle: 'Change',
            onPressed: () => addressController.selectNewAddressPopup(context)),
        Obx(
          () => addressController.selectedAddress.value.id.isNotEmpty
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(addressController.selectedAddress.value.name,
                        style: Theme.of(context).textTheme.bodyLarge),
                    const SizedBox(height: SSize.spaceBtwItems / 2),
                    Row(
                      children: [
                        const Icon(Icons.phone, color: Colors.green, size: 24),
                        const SizedBox(width: SSize.spaceBtwItems),
                        Text(
                            addressController
                                .selectedAddress.value.formattedPhoneNum,
                            style: Theme.of(context).textTheme.bodyMedium),
                      ],
                    ),
                    const SizedBox(height: SSize.spaceBtwItems / 2),
                    Row(
                      children: [
                        const Icon(Icons.location_history,
                            color: Colors.green, size: 24),
                        const SizedBox(width: SSize.spaceBtwItems),
                        Expanded(
                          child: Text(
                              '${addressController.selectedAddress.value.street}, ${addressController.selectedAddress.value.city}, ${addressController.selectedAddress.value.state}, ${addressController.selectedAddress.value.country}',
                              maxLines: 2,
                              style: Theme.of(context).textTheme.bodyMedium,
                              softWrap: true),
                        ),
                      ],
                    ),
                  ],
                )
              : Text('Select Address',
                  style: Theme.of(context).textTheme.bodyMedium),
        ),
      ],
    );
  }
}
