class SValidator {
  static String? validateEmptyText(String? fieldName, String? value) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required.';
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required.';
    }

    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-\.]+\.)+[\w-]{2,4}$');

    if (!emailRegExp.hasMatch(value)) {
      return 'Invalid email.';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password required.';
    }
    if (value.length < 7) {
      return 'Password must have at least 7 characters.';
    }
    if (!value.contains(RegExp(r'[a-zA-Z]'))) {
      return 'Password must contain a uppercase letter.';
    }
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least one number.';
    }
    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Password must contain a special character.';
    }
    return null;
  }

  static String? validatePhoneNumber(String? value) {
    final phoneRegExp = RegExp(r'^\d{10,}$');
    if (value == null || value.isEmpty) {
      return 'Phone number required.';
    }

    if (!phoneRegExp.hasMatch(value)) {
      return 'Invalid phone number format (require at least 10 digits).';
    }
    return null;
  }
}
