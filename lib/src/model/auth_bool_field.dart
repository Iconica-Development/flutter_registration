// SPDX-FileCopyrightText: 2022 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

import 'package:flutter/material.dart';
import 'package:flutter_input_library/flutter_input_library.dart';
import 'package:flutter_registration/flutter_registration.dart';

class AuthBoolField extends AuthField {
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
