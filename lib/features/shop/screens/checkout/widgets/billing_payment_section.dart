import 'package:enyad_store_3/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:enyad_store_3/common/widgets/texts/section_heading.dart';
import 'package:enyad_store_3/utils/constants/colors.dart';
import 'package:enyad_store_3/utils/helper/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../../utils/constants/sizes.dart';
import '../../../controller/checkout/checkout_controller.dart';

class SBillingPaymentSection extends StatelessWidget {
  const SBillingPaymentSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CheckoutController());

    final dark = SHelperFunction.isDarkMode(context);
    return Column(
      children: [
        SSectionHeading(
          title: 'Payment Method',
          buttonTitle: 'Change',
          onPressed: () => controller.selectPaymentMethod(context),
        ),
        const SizedBox(height: SSize.spaceBtwItems / 2),
        Obx(
          () => Row(
            children: [
              SRoundedContainer(
                width: 75,
                height: 50,
                backgroundColor: dark ? SColors.light : SColors.white,
                padding: const EdgeInsets.all(SSize.sm),
                child: SvgPicture.asset(
                  controller.selectedPaymentMethod.value.image,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(width: SSize.spaceBtwItems / 2),
              Text(controller.selectedPaymentMethod.value.name,
                  style: Theme.of(context).textTheme.bodyLarge),
            ],
          ),
        )
      ],
    );
  }
}
