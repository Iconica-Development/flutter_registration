import 'package:flutter/widgets.dart';
import 'package:flutter_registration/flutter_registration.dart';

class RegistrationOptions {
  RegistrationOptions({
    required this.registrationRepository,
    required this.registrationSteps,
    required this.afterRegistration,
    this.registrationTranslations = const RegistrationTranslations(),
  });

  final RegistrationTranslations registrationTranslations;
  final List<AuthStep> registrationSteps;
  final VoidCallback afterRegistration;
  final RegistrationRepository registrationRepository;

  static List<AuthStep> get defaultSteps => [
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
      ];
}
