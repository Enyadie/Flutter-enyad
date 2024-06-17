import 'package:enyad_store_3/features/authentication/controller/forget_password/forget_password_controller.dart';
import 'package:enyad_store_3/features/authentication/screens/login/login.dart';
import 'package:enyad_store_3/utils/constants/image_strings.dart';
import 'package:enyad_store_3/utils/constants/sizes.dart';
import 'package:enyad_store_3/utils/constants/text_strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/login_signup/form_divider.dart';
import '../../../../utils/helper/helper_function.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key, required this.email});

  final String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,

        ///remove back arrow
        actions: [
          IconButton(
              onPressed: () => Get.back(),
              icon: const Icon(CupertinoIcons.clear))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(SSize.defautSpace),
          child: Column(
            children: [
              ///image
              Image(
                image: const AssetImage(SImages.deliveredEmailIllustration),
                width: SHelperFunction.screenWidth() * 0.6,
                // ),
              ),

              /// title and subtitle
              const SizedBox(height: SSize.spaceBtwSections),

              Text(SText.changeYourPasswordTitle,
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center),
              const SizedBox(height: SSize.spaceBtwItems),
              Text(SText.changeYourPasswordSubTitle,
                  style: Theme.of(context).textTheme.labelMedium,
                  textAlign: TextAlign.center),
              const SizedBox(height: SSize.spaceBtwItems),

              ///button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () => Get.offAll(() => const LoginScreen()),
                    child: const Text('Done')),
              ),
              const SizedBox(height: SSize.spaceBtwItems),
              const SFormDivider(dividerText: SText.noEmailReceived),
              const SizedBox(height: SSize.spaceBtwItems),

              SizedBox(
                width: double.infinity,
                child: TextButton(
                    onPressed: () => ForgetPasswordController.instance
                        .resendPasswordResetEmail(email),
                    child: const Text('Resend')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
