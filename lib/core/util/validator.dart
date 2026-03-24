import 'package:easy_localization/easy_localization.dart';

abstract class Validator {
  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'validators.email.empty'.tr();
    }

    final emailRegExp = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    if (!emailRegExp.hasMatch(value.trim())) {
      return 'validators.email.invalid'.tr();
    }
    return null;
  }

  static String? validateRegisterPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'validators.password.empty'.tr();
    }

    final passwordRegExp = RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d).{8,}$');

    if (!passwordRegExp.hasMatch(value)) {
      return 'validators.password.invalid_register'.tr();
    }
    return null;
  }

  static String? validateLoginPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'validators.password.empty'.tr();
    }

    final passwordRegExp = RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d).{8,}$');

    if (!passwordRegExp.hasMatch(value)) {
      return 'validators.password.invalid_login'.tr();
    }
    return null;
  }

  static String? validateConfirmPassword(
    String? value,
    String originalPassword,
  ) {
    if (value == null || value.isEmpty) {
      return 'validators.confirm_password.empty'.tr();
    }
    if (value != originalPassword) {
      return 'validators.confirm_password.mismatch'.tr();
    }
    return null;
  }

  static String? validateCompanyName(String? value) {
    if (value == null || value.isEmpty) {
      return 'validators.company_name.empty'.tr();
    }
    final companyRegExp = RegExp(r'\p{L}{2,}', unicode: true);
    if (!companyRegExp.hasMatch(value)) {
      return 'validators.company_name.invalid'.tr();
    }
    return null;
  }

  static String? validateFullName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'validators.full_name.empty'.tr();
    }

    final nameRegExp = RegExp(r'^\p{L}{2,}\s\p{L}{2,}$', unicode: true);

    if (!nameRegExp.hasMatch(value.trim())) {
      return 'validators.full_name.invalid'.tr();
    }
    return null;
  }

  static String? validateHobby(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'validators.hobby.empty'.tr();
    }

    final hobbyRegExp = RegExp(
      r'^[\p{L}\p{N}\s]+(?:,[\p{L}\p{N}\s]+)*$', 
      unicode: true,
    );

    if (!hobbyRegExp.hasMatch(value.trim())) {
      return 'validators.hobby.invalid'.tr();
    }
    return null;
  }

  static String? validateAnimal(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'validators.animal.empty'.tr();
    }

    final animalRegExp = RegExp(
      r'^[\p{L}\p{N}\s]+(?:,[\p{L}\p{N}\s]+)*$', 
      unicode: true,
    );

    if (!animalRegExp.hasMatch(value.trim())) {
      return 'validators.animal.invalid'.tr();
    }
    return null;
  }

  static String? validateInviteKey(String? value) {
    if (value == null || value.isEmpty) {
      return 'validators.invite_key.empty'.tr();
    }

    final inviteRegExp = RegExp(r'^[a-fA-F0-9]{64}$');

    if (!inviteRegExp.hasMatch(value)) {
      return 'validators.invite_key.invalid'.tr();
    }
    return null;
  }

  static String? validateDepartmentName(String? value) {
    if (value == null || value.isEmpty) {
      return 'validators.department_name.empty'.tr();
    }
    
    final departmentRegExp = RegExp(r'^[\p{L}\p{N}\s]+$', unicode: true);
    
    if (!departmentRegExp.hasMatch(value)) {
      return 'validators.department_name.invalid'.tr();
    }
    return null;
  }
}