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
    this.textEditingController,
    this.textStyle,
    this.onChange,
    this.textFieldDecoration,
    this.padding = const EdgeInsets.all(8.0),
  });

  final TextEditingController? textEditingController;
  final TextStyle? textStyle;
  final Function(String value)? onChange;
  final InputDecoration? textFieldDecoration;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context, Function onValueChanged) {
    return Padding(
      padding: padding,
      child: TextFormField(
        style: textStyle,
        decoration: textFieldDecoration,
        controller: textEditingController,
        initialValue: textEditingController == null ? value : null,
        onChanged: (v) {
          value = v;
          onChange?.call(value);
          onValueChanged(v);
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
