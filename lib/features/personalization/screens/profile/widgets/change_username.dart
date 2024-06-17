import 'package:enyad_store_3/common/widgets/appbar/appBar.dart';
import 'package:enyad_store_3/features/personalization/controller/update_username_controller.dart';
import 'package:enyad_store_3/utils/constants/sizes.dart';
import 'package:enyad_store_3/utils/constants/text_strings.dart';
import 'package:enyad_store_3/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ChangeUsername extends StatelessWidget {
  const ChangeUsername({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdateUsernameController());
    return Scaffold(
      appBar: SAppBar(
        showBackground: false,
        showBackButton: true,
        title: Text('Change Username',
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
                  'Username will displayed with interacting with the Store',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                const SizedBox(height: SSize.spaceBtwSections),
                Form(
                    key: controller.updateUsernameFormKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: controller.username,
                          validator: (value) => SValidator.validateEmptyText(
                              'Enter new user name', value),
                          expands: false,
                          decoration: const InputDecoration(
                              labelText: SText.username,
                              prefixIcon: Icon(Iconsax.user)),
                        ),
                        const SizedBox(height: SSize.spaceBtwInputField),
                      ],
                    )),
                const SizedBox(height: SSize.spaceBtwSections),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () => controller.updateUsername(),
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
