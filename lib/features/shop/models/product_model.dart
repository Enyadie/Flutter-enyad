import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enyad_store_3/features/shop/models/product_attributes_model.dart';
import 'package:enyad_store_3/features/shop/models/product_variations_model.dart';

import 'brand_model.dart';

class ProductModel {
  String id, title, thumbnail, productType;
  int stock;
  double price, salePrice;
  bool? isFeatured;
  String? sku;
  String? description;
  String? categoryId;
  DateTime? date;
  List<String>? images;
  List<ProductAttributeModel>? productAttributes;
  List<ProductVariationModel>? productVariations;
  BrandModel? brand;

  ProductModel({
    required this.id,
    required this.title,
    required this.thumbnail,
    required this.productType,
    required this.stock,
    required this.price,
    this.salePrice = 0.00,
    this.isFeatured = false,
    this.date,
    this.sku,
    this.description,
    this.categoryId,
    this.images = const [],
    this.productAttributes = const [],
    this.productVariations = const [],
    this.brand,
  });

  static ProductModel empty() => ProductModel(
        id: '',
        title: '',
        stock: 0,
        price: 0,
        thumbnail: '',
        productType: '',
      );

  toJson() {
    return {
      'SKU': sku,
      'Title': title,
      'Stock': stock,
      'Price': price,
      'Images': images ?? [],
      'Thumbnail': thumbnail,
      'SalePrice': salePrice,
      'IsFeatured': isFeatured,
      'CategoryId': categoryId,
      'Brand': brand!.toJson(),
      'Description': description,
      'ProductType': productType,
      'ProductAttributes': productAttributes != null
          ? productAttributes!.map((e) => e.toJson()).toList()
          : [],
      'ProductVariations': productVariations != null
          ? productVariations!.map((e) => e.toJson()).toList()
          : [],
    };
  }

  factory ProductModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return ProductModel(
      id: document.id,
      title: data['Title'],
      thumbnail: data['Thumbnail'] ?? '',
      productType: data['ProductType'] ?? '',
      stock: data['Stock'] ?? 0,
      price: data['Price'] ?? 0.0,
      sku: data['SKU'],
      isFeatured: data['IsFeatured'] ?? false,
      salePrice: data['SalePrice'] ?? 0.0,
      categoryId: data['CategoryId'] ?? '',
      description: data['Description'] ?? '',
      brand: BrandModel.fromJson(data['Brand']),
      images: data['Images'] != null ? List<String>.from(data['Images']) : [],
      productAttributes: (data['ProductAttributes'] as List<dynamic>)
          .map((e) => ProductAttributeModel.fromJson(e))
          .toList(),
      productVariations: (data['ProductVariations'] as List<dynamic>)
          .map((e) => ProductVariationModel.fromJson(e))
          .toList(),
    );
  }

  factory ProductModel.fromQuerySnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();

    return ProductModel(
      id: document.id,
      title: data['Title'],
      thumbnail: data['Thumbnail'] ?? '',
      productType: data['ProductType'] ?? '',
      stock: data['Stock'] ?? 0,
      price: (data['Price'] ?? 0.0).toDouble(),
      sku: data['SKU'],
      isFeatured: data['IsFeatured'] ?? false,
      salePrice: (data['SalePrice'] ?? 0.0).toDouble(),
      categoryId: data['CategoryId'] ?? '',
      description: data['Description'] ?? '',
      brand: BrandModel.fromJson(data['Brand']),
      images: data['Images'] != null ? List<String>.from(data['Images']) : [],
      productAttributes: (data['ProductAttributes'] as List<dynamic>)
          .map((e) => ProductAttributeModel.fromJson(e))
          .toList(),
      productVariations: (data['ProductVariations'] as List<dynamic>)
          .map((e) => ProductVariationModel.fromJson(e))
          .toList(),
    );
  }
}
