import 'package:flutter/material.dart';
import 'package:flutter_registration/flutter_registration.dart';

class AuthTextField extends AuthField {
  AuthTextField({
    required super.name,
    required super.title,
    super.validators = const [],
    super.value = '',
    this.obscureText = false,
  }) {
    _textEditingController = TextEditingController();
  }

  late TextEditingController _textEditingController;
  final bool obscureText;

  @override
  Widget build() => TextFormField(
        controller: _textEditingController,
        obscureText: obscureText,
        onChanged: (value) {
          value = value;
        },
        validator: (value) {
          for (var validator in validators) {
            var output = validator(value);
            if (output != null) {
              return output;
            }
          }

          return null;
        },
      );
}
