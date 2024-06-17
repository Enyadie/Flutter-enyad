import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

import '../../../features/authentication/models/user_model.dart';
import '../../../utils/exception/firebaseexception.dart';
import '../../../utils/exception/formatexception.dart';
import '../../../utils/exception/platformexception.dart';
import '../../../utils/popups/loaders.dart';
import '../authentication/authen_repository.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  ///save user data to fireStore
  Future<void> saveUserData(UserModel user) async {
    try {
      await _db.collection("Users").doc(user.id).set(user.toJson());
    } on FirebaseException catch (e) {
      throw SFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw SFormatException();
    } on PlatformException catch (e) {
      throw SPlatformException(e.code).message;
    } catch (e) {
      throw SLoaders.errorSnackBar(
          title: 'Sorry!', message: 'Something went wrong. Please try again');
    }
  }

  ///get userdata from fireStore
  Future<UserModel> getUserDetails() async {
    try {
      final documentSnapshot = await _db
          .collection('Users')
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .get();
      if (documentSnapshot.exists) {
        return UserModel.fromSnapshot(documentSnapshot);
      } else {
        return UserModel.empty();
      }
    } on FirebaseException catch (e) {
      throw SFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw SFormatException();
    } on PlatformException catch (e) {
      throw SPlatformException(e.code).message;
    } catch (e) {
      throw SLoaders.errorSnackBar(
          title: 'Sorry!', message: 'Something went wrong. Please try again');
    }
  }

  /// Method to upload user profile image
  Future<String> uploadImage(String folderPath, XFile imageFile) async {
    try {
      final fileName = path.basename(imageFile.path);
      final storageRef = _storage.ref().child('$folderPath/$fileName');
      final uploadTask = storageRef.putFile(File(imageFile.path));
      final snapshot = await uploadTask.whenComplete(() => {});
      final downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } on FirebaseException catch (e) {
      throw SFirebaseException(e.code).message;
    } catch (e) {
      throw SLoaders.errorSnackBar(
          title: 'Sorry!',
          message:
              'Something went wrong while uploading the image. Please try again');
    }
  }

  ///update userdata from fireStore
  Future<void> updateUserDetails(UserModel updateUser) async {
    try {
      await _db.collection("Users").doc(updateUser.id).set(updateUser.toJson());
    } on FirebaseException catch (e) {
      throw SFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw SFormatException();
    } on PlatformException catch (e) {
      throw SPlatformException(e.code).message;
    } catch (e) {
      // throw SLoaders.errorSnackBar(
      //     title: 'Sorry!', message: 'Something went wrong. Please try again');
    }
  }

  ///update userdata in a single field fireStore
  Future<void> updateSingleField(Map<String, dynamic> json) async {
    try {
      await _db
          .collection("Users")
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .update(json);
    } on FirebaseException catch (e) {
      throw SFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw SFormatException();
    } on PlatformException catch (e) {
      throw SPlatformException(e.code).message;
    } catch (e) {
      // throw SLoaders.errorSnackBar(
      //     title: 'Sorry!', message: 'Something went wrong. Please try again');
    }
  }

  ///remove userdata from fireStore
  Future<void> removeUserData(String userId) async {
    try {
      await _db.collection("Users").doc(userId).delete();
    } on FirebaseException catch (e) {
      throw SFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw SFormatException();
    } on PlatformException catch (e) {
      throw SPlatformException(e.code).message;
    } catch (e) {
      // throw SLoaders.errorSnackBar(
      //     title: 'Sorry!', message: 'Something went wrong. Please try again');
    }
  }
}
