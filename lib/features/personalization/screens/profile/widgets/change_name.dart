import 'package:enyad_store_3/common/widgets/appbar/appBar.dart';
import 'package:enyad_store_3/features/personalization/controller/update_name_controller.dart';
import 'package:enyad_store_3/utils/constants/sizes.dart';
import 'package:enyad_store_3/utils/constants/text_strings.dart';
import 'package:enyad_store_3/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ChangeName extends StatelessWidget {
  const ChangeName({super.key});

  @override
  Widget build(BuildContext context) {
    // final userController = UserController.instance;
    final controller = Get.put(UpdateNameController());
    return Scaffold(
      appBar: SAppBar(
        showBackground: false,
        showBackButton: true,
        title: Text('Change Name',
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
                  'For Verification Service Please User your Real Name.',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                const SizedBox(height: SSize.spaceBtwSections),
                Form(
                    key: controller.updateFirstAndLastNameFormKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: controller.firstName,
                          validator: (value) =>
                              SValidator.validateEmptyText('First Name', value),
                          expands: false,
                          decoration: const InputDecoration(
                              labelText: SText.firstName,
                              prefixIcon: Icon(Iconsax.user)),
                        ),
                        const SizedBox(height: SSize.spaceBtwInputField),
                        TextFormField(
                          controller: controller.lastName,
                          validator: (value) =>
                              SValidator.validateEmptyText('Last Name', value),
                          expands: false,
                          decoration: const InputDecoration(
                            labelText: SText.lastName,
                            prefixIcon: Icon(Iconsax.user),
                          ),
                        ),
                      ],
                    )),
                const SizedBox(height: SSize.spaceBtwSections),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () => controller.updateFirstAndLastName(),
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
