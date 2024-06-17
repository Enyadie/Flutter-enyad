

class CartItemModel {
  String productId, title, variationId;
  String? image;
  String? brandName;
  double price;
  int quantity;
  Map<String, String>? selectedVariation;

  CartItemModel({
    required this.quantity,
    required this.productId,
    this.title = '',
    this.variationId = '',
    this.image,
    this.brandName,
    this.price = 0.00,
    this.selectedVariation,
  });

  static CartItemModel empty() => CartItemModel(quantity: 0, productId: '');

  Map<String, dynamic> toJson() {
    return {
      'quantity': quantity,
      'productId': productId,
      'title': title,
      'variationId': variationId,
      'image': image,
      'brandName': brandName,
      'price': price,
      'selectedVariation': selectedVariation,
    };
  }

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      productId: json['productId'],
      quantity: json['quantity'],
      title: json['title'],
      variationId: json['variationId'],
      image: json['image'],
      brandName: json['brandName'],
      price: json['price']?.toDouble(),
      selectedVariation: json['selectedVariation'] != null
          ? Map<String, String>.from(json['selectedVariation'])
          : null,
    );
  }
}
