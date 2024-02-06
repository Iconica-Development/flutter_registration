// SPDX-FileCopyrightText: 2022 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_registration/flutter_registration.dart';
import 'example_registration_repository.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(
        inputDecorationTheme: const InputDecorationTheme(
          errorStyle: TextStyle(color: Colors.red),
        ),
      ),
      home: const FlutterRegistrationDemo(),
    ),
  );
}

class FlutterRegistrationDemo extends StatefulWidget {
  const FlutterRegistrationDemo({Key? key}) : super(key: key);

  @override
  State<FlutterRegistrationDemo> createState() =>
      _FlutterRegistrationDemoState();
}

class _FlutterRegistrationDemoState extends State<FlutterRegistrationDemo> {
  late List<AuthStep> steps;

  @override
  void initState() {
    super.initState();

    steps = RegistrationOptions.getDefaultSteps();

    steps[1].fields.add(
          AuthBoolField(
            name: 'termsConditions',
            widgetType: BoolWidgetType.checkbox,
            validators: [
              (value) {
                if (value == null || !value) {
                  return 'Required';
                }

                return null;
              },
            ],
            rightWidget: Text.rich(
              TextSpan(
                text: 'I agree with the ',
                children: <TextSpan>[
                  TextSpan(
                    text: 'terms & conditions',
                    style: const TextStyle(
                      decoration: TextDecoration.underline,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        debugPrint('Open terms and conditions');
                      },
                  ),
                ],
              ),
            ),
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return RegistrationScreen(
      registrationOptions: RegistrationOptions(
        previousButtonBuilder: (onPressed, label) => null,
        registrationRepository: ExampleRegistrationRepository(),
        registrationSteps: steps,
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
