import 'package:flutter/material.dart';

class AuthAction {
  AuthAction({
    required this.title,
    required this.onPress,
  });

  final String title;
  final VoidCallback onPress;
}
