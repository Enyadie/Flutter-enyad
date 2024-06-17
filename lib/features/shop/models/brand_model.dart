import 'package:cloud_firestore/cloud_firestore.dart';

class BrandModel {
  String id, name, image;
  bool? isFeatured;
  int? productCount;

  BrandModel({
    required this.name,
    required this.id,
    required this.image,
    this.isFeatured,
    this.productCount,
  });

  static BrandModel empty() => BrandModel(name: '', id: '', image: '');

  toJson() {
    return {
      'Id': id,
      'Name': name,
      'Image': image,
      'ProductCount': productCount,
      'IsFeatured': isFeatured,
    };
  }

  factory BrandModel.fromJson(Map<String, dynamic> document) {
    final data = document;
    if (data.isEmpty) return BrandModel.empty();
    return BrandModel(
      id: data['Id'] ?? '',
      name: data['Name'] ?? '',
      image: data['Image'] ?? '',
      productCount: data['ProductCount'] ?? 0,
      isFeatured: data['IsFeatured'] ?? false,
    );
  }

  factory BrandModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;

      ///map json record to model
      return BrandModel(
          id: data['Id'] ?? '',
          name: data['Name'] ?? '',
          image: data['Image'] ?? '',
          productCount: data['ProductCount'] ?? 0,
          isFeatured: data['IsFeatured'] ?? false);
    } else {
      return BrandModel.empty();
    }
  }
}
