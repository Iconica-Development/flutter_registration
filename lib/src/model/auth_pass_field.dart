// SPDX-FileCopyrightText: 2024 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

import 'package:flutter/material.dart';
import 'package:flutter_input_library/flutter_input_library.dart';
import 'package:flutter_registration/flutter_registration.dart';

/// A field for capturing password inputs in a Flutter form.
///
/// Extends [AuthField].
class AuthPassField extends AuthField {
  /// Constructs an [AuthPassField] object.
  ///
  /// [name] specifies the name of the field.
  ///
  /// [textEditingController] controller for the password input (optional).
  ///
  /// [title] specifies the title widget of the field (optional).
  ///
  /// [validators] defines a list of validation functions for the field (optional).
  ///
  /// [value] specifies the initial value of the field (default is an empty string).
  ///
  /// [textStyle] defines the text style for the password input.
  ///
  /// [onChange] is a callback function triggered when the value of the field changes.
  ///
  /// [iconSize] specifies the size of the icon displayed with the password input (optional).
  ///
  /// [textFieldDecoration] defines the decoration for the password input field (optional).
  ///
  /// [padding] defines the padding around the password input field (default is EdgeInsets.all(8.0)).
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
