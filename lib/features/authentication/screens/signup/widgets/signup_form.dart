import 'package:enyad_store_3/features/authentication/controller/signup/signup_controller.dart';
import 'package:enyad_store_3/features/authentication/screens/signup/widgets/terms_condition_checkbox.dart';
import 'package:enyad_store_3/utils/helper/helper_function.dart';
import 'package:enyad_store_3/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';

class SSignupForm extends StatelessWidget {
  const SSignupForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = SHelperFunction.isDarkMode(context);
    final controller = Get.put(SignupController());
    return Form(
      key: controller.signupFormKey,
      child: Column(
        children: [
          Row(
            children: [
              ///first name
              Expanded(
                child: TextFormField(
                  controller: controller.firstName,
                  validator: (value) =>
                      SValidator.validateEmptyText('First name', value),
                  expands: false,
                  decoration: const InputDecoration(
                      labelText: SText.firstName,
                      prefixIcon: Icon(Iconsax.user)),
                ),
              ),
              const SizedBox(width: SSize.spaceBtwInputField),

              ///last name
              Expanded(
                child: TextFormField(
                  controller: controller.lastName,
                  validator: (value) =>
                      SValidator.validateEmptyText('Last name', value),
                  expands: false,
                  decoration: const InputDecoration(
                      labelText: SText.lastName,
                      prefixIcon: Icon(Iconsax.user)),
                ),
              ),
            ],
          ),

          const SizedBox(height: SSize.spaceBtwInputField),

          ///user name
          TextFormField(
            controller: controller.username,
            validator: (value) =>
                SValidator.validateEmptyText('Username', value),
            decoration: const InputDecoration(
                labelText: SText.username, prefixIcon: Icon(Iconsax.user_edit)),
          ),

          const SizedBox(height: SSize.spaceBtwInputField),

          ///email
          TextFormField(
            controller: controller.email,
            validator: (value) => SValidator.validateEmail(value),
            decoration: const InputDecoration(
                labelText: SText.email, prefixIcon: Icon(Iconsax.direct)),
          ),

          const SizedBox(height: SSize.spaceBtwInputField),

          ///phone number
          TextFormField(
            keyboardType: TextInputType.number,
            controller: controller.phoneNumber,
            validator: (value) => SValidator.validatePhoneNumber(value),
            decoration: const InputDecoration(
                labelText: SText.phoneNumber, prefixIcon: Icon(Iconsax.call)),
          ),

          const SizedBox(height: SSize.spaceBtwInputField),

          ///Password
          Obx(
            () => TextFormField(
              controller: controller.password,
              validator: (value) => SValidator.validatePassword(value),
              obscureText: controller.hidePassword.value,
              decoration: InputDecoration(
                labelText: SText.password,
                prefixIcon: const Icon(Iconsax.password_check),
                suffixIcon: IconButton(
                    onPressed: () => controller.hidePassword.value =
                        !controller.hidePassword.value,
                    icon: controller.hidePassword.value
                        ? const Icon(Iconsax.eye_slash)
                        : const Icon(Iconsax.eye)),
              ),
            ),
          ),
          const SizedBox(height: SSize.spaceBtwSections),
          const STermsAndConditionCheckBox(),
          const SizedBox(height: SSize.spaceBtwSections),

          /// signUp button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => controller.signup(),
              child: const Text(SText.createAccount),
            ),
          ),
        ],
      ),
    );
  }
}
