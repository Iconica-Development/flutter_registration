// SPDX-FileCopyrightText: 2022 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

import 'package:flutter/material.dart';
import 'package:flutter_registration/flutter_registration.dart';

class AuthTextField extends AuthField {
  AuthTextField({
    required super.name,
    super.title,
    super.validators = const [],
    super.value = '',
    this.obscureText = false,
    this.hintText,
    this.label,
    this.textStyle,
    this.onChange,
  }) {
    _textEditingController = TextEditingController(text: value);
  }

  late TextEditingController _textEditingController;
  final bool obscureText;
  final String? hintText;
  final Widget? label;
  final TextStyle? textStyle;
  final Function(String value)? onChange;

  @override
  Widget build() => TextFormField(
        style: textStyle,
        decoration: InputDecoration(
          label: label,
          hintText: hintText,
        ),
        controller: _textEditingController,
        obscureText: obscureText,
        onChanged: (v) {
          value = v;
          onChange?.call(value);
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
