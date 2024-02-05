// SPDX-FileCopyrightText: 2022 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

import 'package:flutter/material.dart';

abstract class AuthField<T> {
  AuthField({
    required this.name,
    this.title,
    this.validators = const [],
    required this.value,
  });

  final String name;
  final Widget? title;
  List<String? Function(T?)> validators;
  T value;

  Widget build();
}
