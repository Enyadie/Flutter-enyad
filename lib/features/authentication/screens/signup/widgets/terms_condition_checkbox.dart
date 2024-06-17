import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../../../utils/helper/helper_function.dart';
import '../../../controller/signup/signup_controller.dart';

class STermsAndConditionCheckBox extends StatelessWidget {
  const STermsAndConditionCheckBox({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = SignupController.instance;
    final dark = SHelperFunction.isDarkMode(context);

    return Row(
      children: [
        SizedBox(
            width: 24,
            height: 24,
            child: Obx(() => Checkbox(
                value: controller.privacyChecked.value,
                onChanged: (value) => controller.privacyChecked.value =
                    !controller.privacyChecked.value))),
        const SizedBox(width: SSize.spaceBtwItems),
        Expanded(
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: '${SText.iAgreeTo} ',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                TextSpan(
                  text: '${SText.privacyPolicy} ',
                  style: Theme.of(context).textTheme.bodyMedium!.apply(
                      color: dark ? SColors.white : SColors.primary,
                      decoration: TextDecoration.underline,
                      decorationColor: dark ? SColors.white : SColors.primary),
                  recognizer: TapGestureRecognizer()..onTap = () => (),
                ),
                TextSpan(
                  text: '${SText.and} ',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                TextSpan(
                  text: '${SText.termsOfUse} ',
                  style: Theme.of(context).textTheme.bodyMedium!.apply(
                        color: dark ? SColors.white : SColors.primary,
                        decoration: TextDecoration.underline,
                        decorationColor: dark ? SColors.white : SColors.primary,
                      ),
                  recognizer: TapGestureRecognizer()..onTap = () => (),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
