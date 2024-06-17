import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enyad_store_3/features/personalization/models/address_model.dart';
import 'package:enyad_store_3/utils/constants/enums.dart';
import 'package:enyad_store_3/utils/helper/helper_function.dart';

import 'cart_item_model.dart';

class OrderModel {
  final String id, userId, paymentMethod;
  final OrderStatus status;
  final double totalAmount;
  final DateTime orderDate;
  final AddressModel? address;
  final DateTime? deliveryDate;
  final List<CartItemModel> items;

  OrderModel({
    required this.id,
    this.userId = '',
    this.paymentMethod = 'Paypal',
    required this.status,
    required this.totalAmount,
    required this.orderDate,
    required this.items,
    this.address,
    this.deliveryDate,
  });

  String get formattedOrderDate => SHelperFunction.getFormattedDate(orderDate);

  String get formattedDeliveryDate => deliveryDate != null
      ? SHelperFunction.getFormattedDate(deliveryDate!)
      : '';

  String get orderStatusText => status == OrderStatus.delivered
      ? 'Delivered'
      : status == OrderStatus.inTransit
          ? 'On its way'
          : 'Processing';

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'status': status.toJson(),
      'totalAmount': totalAmount,
      'orderDate': orderDate,
      'paymentMethod': paymentMethod,
      'address': address?.toJson(),
      'deliveryDate': deliveryDate,
      'items': items.map((item) => item.toJson()).toList(),
    };
  }

  factory OrderModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;

    return OrderModel(
      id: data['id'] as String,
      userId: data['userId'] as String,
      status: OrderStatusExtension.fromJson(data['status'] as String),
      totalAmount: data['totalAmount'] as double,
      orderDate: (data['orderDate'] as Timestamp).toDate(),
      deliveryDate: data['deliveryDate'] == null
          ? null
          : (data['deliveryDate'] as Timestamp).toDate(),
      items: (data['items'] as List<dynamic>)
          .map((itemData) =>
              CartItemModel.fromJson(itemData as Map<String, dynamic>))
          .toList(),
      paymentMethod: data['paymentMethod'] as String,
      address: data['address'] == null
          ? null
          : AddressModel.fromMap(data['address'] as Map<String, dynamic>),
    );
  }
}
