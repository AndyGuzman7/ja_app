import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:form_field_validator/form_field_validator.dart';

class Validators extends FormBuilderValidators {
  static requiredv2<T>({
    String? errorText,
  }) {
    return (T? valueCandidate) {
      if (valueCandidate == null ||
          (valueCandidate is String && valueCandidate.trim().isEmpty) ||
          (valueCandidate is Iterable && valueCandidate.isEmpty) ||
          (valueCandidate is Map && valueCandidate.isEmpty)) {
        return errorText ?? FormBuilderLocalizations.current.requiredErrorText;
      }
      return null;
    };
  }

  static emailV2({
    String? errorText,
  }) =>
      (valueCandidate) => (valueCandidate?.isNotEmpty ?? false) &&
              !isValidEmail(valueCandidate!)
          ? errorText ?? FormBuilderLocalizations.current.emailErrorText
          : null;

  static bool isValidEmail(String text) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(text);
  }
}
