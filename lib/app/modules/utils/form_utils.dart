import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class FormUtils {
  FormUtils._();

  static String? emailValidation(String? value) {
    if (value == null || value == '') {
      return 'form.error.emailEmpty'.tr;
    }

    if (!GetUtils.isEmail(value)) {
      return 'form.error.emailNotValid'.tr;
    }

    return null;
  }

  static String? phoneValidation(String? value) {
    if (value == null || value == '') {
      return 'form.error.phoneEmpty'.tr;
    }

    if (value.length >= 17 ||
        value.length <= 7 ||
        !hasMatch(value, r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$')) {
      return 'form.error.phoneNotValid'.tr;
    }

    // if (!GetUtils.isPhoneNumber(value ?? '')) {}

    return null;
  }

  static bool hasMatch(String? value, String pattern) {
    return (value == null) ? false : RegExp(pattern).hasMatch(value);
  }

  static String? referralValidation(String? value) {
    if (!GetUtils.isEmail(value ?? '')) {
      return 'form.error.referralNotValid'.tr;
    }

    return null;
  }

  static String? passwordValidation(
    String? value, {
    int minLength = 4,
    bool withRegex = false,
  }) {
    if (value == null || value == '') {
      return 'Password tidak boleh kosong'.tr;
    }
    if (withRegex) {
      String upperCase = r'^(?=.*?[A-Z])';
      String lowerCase = r'^(?=.*?[a-z])';
      String numeric = r'^(?=.*?[0-9])';
      // String specialCharacter = r'^(?=.*?[!@#\$&*~])';
      String upperCheck =
          !RegExp(upperCase).hasMatch(value) ? 'upper case,' : '';
      String lowerCheck =
          !RegExp(lowerCase).hasMatch(value) ? 'lower case,' : '';
      String numericCheck = !RegExp(numeric).hasMatch(value) ? 'numeric,' : '';
      // String specialCheck =
      //     !RegExp(specialCharacter).hasMatch(value) ? 'special character' : '';
      if (upperCheck.isNotEmpty ||
              lowerCheck.isNotEmpty ||
              numericCheck.isNotEmpty
          // || specialCheck.isNotEmpty
          ) {
        // return '${"label.passwordRequired".tr} $upperCheck $lowerCheck $numericCheck $specialCheck'
        //     .replaceAll("  ", " ");
        return '${"label.passwordRequired".tr} $upperCheck $lowerCheck $numericCheck'
            .replaceAll("  ", " ");
      }
    }
    if (GetUtils.isLengthLessThan(value, minLength)) {
      return "Password minimal 6 karakter";
    }

    return null;
  }
}

class UpperCaseInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}

class RegExInputFormatter implements TextInputFormatter {
  final RegExp _regExp;

  RegExInputFormatter._(this._regExp);

  factory RegExInputFormatter.withRegex(String regexString) {
    final regex = RegExp(regexString);
    return RegExInputFormatter._(regex);
  }

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final oldValueValid = _isValid(oldValue.text);
    final newValueValid = _isValid(newValue.text);
    if (oldValueValid && !newValueValid) {
      return oldValue;
    }
    return newValue;
  }

  bool _isValid(String value) {
    try {
      final matches = _regExp.allMatches(value);
      for (final Match match in matches) {
        if (match.start == 0 && match.end == value.length) {
          return true;
        }
      }
      return false;
    } catch (e) {
      // Invalid regex
      assert(false, e.toString());
      return true;
    }
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
