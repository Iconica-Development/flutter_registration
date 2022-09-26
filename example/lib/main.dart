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
      registrationOptions: RegistrationOptions(
        registrationRepository: ExampleRegistrationRepository(),
        registrationSteps: RegistrationOptions.defaultSteps,
        afterRegistration: () {
          debugPrint('Registered!');
        },
      ),
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
