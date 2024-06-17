import 'package:enyad_store_3/common/styles/spacing_style.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../utils/constants/sizes.dart';
import '../../../utils/helper/helper_function.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({
    Key? key,
    required this.title,
    required this.subTitle,
    required this.image,
    this.onPressed,
    this.isLottie = false,
  }) : super(key: key);

  final bool isLottie;
  final String title, subTitle, image;
  final VoidCallback? onPressed;

  ///optional use ?

  @override
  Widget build(BuildContext context) {
    if (!isLottie) {
      return Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: SSpacingStyles.paddingWithAppBarHeight * 2,
            child: Column(
              children: [
                Image(
                  image: AssetImage(image),
                  width: SHelperFunction.screenWidth() * 0.6,
                ),
                const SizedBox(height: SSize.spaceBtwSections),
                Text(
                  title,
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: SSize.spaceBtwItems),
                Text(
                  subTitle,
                  style: Theme.of(context).textTheme.labelMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: SSize.spaceBtwItems),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: onPressed,
                    child: const Text('Continue'),
                  ),
                ),
                const SizedBox(height: SSize.spaceBtwItems),
              ],
            ),
          ),
        ),
      );
    } else {
      return Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: SSpacingStyles.paddingWithAppBarHeight * 2,
            child: Column(
              children: [
                Lottie.asset(
                  repeat: false,
                  image,
                  width: SHelperFunction.screenWidth() * 0.6,
                ),
                const SizedBox(height: SSize.spaceBtwSections),
                Text(
                  title,
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: SSize.spaceBtwItems),
                Text(
                  subTitle,
                  style: Theme.of(context).textTheme.labelMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: SSize.spaceBtwItems),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: onPressed,
                    child: const Text('Continue'),
                  ),
                ),
                const SizedBox(height: SSize.spaceBtwItems),
              ],
            ),
          ),
        ),
      );
    }
  }
}
