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

    void showError(String error) => showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            content: Text(error),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(
                  context,
                  translations.closeBtn,
                ),
                child: Text(
                  translations.closeBtn,
                ),
              ),
            ],
          ),
        );

    void register(values) => registrationOptions.registrationRepository
            .register(values)
            .then(
              (_) => registrationOptions.afterRegistration(),
            )
            .catchError(
          (error) {
            showError(
              error.toString(),
            );
          },
        );

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
