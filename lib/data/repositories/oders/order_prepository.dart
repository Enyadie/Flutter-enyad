import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enyad_store_3/data/repositories/authentication/authen_repository.dart';
import 'package:enyad_store_3/utils/popups/loaders.dart';
import 'package:get/get.dart';

import '../../../features/shop/models/order_model.dart';

class OrderRepository extends GetxController {
  static OrderRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<List<OrderModel>> getUserOrders() async {
    try {
      final userId = AuthenticationRepository.instance.authUser!.uid;
      if (userId.isEmpty) {
        SLoaders.warningSnackBar(
            title: '',
            message:
                'Unable to find user information. Try again in a few minutes.');
        return [];
      }
      final result =
          await _db.collection('Users').doc(userId).collection('Orders').get();
      return result.docs
          .map((documentSnapshot) => OrderModel.fromSnapshot(documentSnapshot))
          .toList();
    } catch (e) {
      SLoaders.warningSnackBar(
          title: '',
          message:
              'Something went wrong while getting your orders information. Try again later.');
      return [];
    }
  }

  Future<void> saveOrder(OrderModel order, String userId) async {
    try {
      await _db
          .collection('Users')
          .doc(userId)
          .collection('Orders')
          .add(order.toJson());
    } catch (e) {
      print('Error saving order: $e'); // For debugging
      SLoaders.warningSnackBar(
          title: 'Oh No!',
          message: 'Something went wrong while saving your order. Try again.');
    }
  }
}
