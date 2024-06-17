import '../popups/loaders.dart';

class SFirebaseAuthException implements Exception {
  final String code;

  SFirebaseAuthException(this.code);

  String get message {
    switch (code) {
      case 'email-already-in-use':
        return SLoaders.errorSnackBar(
            title: 'email-already-in-use',
            message: 'The email address is already in use by another account.');
      case 'invalid-email':
        return SLoaders.errorSnackBar(
            title: 'invalid-email', message: 'The email address is not valid.');
      case 'weak-password':
        return SLoaders.errorSnackBar(
            title: 'weak-password',
            message: 'The password provided is too weak.');
      case 'user-disabled':
        return SLoaders.errorSnackBar(
            title: 'user-disabled',
            message: 'This user account has been disabled.');
      case 'user-not-found':
        return SLoaders.errorSnackBar(
            title: 'user-not-found', message: 'No user found with this email.');
      case 'WRONG_PASSWORD':
        return SLoaders.errorSnackBar(
            title: 'WRONG_PASSWORD', message: 'The password is incorrect.');
      case 'too-many-requests':
        return SLoaders.errorSnackBar(
            title: 'too-many-requests',
            message: 'Too many requests. Try again later.');
      case 'operation-not-allowed':
        return SLoaders.errorSnackBar(
            title: 'operation-not-allowed',
            message: 'This operation is not allowed. Please contact support.');
      case 'invalid-verification-code':
        return SLoaders.errorSnackBar(
            title: 'invalid-verification-code',
            message: 'The verification code is invalid.');
      case 'invalid-verification-id':
        return SLoaders.errorSnackBar(
            title: 'invalid-verification-id',
            message: 'The verification ID is invalid.');
      default:
        return SLoaders.errorSnackBar(
            title: 'Authentication error', message: code);
    }
  }
}
