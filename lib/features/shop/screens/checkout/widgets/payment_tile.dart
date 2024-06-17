import 'package:enyad_store_3/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:enyad_store_3/features/shop/controller/checkout/checkout_controller.dart';
import 'package:enyad_store_3/features/shop/models/payment_method_model.dart';
import 'package:enyad_store_3/utils/constants/colors.dart';
import 'package:enyad_store_3/utils/constants/sizes.dart';
import 'package:enyad_store_3/utils/helper/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class SPaymentTile extends StatelessWidget {
  const SPaymentTile({super.key, required this.paymentMethod});

  final PaymentMethodModel paymentMethod;

  @override
  Widget build(BuildContext context) {
    final controller = CheckoutController.instance;
    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      onTap: () {
        controller.selectedPaymentMethod.value = paymentMethod;

        Get.back();
      },
      leading: SRoundedContainer(
        width: 70,
        height: 50,
        backgroundColor:
            SHelperFunction.isDarkMode(context) ? SColors.light : SColors.white,
        padding: const EdgeInsets.all(SSize.sm),
        child: SvgPicture.asset((paymentMethod.image), fit: BoxFit.contain),
      ),
      title: Text(paymentMethod.name),
      trailing: const Icon(Iconsax.arrow_right_34),
    );
  }
}
