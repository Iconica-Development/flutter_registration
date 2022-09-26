import 'package:flutter/material.dart';
import 'package:flutter_registration/flutter_registration.dart';

class AuthTextField extends AuthField {
  AuthTextField({
    required super.name,
    required super.title,
    super.validators = const [],
    super.value = '',
    this.obscureText = false,
    this.hintText,
  }) {
    _textEditingController = TextEditingController();
  }

  late TextEditingController _textEditingController;
  final bool obscureText;
  final String? hintText;

  @override
  Widget build() => TextFormField(
        decoration: InputDecoration(
          hintText: hintText,
        ),
        controller: _textEditingController,
        obscureText: obscureText,
        onChanged: (v) {
          value = v;
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
