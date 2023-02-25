import 'package:email_validator/email_validator.dart';

class InputValidator {
  InputValidator._();

  static String? text(String? value) {
    if (value?.trim().isEmpty ?? true) {
      return 'Field cannot be empty';
    }
    return null;
  }

  static String? email(String? value) {
    if (value?.trim().isEmpty ?? true) {
      return 'Email cannot be empty';
    }
    if (!EmailValidator.validate(value!)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  static String? password(String? value) {
    if (value?.isEmpty ?? true) {
      return 'Password cannot be empty';
    }
    return null;
  }

  static String? confirmPassword(String? value, String? password) {
    if (password?.isEmpty ?? true) {
      return 'Password cannot be empty';
    }
    if (password != value) {
      return 'Passwords don\'t match';
    }
    return null;
  }
}
