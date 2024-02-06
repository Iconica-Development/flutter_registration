// SPDX-FileCopyrightText: 2024 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

import 'package:flutter/material.dart';
import 'package:flutter_input_library/flutter_input_library.dart';
import 'package:flutter_registration/flutter_registration.dart';

class AuthPassField extends AuthField {
  AuthPassField({
    required super.name,
    TextEditingController? textEditingController,
    super.title,
    super.validators = const [],
    super.value = '',
    this.textStyle,
    this.onChange,
    this.textFieldDecoration,
  });

  final TextStyle? textStyle;
  final Function(String value)? onChange;
  final InputDecoration? textFieldDecoration;

  @override
  Widget build() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FlutterFormInputPassword(
        style: textStyle,
        decoration: textFieldDecoration,
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
      ),
    );
  }
}
