import 'package:enyad_store_3/common/styles/spacing_style.dart';
import 'package:enyad_store_3/features/authentication/screens/login/widgets/loginform.dart';
import 'package:enyad_store_3/features/authentication/screens/login/widgets/loginheader.dart';
import 'package:enyad_store_3/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/login_signup/form_divider.dart';
import '../../../../common/widgets/login_signup/social_button.dart';
import '../../../../utils/constants/sizes.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: SSpacingStyles.paddingWithAppBarHeight,
          child: Column(
            children: [
              const SLoginHeader(),
              const SLoginForm(),
              SFormDivider(
                dividerText: SText.orSignInWith.capitalize!,
              ),
              const SizedBox(height: SSize.spaceBtwSections),
              const SSocialButtons(),
            ],
          ),
        ),
      ),
    );
  }
}
