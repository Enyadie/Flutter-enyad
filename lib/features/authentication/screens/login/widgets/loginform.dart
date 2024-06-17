import 'package:enyad_store_3/features/authentication/controller/login/login_controller.dart';
import 'package:enyad_store_3/features/authentication/screens/passwordconfig/forgetpassword.dart';
import 'package:enyad_store_3/features/authentication/screens/signup/signup.dart';
import 'package:enyad_store_3/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';

class SLoginForm extends StatelessWidget {
  const SLoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Form(
      key: controller.loginFormKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: SSize.spaceBtwSections),
        child: Column(
          children: [
            ///Email
            TextFormField(
              controller: controller.email,
              validator: (value) => SValidator.validateEmail(value),
              decoration: const InputDecoration(
                prefixIcon: Icon(Iconsax.direct_right),
                labelText: SText.email,
              ),
            ),
            const SizedBox(height: SSize.spaceBtwInputField),

            ///Password
            Obx(
              () => TextFormField(
                controller: controller.password,
                validator: (value) =>
                    SValidator.validateEmptyText(SText.password, value),
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
            const SizedBox(height: SSize.spaceBtwInputField / 2),

            ///Remember Me
            Row(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(
                      () => Checkbox(
                          value: LoginController.rememberMe.value,
                          onChanged: (value) => LoginController.rememberMe
                              .value = !LoginController.rememberMe.value),
                    ),
                    const Text(SText.rememberMe),
                  ],
                ),

                ///Forget Password
                TextButton(
                  onPressed: () => Get.to(() => const ForgetPassword()),
                  child: const Text(SText.forgetPassword),
                ),
              ],
            ),
            const SizedBox(height: SSize.spaceBtwSections),

            //Login Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => controller.emailAndPasswordSignIn(),
                child: const Text(SText.signIn),
              ),
            ),
            const SizedBox(height: SSize.spaceBtwItems),

            //create account
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => Get.to(() => const SignupScreen()),
                child: const Text(SText.createAccount),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
