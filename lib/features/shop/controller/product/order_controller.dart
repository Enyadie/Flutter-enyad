import 'package:enyad_store_3/common/widgets/success_screen/success_screen.dart';
import 'package:enyad_store_3/data/repositories/authentication/authen_repository.dart';
import 'package:enyad_store_3/features/personalization/controller/address_controller.dart';
import 'package:enyad_store_3/features/shop/controller/checkout/checkout_controller.dart';
import 'package:enyad_store_3/features/shop/controller/product/cart_item_controller.dart';
import 'package:enyad_store_3/navigation_menu.dart';
import 'package:enyad_store_3/utils/constants/enums.dart';
import 'package:enyad_store_3/utils/popups/full_screen_loader.dart';
import 'package:enyad_store_3/utils/popups/loaders.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../data/repositories/oders/order_prepository.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../models/order_model.dart';

class OrderController extends GetxController {
  OrderController get instance => Get.find();

  final cartController = CartItemController.instance;
  final addressController = AddressController.instance;
  final checkOutController = CheckoutController.instance;
  final orderRepo = Get.put(OrderRepository());

  Future<List<OrderModel>> getUsersOrder() async {
    try {
      final usersOrder = await orderRepo.getUserOrders();
      return usersOrder;
    } catch (e) {
      // SLoaders.warningSnackBar(title: 'Oh No!', message: e.toString());
      return [];
    }
  }

  void processOrder(double totalAmount) async {
    try {
      SFullScreenLoader.openLoadingDialog(
          'Processing your order', SImages.processing);

      final userId = AuthenticationRepository.instance.authUser!.uid;

      if (userId.isEmpty) return;

      final order = OrderModel(
        id: UniqueKey().toString(),
        userId: userId,
        status: OrderStatus.pending,
        totalAmount: totalAmount,
        orderDate: DateTime.now(),
        items: cartController.cartItems.toList(),
        deliveryDate: DateTime.now(),
        paymentMethod: checkOutController.selectedPaymentMethod.value.name,
        address: addressController.selectedAddress.value,
      );

      await orderRepo.saveOrder(order, userId);

      cartController.clearCart();
      Get.off(
        () => SuccessScreen(
          isLottie: true,
          title: 'Payment Success',
          subTitle: 'Your item will be ready soon!',
          image: SImages.successfulPayment,
          onPressed: () => Get.offAll(() => const NavigationMenu()),
        ),
      );
    } catch (e) {
      SLoaders.errorSnackBar(title: 'Oh no!', message: e.toString());
    }
  }
}
