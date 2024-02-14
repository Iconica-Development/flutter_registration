// SPDX-FileCopyrightText: 2022 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

import 'package:flutter/material.dart';

abstract class AuthField<T> {
  AuthField({
    required this.name,
    required this.value,
    this.onValueChanged,
    this.title,
    this.validators = const [],
  });

  final String name;
  final Widget? title;
  List<String? Function(T?)> validators;
  T value;

  final Function(T)? onValueChanged; // Callback for value changes

  Widget build(BuildContext context, Function onValueChanged);
}
