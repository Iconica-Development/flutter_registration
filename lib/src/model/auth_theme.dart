import 'package:flutter/material.dart';

class AuthTheme extends InheritedWidget {
  const AuthTheme({
    required this.backgroundColor,
    required this.buttonStyle,
    required super.child,
    super.key,
  });

  /// The background color of the auth screen.
  final Color backgroundColor;

  final ButtonStyle? buttonStyle;

  static AuthTheme of(BuildContext context) {
    var result = context.dependOnInheritedWidgetOfExactType<AuthTheme>();
    assert(result != null, 'No AuthTheme found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    throw UnimplementedError();
  }
}
