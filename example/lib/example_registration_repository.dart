import 'package:flutter/material.dart';
import 'package:flutter_registration/flutter_registration.dart';

class ExampleRegistrationRepository with RegistrationRepository {
  @override
  Future<void> register(String email, String password) {
    debugPrint('register: $email $password');
    return Future.value(null);
  }
}
