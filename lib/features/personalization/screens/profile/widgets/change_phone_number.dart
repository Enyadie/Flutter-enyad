import 'package:enyad_store_3/common/widgets/appbar/appBar.dart';
import 'package:enyad_store_3/utils/constants/sizes.dart';
import 'package:enyad_store_3/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../utils/validators/validation.dart';
import '../../../controller/update_phone_number_controller.dart';

class ChangePhoneNumber extends StatelessWidget {
  const ChangePhoneNumber({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdatePhoneNumberController());
    return Scaffold(
      appBar: SAppBar(
        showBackground: false,
        showBackButton: true,
        title: Text('Change Phone Number',
            style: Theme.of(context).textTheme.headlineSmall),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(SSize.defautSpace),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Phone number is required',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                const SizedBox(height: SSize.spaceBtwSections),
                Form(
                    key: controller.updatePhoneNumberFormKey,
                    child: Column(
                      children: [
                        TextFormField(
                          keyboardType: TextInputType.number,
                          controller: controller.phoneNumber,
                          validator: (value) =>
                              SValidator.validatePhoneNumber(value),
                          expands: false,
                          decoration: const InputDecoration(
                              labelText: SText.phoneNumber,
                              prefixIcon: Icon(Iconsax.call)),
                        ),
                        const SizedBox(height: SSize.spaceBtwInputField),
                      ],
                    )),
                const SizedBox(height: SSize.spaceBtwSections),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () => controller.updatePhoneNumber(),
                      child: const Text('Save')),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
