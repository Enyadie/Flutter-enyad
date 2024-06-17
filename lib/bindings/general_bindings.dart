import 'package:enyad_store_3/data/services/network_manager.dart';
import 'package:enyad_store_3/features/personalization/controller/address_controller.dart';
import 'package:enyad_store_3/features/shop/controller/checkout/checkout_controller.dart';
import 'package:get/get.dart';

import '../features/shop/controller/product/variation_controller.dart';

class GeneralBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(NetworkManager());
    Get.put(VariationController());
    Get.put(AddressController());
    Get.put(CheckoutController());
  }
}
