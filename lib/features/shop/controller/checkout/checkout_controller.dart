import 'package:enyad_store_3/common/widgets/texts/section_heading.dart';
import 'package:enyad_store_3/utils/constants/image_strings.dart';
import 'package:enyad_store_3/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/payment_method_model.dart';
import '../../screens/checkout/widgets/payment_tile.dart';

class CheckoutController extends GetxController {
  static CheckoutController get instance => Get.find();

  final Rx<PaymentMethodModel> selectedPaymentMethod =
      PaymentMethodModel.empty().obs;

  @override
  void onInit() {
    selectedPaymentMethod.value =
        PaymentMethodModel(name: 'Paypal', image: SImages.paypal);
    super.onInit();
  }

  Future<dynamic> selectPaymentMethod(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (_) => SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(SSize.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SSectionHeading(
                title: 'Select Payment Method',
                showActionButton: false,
              ),
              const SizedBox(height: SSize.spaceBtwSections),
              SPaymentTile(
                  paymentMethod: PaymentMethodModel(
                      name: 'Paypal', image: SImages.paypal)),
              const SizedBox(height: SSize.spaceBtwItems / 2),
              SPaymentTile(
                  paymentMethod:
                      PaymentMethodModel(name: 'Visa', image: SImages.visa)),
              const SizedBox(height: SSize.spaceBtwItems / 2),
              SPaymentTile(
                  paymentMethod: PaymentMethodModel(
                      name: 'Master Card', image: SImages.masterCard)),
              const SizedBox(height: SSize.spaceBtwItems / 2),
              SPaymentTile(
                  paymentMethod: PaymentMethodModel(
                      name: 'Apple Pay', image: SImages.applePay)),
              const SizedBox(height: SSize.spaceBtwItems / 2),
              SPaymentTile(
                  paymentMethod: PaymentMethodModel(
                      name: 'Google Pay', image: SImages.googlePay)),
              const SizedBox(height: SSize.spaceBtwItems / 2),
              const SizedBox(height: SSize.spaceBtwItems),
            ],
          ),
        ),
      ),
    );
  }
}
