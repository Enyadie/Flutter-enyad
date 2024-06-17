enum TextSizes { small, medium, large }

enum OrderStatus { processing, inTransit, delivered, pending, cancelled }

enum PaymentMethods {
  paypal,
  googlePay,
  applePay,
  visa,
  mastercard,
  creditCard
}

extension OrderStatusExtension on OrderStatus {
  String toJson() {
    return this.toString().split('.').last;
  }

  static OrderStatus fromJson(String status) {
    return OrderStatus.values
        .firstWhere((e) => e.toString().split('.').last == status);
  }
}

enum ProductType { single, variable }
