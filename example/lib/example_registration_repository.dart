// SPDX-FileCopyrightText: 2022 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_registration/flutter_registration.dart';

class ExampleRegistrationRepository with RegistrationRepository {
  @override
  Future<bool> register(HashMap values) async {
    debugPrint('register: $values');
    return true;
  }
}
