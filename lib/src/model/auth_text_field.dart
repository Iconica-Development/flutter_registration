// SPDX-FileCopyrightText: 2022 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

import 'package:flutter/material.dart';
import 'package:flutter_registration/flutter_registration.dart';

/// A field for capturing text inputs in a Flutter form.
///
/// Extends [AuthField].
class AuthTextField extends AuthField {
  /// Constructs an [AuthTextField] object.
  ///
  /// [name] specifies the name of the field.
  ///
  /// [textEditingController] controller for the text input (optional).
  ///
  /// [title] specifies the title widget of the field (optional).
  ///
  /// [validators] defines a list of validation functions for the field (optional).
  ///
  /// [value] specifies the initial value of the field (default is an empty string).
  ///
  /// [textStyle] defines the text style for the text input.
  ///
  /// [onChange] is a callback function triggered when the value of the field changes.
  ///
  /// [textFieldDecoration] defines the decoration for the text input field (optional).
  ///
  /// [padding] defines the padding around the text input field (default is EdgeInsets.all(8.0)).
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
