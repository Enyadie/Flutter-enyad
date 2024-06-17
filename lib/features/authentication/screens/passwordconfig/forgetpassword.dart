import 'package:enyad_store_3/features/authentication/controller/forget_password/forget_password_controller.dart';
import 'package:enyad_store_3/utils/constants/sizes.dart';
import 'package:enyad_store_3/utils/constants/text_strings.dart';
import 'package:enyad_store_3/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ForgetPasswordController());
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(SSize.defautSpace),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(SText.forgetPasswordTitle,
                    style: Theme.of(context).textTheme.headlineMedium),
                const SizedBox(height: SSize.spaceBtwItems),
                Text(SText.forgetPasswordSubTitle,
                    style: Theme.of(context).textTheme.labelMedium),
                const SizedBox(height: SSize.spaceBtwSections * 2),

                ///email
                Form(
                  key: controller.forgetPasswordFormKey,
                  child: TextFormField(
                    controller: controller.email,
                    validator: SValidator.validateEmail,
                    decoration: const InputDecoration(
                      labelText: SText.email,
                      prefixIcon: Icon(Iconsax.direct_right),
                    ),
                  ),
                ),

                const SizedBox(height: SSize.spaceBtwSections),

                ///SubmitButton
                ///off to close the current screen
                SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => controller.sendPasswordResetEmail(),
                      child: const Text('Submit'),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
