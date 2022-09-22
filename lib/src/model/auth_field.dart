import 'package:flutter/material.dart';

abstract class AuthField {
  AuthField({
    required this.name,
    required this.title,
    this.obscureText = false,
    this.validators = const [],
    this.value = '',
  });

  final String name;
  final String title;
  final bool obscureText;
  List<String? Function(String?)> validators;
  String value;

  Widget build();
}
