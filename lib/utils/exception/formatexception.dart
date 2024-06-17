import '../popups/loaders.dart';

class SFormatException implements Exception {
  String message;

  SFormatException(
      [this.message =
          "An unexpected format error occurred. Please check your input."]);

  factory SFormatException.fromMessage(String message) {
    return SFormatException(message);
  }

  /// Get the error message.
  String get formattedMessage => message;

  factory SFormatException.fromCode(String code) {
    switch (code) {
      case 'invalid-email-format':
        return SLoaders.errorSnackBar(
            title: 'invalid-email-format',
            message:
                'The email address is invalid. Please enter a valid email.');
      case 'invalid-phone-format':
        return SLoaders.errorSnackBar(
            title: 'invalid-phone-format',
            message:
                'The phone number is invalid. Please enter a valid phone number.');
      case 'invalid-date-format':
        return SLoaders.errorSnackBar(
            title: 'invalid-date-format',
            message: 'The date format is invalid. Please enter a valid date.');
      case 'invalid-json-format':
        return SLoaders.errorSnackBar(
            title: 'invalid-json-format',
            message: 'The JSON format is invalid. Please enter valid JSON.');
      case 'invalid-url-format':
        return SLoaders.errorSnackBar(
            title: 'invalid-url-format',
            message: 'The URL format is invalid. Please enter a valid URL.');
      case 'invalid-credit-card-format':
        return SLoaders.errorSnackBar(
            title: 'invalid-credit-card-format',
            message:
                'The credit card number is invalid. Please enter a valid credit card number.');
      case 'invalid-ipv4-format':
        return SLoaders.errorSnackBar(
            title: 'invalid-ipv4-format',
            message: 'The IPv4 address format is invalid.');
      case 'invalid-ipv6-format':
        return SLoaders.errorSnackBar(
            title: 'invalid-ipv6-format',
            message: 'The IPv6 address format is invalid.');
      case 'invalid-username-format':
        return SLoaders.errorSnackBar(
            title: 'invalid-username-format',
            message:
                'The username format is invalid. Please enter a valid username.');
      case 'invalid-password-format':
        return SLoaders.errorSnackBar(
            title: 'invalid-password-format',
            message:
                'The password format is invalid. Please enter a valid password.');
      case 'invalid-credit-card-expiration-date-format':
        return SLoaders.errorSnackBar(
            title: 'invalid-credit-card-expiration-date-format',
            message:
                'The credit card expiration date format is invalid. Please enter a valid expiration date.');
      default:
        return SFormatException();
    }
  }
}
