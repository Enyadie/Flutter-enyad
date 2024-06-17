import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../features/shop/models/brand_category_model.dart';
import '../../../utils/exception/firebaseexception.dart';
import '../../../utils/exception/platformexception.dart';
import '../../../utils/popups/loaders.dart';

class BrandsCategoryRepository extends GetxController {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  Future<void> uploadBrandCategory(BrandCategoryModel brandCategory) async {
    try {
      await _fireStore.collection('BrandCategory').add(brandCategory.toJson());
    } on FirebaseException catch (e) {
      throw SFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw SPlatformException(e.code).message;
    } catch (e) {
      SLoaders.errorSnackBar(title: 'Oh No!', message: e.toString());
    }
  }

  Future<void> uploadDummyData(List<BrandCategoryModel> dummyData) async {
    for (var brandCategory in dummyData) {
      await uploadBrandCategory(brandCategory);
    }
  }
}
