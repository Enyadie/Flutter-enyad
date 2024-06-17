import '../popups/loaders.dart';

class SFirebaseException implements Exception {
  final String code;

  SFirebaseException(this.code);

  String get message {
    switch (code) {
      case 'aborted':
        return SLoaders.errorSnackBar(
            title: 'aborted', message: 'The operation was aborted.');
      case 'already-exists':
        return SLoaders.errorSnackBar(
            title: 'already-exists', message: 'The resource already exists.');
      case 'cancelled':
        return SLoaders.errorSnackBar(
            title: 'cancelled', message: 'The operation was cancelled.');
      case 'data-loss':
        return SLoaders.errorSnackBar(
            title: 'data-loss',
            message: 'Unrecoverable data loss or corruption.');
      case 'deadline-exceeded':
        return SLoaders.errorSnackBar(
            title: 'deadline-exceeded',
            message: 'The operation took too long to complete.');
      case 'failed-precondition':
        return SLoaders.errorSnackBar(
            title: 'failed-precondition',
            message:
                'The operation was rejected because the system is not in a state required for the operation\'s execution.');
      case 'internal':
        return SLoaders.errorSnackBar(
            title: 'internal', message: 'An internal error occurred.');
      case 'invalid-argument':
        return SLoaders.errorSnackBar(
            title: 'invalid-argument',
            message: 'The provided argument is invalid.');
      case 'not-found':
        return SLoaders.errorSnackBar(
            title: 'not-found',
            message: 'The requested resource was not found.');
      case 'out-of-range':
        return SLoaders.errorSnackBar(
            title: 'out-of-range',
            message: 'The operation was attempted past the valid range.');
      case 'resource-exhausted':
        return SLoaders.errorSnackBar(
            title: 'resource-exhausted',
            message: 'The resource has been exhausted.');
      case 'unauthenticated':
        return SLoaders.errorSnackBar(
            title: 'unauthenticated',
            message:
                'The request does not have valid authentication credentials.');
      case 'unavailable':
        return SLoaders.errorSnackBar(
            title: 'unavailable',
            message: 'The service is currently unavailable.');
      case 'unimplemented':
        return SLoaders.errorSnackBar(
            title: 'unimplemented',
            message: 'The operation is not implemented or supported.');
      case 'unknown':
        return SLoaders.errorSnackBar(
            title: 'unknown', message: 'An unknown error occurred.');
      default:
        return '';
    }
  }
}
