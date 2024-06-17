import 'package:enyad_store_3/features/authentication/controller/onboarding/onboarding.controller.dart';
import 'package:enyad_store_3/features/authentication/screens/onboarding/widgets/onbarding_dot_Navgation.dart';
import 'package:enyad_store_3/features/authentication/screens/onboarding/widgets/onbarding_page.dart';
import 'package:enyad_store_3/features/authentication/screens/onboarding/widgets/onbarding_skip.dart';
import 'package:enyad_store_3/features/authentication/screens/onboarding/widgets/onboarding_next_button.dart';
import 'package:enyad_store_3/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/constants/image_strings.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnBoardingController()); //no new instance
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: controller.pageController,
            onPageChanged: controller.updatePackageIndicator,
            children: const [
              OnBoardingPage(
                image: SImages.onBoardingImage1,
                title: SText.onBoardingTitle1,
                subTitle: SText.onBoardingSubTitle1,
              ),
              OnBoardingPage(
                image: SImages.onBoardingImage2,
                title: SText.onBoardingTitle2,
                subTitle: SText.onBoardingSubTitle2,
              ),
              OnBoardingPage(
                image: SImages.onBoardingImage3,
                title: SText.onBoardingTitle3,
                subTitle: SText.onBoardingSubTitle3,
              ),
            ],
          ),
          const OnBoardingSkip(),
          const OnBoardingDotNavigation(),
          const OnBoardingNextButton()
        ],
      ),
    );
  }
}
