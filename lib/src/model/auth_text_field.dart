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
    this.obscureText = false,
    this.hintText,
    this.label,
    this.textStyle,
    this.onChange,
    this.hidden,
    this.onPassChanged,
  }) {
    textController =
        textEditingController ?? TextEditingController(text: value);
  }

  late TextEditingController textController;
  final bool obscureText;
  final String? hintText;
  final Widget? label;
  final TextStyle? textStyle;
  final Function(String value)? onChange;
  final bool? hidden;
  final Function(bool value)? onPassChanged;

  @override
  Widget build() {
    Widget? suffix;

    if (hidden != null) {
      if (hidden!) {
        suffix = GestureDetector(
          onTap: () {
            onPassChanged?.call(!hidden!);
          },
          child: const Icon(Icons.visibility),
        );
      } else {
        suffix = GestureDetector(
          onTap: () {
            onPassChanged?.call(!hidden!);
          },
          child: const Icon(Icons.visibility_off),
        );
      }
    }

    return TextFormField(
      style: textStyle,
      decoration: InputDecoration(
        label: label,
        hintText: hintText,
        suffix: suffix,
      ),
      controller: textController,
      obscureText: hidden ?? obscureText,
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
}
