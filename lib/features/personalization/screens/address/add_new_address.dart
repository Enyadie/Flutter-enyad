import 'package:enyad_store_3/common/widgets/appbar/appBar.dart';
import 'package:enyad_store_3/features/personalization/controller/address_controller.dart';
import 'package:enyad_store_3/utils/constants/colors.dart';
import 'package:enyad_store_3/utils/constants/sizes.dart';
import 'package:enyad_store_3/utils/helper/helper_function.dart';
import 'package:enyad_store_3/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class AddNewAddressScreen extends StatelessWidget {
  const AddNewAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = AddressController.instance;
    final dark = SHelperFunction.isDarkMode(context);
    return Scaffold(
      backgroundColor: dark ? Colors.grey.shade900 : SColors.white,
      appBar: const SAppBar(
          showBackground: true,
          showBackButton: true,
          buttonBackgroundColor: true,
          title: Text('Add new Address')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(SSize.defautSpace),
          child: Form(
            key: controller.addressFormKey,
            child: Column(
              children: [
                const SizedBox(height: SSize.sm),
                TextFormField(
                  controller: controller.name,
                  validator: (value) =>
                      SValidator.validateEmptyText('Name', value),
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Iconsax.user), labelText: 'Name'),
                ),
                const SizedBox(height: SSize.spaceBtwInputField),
                TextFormField(
                  keyboardType: TextInputType.phone,
                  controller: controller.phoneNumber,
                  validator: (value) => SValidator.validatePhoneNumber(value),
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Iconsax.mobile),
                      labelText: 'Phone Number'),
                ),
                const SizedBox(height: SSize.spaceBtwInputField),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: controller.street,
                        validator: (value) =>
                            SValidator.validateEmptyText('Street', value),
                        decoration: const InputDecoration(
                            prefixIcon: Icon(Iconsax.building_31),
                            labelText: 'Street'),
                      ),
                    ),
                    const SizedBox(width: SSize.spaceBtwInputField),
                    Expanded(
                      child: TextFormField(
                        controller: controller.postalCode,
                        decoration: const InputDecoration(
                            prefixIcon: Icon(Iconsax.code),
                            labelText: 'Postal Code'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: SSize.spaceBtwInputField),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: controller.city,
                        validator: (value) =>
                            SValidator.validateEmptyText('City', value),
                        decoration: const InputDecoration(
                            prefixIcon: Icon(Iconsax.building),
                            labelText: 'City'),
                      ),
                    ),
                    const SizedBox(width: SSize.spaceBtwInputField),
                    Expanded(
                      child: TextFormField(
                        controller: controller.state,
                        validator: (value) =>
                            SValidator.validateEmptyText('State/Parish', value),
                        decoration: const InputDecoration(
                            prefixIcon: Icon(Iconsax.map),
                            labelText: 'State/Parish'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: SSize.spaceBtwInputField),
                TextFormField(
                  controller: controller.country,
                  validator: (value) =>
                      SValidator.validateEmptyText('Country', value),
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Iconsax.global), labelText: 'Country'),
                ),
                const SizedBox(height: SSize.defautSpace),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () => controller.addNewAddress(),
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
