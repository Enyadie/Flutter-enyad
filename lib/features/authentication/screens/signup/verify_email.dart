import 'package:enyad_store_3/data/repositories/authentication/authen_repository.dart';
import 'package:enyad_store_3/features/authentication/controller/signup/verify_email_controller.dart';
import 'package:enyad_store_3/utils/constants/sizes.dart';
import 'package:enyad_store_3/utils/constants/text_strings.dart';
import 'package:enyad_store_3/utils/helper/helper_function.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/constants/image_strings.dart';

class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({super.key, this.email});

  final String? email;

  @override
  Widget build(BuildContext context) {
    ///create one time instance using get up and call using get find
    final controller = Get.put(VerifyEmailController());
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,

        /// remove back button
        actions: [
          IconButton(
            onPressed: () => AuthenticationRepository.instance.logout(),
            icon: const Icon(CupertinoIcons.clear),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(SSize.defautSpace),
          child: Column(
            children: [
              // SSwingingImageAnimation(
              Image(
                image: const AssetImage(SImages.deliveredEmailIllustration),
                width: SHelperFunction.screenWidth() * 0.6,
                // ),
              ),
              const SizedBox(height: SSize.spaceBtwSections),

              Text(SText.confirmEmail,
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center),
              const SizedBox(height: SSize.spaceBtwItems),
              Text(email ?? '',
                  style: Theme.of(context).textTheme.labelLarge,
                  textAlign: TextAlign.center),
              const SizedBox(height: SSize.spaceBtwItems),
              Text(SText.confirmEmailSubTitle,
                  style: Theme.of(context).textTheme.labelMedium,
                  textAlign: TextAlign.center),
              const SizedBox(height: SSize.spaceBtwItems),

              ///button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () =>
                        Get.to(controller.checkVerificationStatus()),
                    child: const Text(SText.sContinue)),
              ),
              const SizedBox(height: SSize.spaceBtwItems),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                    onPressed: () => controller.sendEmailVerification(),
                    child: const Text(SText.resendEmail)),
              ),
              const SizedBox(height: SSize.spaceBtwItems),
            ],
          ),
        ),
      ),
    );
  }
}
