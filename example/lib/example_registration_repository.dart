import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_registration/flutter_registration.dart';

class ExampleRegistrationRepository with RegistrationRepository {
  @override
  Future<bool> register(HashMap values) {
    debugPrint('register: $values');
    return Future.value(true);
  }
}
