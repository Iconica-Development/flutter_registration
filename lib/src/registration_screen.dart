import 'package:flutter/material.dart';
import 'package:flutter_registration/flutter_registration.dart';
import 'package:flutter_registration/src/auth_screen.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({
    required this.afterRegistration,
    required this.repository,
    this.additionalSteps = const [],
    super.key,
  });

  final VoidCallback afterRegistration;
  final RegistrationRepository repository;
  final List<AuthStep> additionalSteps;

  @override
  Widget build(BuildContext context) {
    void showError(String error) => showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            content: Text(error),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'Sluit'),
                child: const Text('Sluit'),
              ),
            ],
          ),
        );

    void register(values) => repository
            .register(values)
            .then(
              (value) => afterRegistration(),
            )
            .catchError(
          (error) {
            showError(
              error.toString(),
            );
          },
        );

    return AuthScreen(
      title: 'Registreren',
      submitBtnTitle: 'Registreren',
      steps: [
        AuthStep(
          fields: [
            AuthTextField(
              name: 'email',
              title: 'Wat is je e-mailadres?',
              validators: [
                (email) => (email == null || email.isEmpty)
                    ? 'Geef uw e-mailadres op'
                    : null,
                (email) =>
                    RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(email!)
                        ? null
                        : 'Geef een geldig e-mailadres op',
              ],
            )
          ],
        ),
        AuthStep(
          fields: [
            AuthTextField(
              name: 'password',
              title: 'Kies een wachtwoord',
              obscureText: true,
              validators: [
                (value) => (value == null || value.isEmpty)
                    ? 'Geef een wachtwoord op'
                    : null,
              ],
            ),
          ],
        ),
        ...additionalSteps
      ],
      onFinish: register,
    );
  }
}
