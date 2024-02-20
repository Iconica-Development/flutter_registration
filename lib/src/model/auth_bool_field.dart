// SPDX-FileCopyrightText: 2022 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

import 'package:flutter/material.dart';
import 'package:flutter_input_library/flutter_input_library.dart';
import 'package:flutter_registration/flutter_registration.dart';

/// A field for capturing boolean values in a Flutter form.
///
/// Extends [AuthField].
class AuthBoolField extends AuthField {
  /// Constructs an [AuthBoolField] object.
  ///
  /// [name] specifies the name of the field.
  ///
  /// [widgetType] defines the type of boolean widget to use.
  ///
  /// [title] specifies the title of the field (optional).
  ///
  /// [validators] defines a list of validation functions for the field.
  ///
  /// [value] specifies the initial value of the field (default is false).
  ///
  /// [leftWidget] is a widget to be displayed on the left side of the boolean widget.
  ///
  /// [rightWidget] is a widget to be displayed on the right side of the boolean widget.
  ///
  /// [onChange] is a callback function triggered when the value of the field changes.
  AuthBoolField({
    required super.name,
    required this.widgetType,
    super.title,
    super.validators = const [],
    super.value = false,
    this.leftWidget,
    this.rightWidget,
    this.onChange,
  });

  final Widget? leftWidget;
  final Widget? rightWidget;
  final BoolWidgetType widgetType;
  final Function(String value)? onChange;

  @override
  Widget build(BuildContext context, Function onValueChanged) {
    return FlutterFormInputBool(
      widgetType: widgetType,
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
      leftWidget: leftWidget,
      rightWidget: rightWidget,
    );
  }
}
