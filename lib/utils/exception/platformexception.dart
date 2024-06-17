import '../popups/loaders.dart';

class SPlatformException implements Exception {
  final String code;

  SPlatformException(this.code);

  String get message {
    switch (code) {
      case 'INVALID_LOGIN_CREDENTIALS':
        return SLoaders.errorSnackBar(
            title: 'INVALID_LOGIN_CREDENTIALS',
            message: 'Invalid login credentials. Check your information.');
      case 'NETWORK_ERROR':
        return SLoaders.errorSnackBar(
            title: 'NETWORK_ERROR',
            message:
                'A network error occurred. Please check your internet connection.');
      case 'PERMISSION_DENIED':
        return SLoaders.errorSnackBar(
            title: 'PERMISSION_DENIED',
            message:
                'Permission denied. You do not have the required permissions.');
      case 'UNKNOWN_ERROR':
        return SLoaders.errorSnackBar(
            title: 'UNKNOWN_ERROR',
            message: 'An unknown error occurred. Please try again later.');
      case 'USER_NOT_FOUND':
        return SLoaders.errorSnackBar(
            title: 'USER_NOT_FOUND',
            message: 'User not found. Please check your account information.');
      case 'FILE_NOT_FOUND':
        return SLoaders.errorSnackBar(
            title: 'FILE_NOT_FOUND',
            message: 'File not found. Please check the file path.');
      case 'SERVICE_UNAVAILABLE':
        return SLoaders.errorSnackBar(
            title: 'SERVICE_UNAVAILABLE',
            message:
                'The service is currently unavailable. Please try again later.');
      default:
        return SLoaders.errorSnackBar(
            title: 'PLATFORM_ERROR', message: 'Platform error: $code');
    }
  }
}
