// SPDX-FileCopyrightText: 2022 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

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
        registrationSteps: RegistrationOptions.getDefaultSteps(),
        afterRegistration: () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) {
                return const ProtectedScreen();
              },
            ),
          );
        },
      ),
    );
  }
}

class ProtectedScreen extends StatelessWidget {
  const ProtectedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Demo'),
      ),
      body: const Center(
        child: Text('Registration succesful'),
      ),
    );
  }
}
