class Validator {
  static String? validateField(String? value, String fieldType,
      {String? password}) {
    if (value == null || value.trim().isEmpty) {
      return _getEmptyMessage(fieldType);
    }

    switch (fieldType) {
      case 'name':
        if (!RegExp(r'^[a-zA-Z0-9\u0600-\u06FF\s]+$').hasMatch(value)) {
          return 'Name should contain only letters, numbers (Arabic or English)';
        }
        break;

      case 'email':
        if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
            .hasMatch(value)) {
          return 'Enter a valid email address';
        }
        break;

      case 'password':
      case 'new password':
        if (value.length < 8) {
          return 'Password must be at least 8 characters long';
        }
        // ✅ At least one uppercase, one number, and no special chars
        if (!RegExp(r'^(?=.*[A-Z])(?=.*\d)[A-Za-z\d]+$').hasMatch(value)) {
          return 'Password must contain at least one uppercase letter and one number.\nSpecial characters are not allowed.';
        }
        break;

      case 'old password':
        if (password == null || value != password) {
          return 'Password is incorrect';
        }
        break;

      case 'confirmPassword':
        if (password == null || value != password) {
          return 'Passwords do not match';
        }
        break;

      case 'phone':
        if (!RegExp(r'^01\d{9}$').hasMatch(value)) {
          return 'Enter a valid 11-digit phone number';
        }
        break;
        case 'address':
      if (value.length < 5) {
        return 'Address should be at least 5 characters';
      }
      break;

    case 'bio':
      if (value.length > 150) {
        return 'Bio should not exceed 150 characters';
      }
      break;
    }

    return null;
  }

  static String _getEmptyMessage(String fieldType) {
    return 'Please enter your $fieldType';
  }
}
