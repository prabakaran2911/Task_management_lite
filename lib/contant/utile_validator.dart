import 'package:task_mngmt/contant/utile_constant.dart';

class Validators {
  static String? required(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  static String? email(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < AppConstants.minPasswordLength) {
      return 'Password must be at least ${AppConstants.minPasswordLength} characters';
    }
    return null;
  }

  static String? title(String? value) {
    if (value == null || value.isEmpty) {
      return 'Title is required';
    }
    if (value.length > AppConstants.maxTitleLength) {
      return 'Title cannot exceed ${AppConstants.maxTitleLength} characters';
    }
    return null;
  }

  static String? description(String? value) {
    if (value == null || value.isEmpty) {
      return 'Description is required';
    }
    if (value.length > AppConstants.maxDescriptionLength) {
      return 'Description cannot exceed ${AppConstants.maxDescriptionLength} characters';
    }
    return null;
  }

  static String? date(DateTime? value) {
    if (value == null) {
      return 'Date is required';
    }
    if (value.isBefore(DateTime.now())) {
      return 'Date cannot be in the past';
    }
    return null;
  }

  // Fixed return type to String? instead of String
  static String? Function(String?) confirmPassword(String password) {
    return (String? confirmPassword) {
      if (confirmPassword == null || confirmPassword.isEmpty) {
        return 'Please confirm your password';
      }
      if (confirmPassword != password) {
        return 'Passwords do not match';
      }
      return null;
    };
  }
}
