import 'dart:io';

import 'package:enyad_store_3/data/repositories/user/user_repository.dart';
import 'package:enyad_store_3/features/authentication/screens/login/login.dart';
import 'package:enyad_store_3/features/authentication/screens/onboarding/onboarding.dart';
import 'package:enyad_store_3/features/authentication/screens/signup/verify_email.dart';
import 'package:enyad_store_3/navigation_menu.dart';
import 'package:enyad_store_3/utils/local_storage/local_storage.dart';
import 'package:enyad_store_3/utils/popups/loaders.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';

import '../../../utils/exception/firebaseauthexception.dart';
import '../../../utils/exception/firebaseexception.dart';
import '../../../utils/exception/formatexception.dart';
import '../../../utils/exception/platformexception.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  final deviceStorage = GetStorage();
  final _firebaseAuth = FirebaseAuth.instance;

  User? get authUser => _firebaseAuth.currentUser;

  ///on app launch call main.dart
  @override
  void onReady() {
    FlutterNativeSplash.remove();
    screenRedirect();
  }

  screenRedirect() async {
    ///check all where screenRedirect and add the user
    final user = _firebaseAuth.currentUser;

    if (user != null) {
      if (user.emailVerified) {
        await SLocalStorage.init(user.uid);
        Get.offAll(() => const NavigationMenu());
      } else {
        Get.offAll(() => VerifyEmailScreen(
              email: _firebaseAuth.currentUser?.email,
            ));
      }
    } else {
      deviceStorage.writeIfNull('IsFirstRun', true);
      deviceStorage.read('IsFirstRun') != true
          ? Get.offAll(() => const LoginScreen())
          : Get.offAll(() => const OnBoardingScreen());
    }
  }

  ///register email [EmailAuthentication]

  Future<UserCredential> registerEmailAndPassword(
      String email, String password) async {
    try {
      return await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw SFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw SFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw SFormatException();
    } on PlatformException catch (e) {
      throw SPlatformException(e.code).message;
    } catch (e) {
      throw SLoaders.errorSnackBar(
          title: 'Oh No!', message: 'Something went wrong. Please try again');
    }
  }

  ///[EmailAuthentication] login
  Future<UserCredential> loginWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw SFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw SFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw SFormatException();
    } on PlatformException catch (e) {
      throw SPlatformException(e.code).message;
    } catch (e) {
      throw SLoaders.errorSnackBar(
          title: 'Oh No!', message: 'Something went wrong. Please try again');
    }
  }

  ///[email verification]
  Future<void> sendEmailVerification() async {
    try {
      await _firebaseAuth.currentUser?.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      throw SFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw SFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw SFormatException();
    } on PlatformException catch (e) {
      throw SPlatformException(e.code).message;
    } catch (e) {
      throw SLoaders.errorSnackBar(
          title: 'Oh No!', message: 'Something went wrong. Please try again');
    }
  }

  ///google authentication
  Future<UserCredential?> signInWithGoogle() async {
    try {
      //trigger google authentication flow
      final GoogleSignInAccount? userAccount = await GoogleSignIn().signIn();

      //get authentication details
      final GoogleSignInAuthentication? googleSignInAuthentication =
          await userAccount?.authentication;

      //create user credentials
      final credentials = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication?.accessToken,
          idToken: googleSignInAuthentication?.idToken);
      //return credentials once sign
      return await _firebaseAuth.signInWithCredential(credentials);
    } on FirebaseAuthException catch (e) {
      throw SFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw SFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw SFormatException();
    } on PlatformException catch (e) {
      throw SPlatformException(e.code).message;
    } catch (e) {
      if (kDebugMode) print('Something went wrong. Please try again');
      return null;
    }
  }

  ///logout user
  Future<void> logout() async {
    try {
      await GoogleSignIn().signOut();
      await FirebaseAuth.instance.signOut();
      Get.offAll(() => const LoginScreen());
      SLoaders.successSnackBar(message: "You're logged out", title: 'Success');
    } on FirebaseAuthException catch (e) {
      throw SFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw SFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw SFormatException();
    } on PlatformException catch (e) {
      throw SPlatformException(e.code).message;
    } catch (e) {
      throw SLoaders.errorSnackBar(
          title: 'Oh No!', message: 'Something went wrong. Please try again');
    }
  }

  /// recover password [EMAIL AUTHENTICATION]
  Future<void> sendResetPasswordEmail(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw SFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw SFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw SFormatException();
    } on PlatformException catch (e) {
      throw SPlatformException(e.code).message;
    } catch (e) {
      throw SLoaders.errorSnackBar(
          title: 'Oh No!', message: 'Something went wrong. Please try again');
    }
  }

  ///Delete user
  Future<void> deleteAccount() async {
    try {
      await UserRepository.instance
          .removeUserData(_firebaseAuth.currentUser!.uid);
      await _firebaseAuth.currentUser?.delete();
    } on FirebaseAuthException catch (e) {
      throw SFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw SFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw SFormatException();
    } on PlatformException catch (e) {
      throw SPlatformException(e.code).message;
    } catch (e) {
      throw SLoaders.errorSnackBar(
          title: 'Oh No!', message: 'Something went wrong. Please try again');
    }
  }

  /// [ReAuthenticate User]
  Future<void> reAuthenticateWithEmailAndPassword(
      String email, String password) async {
    try {
      ///create credentials
      AuthCredential credential =
          EmailAuthProvider.credential(email: email, password: password);

      await _firebaseAuth.currentUser!.reauthenticateWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      throw SFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw SFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw SFormatException();
    } on PlatformException catch (e) {
      throw SPlatformException(e.code).message;
    } catch (e) {
      throw SLoaders.errorSnackBar(
          title: 'Oh No!', message: 'Something went wrong. Please try again');
    }
  }

  ///Upload Images
  Future<String> uploadImage(String path, XFile image) async {
    try {
      final ref = FirebaseStorage.instance.ref(path).child(image.name);
      await ref.putFile(File(image.path));
      final url = await ref.getDownloadURL();
      return url;
    } on FirebaseAuthException catch (e) {
      throw SFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw SFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw SFormatException();
    } on PlatformException catch (e) {
      throw SPlatformException(e.code).message;
    } catch (e) {
      throw SLoaders.errorSnackBar(
          title: 'Oh No!', message: 'Something went wrong. Please try again');
    }
  }
}
