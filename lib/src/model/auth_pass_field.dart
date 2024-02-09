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
    this.iconSize,
    this.textFieldDecoration,
    this.padding = const EdgeInsets.all(8.0),
  });

  final TextStyle? textStyle;
  final double? iconSize;
  final Function(String value)? onChange;
  final InputDecoration? textFieldDecoration;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context, Function onValueChanged) {
    return Padding(
      padding: padding,
      child: FlutterFormInputPassword(
        style: textStyle,
        iconSize: iconSize ?? 24.0,
        decoration: textFieldDecoration,
        onChanged: (v) {
          value = v;
          onChange?.call(value);
          onValueChanged();
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
