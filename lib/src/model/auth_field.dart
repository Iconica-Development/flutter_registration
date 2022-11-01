// SPDX-FileCopyrightText: 2022 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

import 'package:flutter/material.dart';

abstract class AuthField {
  AuthField({
    required this.name,
    required this.title,
    this.validators = const [],
    this.value = '',
  });

  final String name;
  final String title;
  List<String? Function(String?)> validators;
  String value;

  Widget build();
}
