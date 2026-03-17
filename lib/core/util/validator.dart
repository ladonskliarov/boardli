abstract class Validator {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'Email is required';
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegExp.hasMatch(value)) return 'Enter a valid email';
    return null;
  }

  static String? validateRegisterPassword(String? value) {
    if (value == null || value.isEmpty) return 'Password is required';

    final passwordRegExp = RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d).{8,}$');

    if (!passwordRegExp.hasMatch(value)) {
      return 'One uppercase, lowercase and number';
    }
    return null;
  }

  static String? validateLoginPassword(String? value) {
    if (value == null || value.isEmpty) return 'Password is required';

    final passwordRegExp = RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d).{8,}$');

    if (!passwordRegExp.hasMatch(value)) {
      return 'Please enter a valid password';
    }
    return null;
  }

  static String? validateConfirmPassword(
    String? value,
    String originalPassword,
  ) {
    if (value == null || value.isEmpty) return 'Please confirm your password';
    if (value != originalPassword) return 'Passwords do not match';
    return null;
  }

  static String? validateCompanyName(String? value) {
    if (value == null || value.isEmpty) return 'Company name is required';
    final companyRegExp = RegExp(r'\p{L}{2,}', unicode: true);
    if (!companyRegExp.hasMatch(value)) return 'Enter at least 2 characters';
    return null;
  }

  static String? validateFullName(String? value) {
    if (value == null || value.trim().isEmpty) return 'Full name is required';

    final nameRegExp = RegExp(r'^\p{L}{2,}\s\p{L}{2,}$', unicode: true);

    if (!nameRegExp.hasMatch(value.trim())) {
      return 'At least two words (min 2 characters each)';
    }
    return null;
  }

  static String? validateHobby(String? value) {
    if (value == null || value.isEmpty) return 'Please enter your hobbie';

    final hobbyRegExp = RegExp(r'^[\p{L}\p{N}\s,]+$');

    if (!hobbyRegExp.hasMatch(value)) {
      return 'Use only spaces or commas as separators';
    }
    return null;
  }

  static String? validateAnimal(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your favorite animal';
    }

    final hobbyRegExp = RegExp(r'^[\p{L}\p{N}\s,]+$');

    if (!hobbyRegExp.hasMatch(value)) {
      return 'Use only spaces or commas as separators';
    }
    return null;
  }

  static String? validateInviteKey(String? value) {
    if (value == null || value.isEmpty) return 'Please enter your invite key';

    final hobbyRegExp = RegExp(r'^[a-fA-F0-9]{64}$');

    if (!hobbyRegExp.hasMatch(value)) {
      return 'Enter a valid key';
    }
    return null;
  }
}
