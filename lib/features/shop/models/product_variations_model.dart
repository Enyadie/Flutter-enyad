class ProductVariationModel {
  final String id;
  String sku, image;
  double price, salePrice;
  int stock;
  String? description;
  Map<String, String> attributesVariables;

  ProductVariationModel({
    required this.id,
    this.sku = '',
    this.image = '',
    this.price = 0.0,
    this.salePrice = 0.0,
    this.stock = 0,
    required this.attributesVariables,
    this.description,
    // this.description = '',
  });

  static ProductVariationModel empty() =>
      ProductVariationModel(id: '', attributesVariables: {});

  toJson() {
    return {
      'Id': id,
      'SKU': sku,
      'Image': image,
      'Price': price,
      'SalePrice': salePrice,
      'Stock': stock,
      'AttributesVariables': attributesVariables,
      'Description': description,
    };
  }

  factory ProductVariationModel.fromJson(Map<String, dynamic> document) {
    final data = document;
    if (data.isEmpty) return ProductVariationModel.empty();
    return ProductVariationModel(
      id: data['Id'] ?? '',
      sku: data['SKU'] ?? '',
      image: data['Image'] ?? '',
      stock: data['Stock'] ?? 0,
      price: data['Price'] ?? 0.0,
      salePrice: data['SalePrice'] ?? 0.0,
      attributesVariables:
          Map<String, String>.from(data['AttributesVariables']),
      description: data['Description'] ?? '',
    );
  }
}
