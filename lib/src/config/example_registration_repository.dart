import "dart:collection";
import "package:flutter/material.dart";
import "package:flutter_registration/flutter_registration.dart";

/// A registration repository that does nothing.
class ExampleRegistrationRepository with RegistrationRepository {
  @override
  Future<String?> register(HashMap values) {
    debugPrint("register $values");
    return Future.value(null);
  }
}
