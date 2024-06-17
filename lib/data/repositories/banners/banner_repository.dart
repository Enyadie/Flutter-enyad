import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enyad_store_3/features/shop/models/banner_model.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../utils/exception/firebaseexception.dart';
import '../../../utils/exception/platformexception.dart';
import '../../../utils/popups/loaders.dart';
import '../../services/firebase_storage_services.dart';

class BannerRepository extends GetxController {
  static BannerRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<List<BannerModel>> getBanners() async {
    try {
      final result = await _db
          .collection('Banners')
          .where('Active', isEqualTo: true)
          .get();
      return result.docs
          .map((snapshot) => BannerModel.fromSnapshot(snapshot))
          .toList();
    } on FirebaseException catch (e) {
      throw SFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw SPlatformException(e.code).message;
    } catch (e) {
      throw SLoaders.errorSnackBar(
          title: 'Oh No!', message: 'Something went wrong. Please try again');
    }
  }

  Future<void> uploadDummyData(List<BannerModel> banners) async {
    try {
      final storage = Get.put(SFirebaseStorageService());
      for (var banner in banners) {
        final file = await storage.getImageDataFromAssets(banner.imageUrl);

        final url =
            await storage.updateImageData('Banners', file, banner.imageUrl);

        banner.imageUrl = url;

        await _db.collection("Banners").doc().set(banner.toJson());
      }
    } on FirebaseException catch (e) {
      throw SFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw SPlatformException(e.code).message;
    } catch (e) {
      throw SLoaders.errorSnackBar(
          title: 'Oh No!',
          message: 'Something went wrong uploading banners. Please try again');
    }
  }

// Future<void> uploadDummyData(List<BannerModel> banners) async {
//   try {
//     final storage = Get.put(SFirebaseStorageService());
//     for (var banner in banners) {
//       // Assuming you have a method to get image data from assets
//       final file = await storage.getImageDataFromAssets(banner.imageUrl);
//
//       // Assuming you have a method to upload image data to Firebase Storage and get the URL
//       final url =
//           await storage.updateImageData('Banners', file, banner.imageUrl);
//
//       // Update the banner model with the new image URL
//       banner.imageUrl = url;
//
//       // Upload the banner model to FireStore
//       await _db.collection("Banners").doc().set(banner.toJson());
//     }
//   } on FirebaseException catch (e) {
//     throw SFirebaseException(e.code).message;
//   } on PlatformException catch (e) {
//     throw SPlatformException(e.code).message;
//   } catch (e) {
//     throw SLoaders.errorSnackBar(
//         title: 'Oh No!', message: 'Something went wrong. Please try again');
//   }
// }
}
