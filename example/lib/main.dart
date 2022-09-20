import 'package:flutter/material.dart';
import 'package:flutter_registration/flutter_registration.dart';
import 'example_registration_repository.dart';

void main() {
  runApp(
    const MaterialApp(
      home: FlutterRegistrationDemo(),
    ),
  );
}

class FlutterRegistrationDemo extends StatelessWidget {
  const FlutterRegistrationDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RegistrationScreen(
      afterRegistration: () {
        debugPrint('Registered!');
      },
      repository: ExampleRegistrationRepository(),
    );
  }
}

class ProtectedScreen extends StatelessWidget {
  const ProtectedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('FlutterRegistrationDemo'),
      ),
    );
  }
}
