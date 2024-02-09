// SPDX-FileCopyrightText: 2022 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

import 'package:flutter/material.dart';
import 'package:flutter_registration/flutter_registration.dart';

class AuthTextField extends AuthField {
  AuthTextField({
    required super.name,
    TextEditingController? textEditingController,
    super.title,
    super.validators = const [],
    super.value = '',
    this.textStyle,
    this.onChange,
    this.textFieldDecoration,
    this.padding = const EdgeInsets.all(8.0),
  }) {
    textController =
        textEditingController ?? TextEditingController(text: value);
  }

  late TextEditingController textController;
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
        controller: textController,
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
