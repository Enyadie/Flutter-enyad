import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../features/shop/models/product_category_model.dart';
import '../../../utils/exception/firebaseexception.dart';
import '../../../utils/exception/platformexception.dart';
import '../../../utils/popups/loaders.dart';

class ProductsCategoryRepository extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> uploadProductCategory(
      ProductCategoryModel productCategory) async {
    try {
      await _firestore
          .collection('ProductCategory')
          .add(productCategory.toJson());
    } on FirebaseException catch (e) {
      throw SFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw SPlatformException(e.code).message;
    } catch (e) {
      SLoaders.errorSnackBar(title: 'Oh No!', message: e.toString());
    }
  }

  Future<void> uploadDummyData(List<ProductCategoryModel> dummyData) async {
    for (var productCategory in dummyData) {
      await uploadProductCategory(productCategory);
    }
  }
}
