import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_registration/flutter_registration.dart';
import 'package:flutter_registration/src/auth_screen.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({
    required this.registrationOptions,
    super.key,
  });

  final RegistrationOptions registrationOptions;

  @override
  Widget build(BuildContext context) {
    var translations = registrationOptions.registrationTranslations;

    void register({
      required HashMap<String, String> values,
      required VoidCallback onError,
    }) =>
        registrationOptions.registrationRepository.register(values).then(
          (response) {
            if (response) {
              registrationOptions.afterRegistration();
            }
          },
        ).catchError((_) {
          onError();
        });

    return AuthScreen(
      steps: registrationOptions.registrationSteps,
      onFinish: register,
      title: translations.title,
      submitBtnTitle: translations.registerBtn,
      nextBtnTitle: translations.nextStepBtn,
      previousBtnTitle: translations.previousStepBtn,
    );
  }
}
