import 'package:enyad_store_3/common/widgets/login_signup/form_divider.dart';
import 'package:enyad_store_3/common/widgets/login_signup/social_button.dart';
import 'package:enyad_store_3/features/authentication/screens/signup/widgets/signup_form.dart';
import 'package:enyad_store_3/utils/constants/sizes.dart';
import 'package:enyad_store_3/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/appbar/appBar.dart';
import '../../../../utils/device/device_utility.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SAppBar(showBackButton: true, showBackground: false),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(SSize.defautSpace),
          child: SizedBox(
            height: SDeviceUtils.getScreenHeight(context),
            width: SDeviceUtils.getScreenWidth(context),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ///title
                Text(SText.signUpTitle,
                    style: Theme.of(context).textTheme.headlineMedium),
                const SizedBox(height: SSize.spaceBtwSections),

                /// sign up Form
                const SSignupForm(),
                const SizedBox(height: SSize.spaceBtwSections),

                /// divider
                SFormDivider(dividerText: SText.orSignUpWith.capitalize!),
                const SizedBox(height: SSize.spaceBtwSections),
                const SSocialButtons()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
