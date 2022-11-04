// SPDX-FileCopyrightText: 2022 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

import 'package:flutter/material.dart';
import 'package:flutter_registration/flutter_registration.dart';

class RegistrationOptions {
  RegistrationOptions({
    required this.registrationRepository,
    required this.registrationSteps,
    required this.afterRegistration,
    this.registrationTranslations = const RegistrationTranslations(),
    this.customAppbarBuilder,
  });

  final RegistrationTranslations registrationTranslations;
  final List<AuthStep> registrationSteps;
  final VoidCallback afterRegistration;
  final RegistrationRepository registrationRepository;
  final AppBar Function(String title)? customAppbarBuilder;

  static List<AuthStep> getDefaultSteps({
    RegistrationTranslations translations = const RegistrationTranslations(),
  }) =>
      [
        AuthStep(
          fields: [
            AuthTextField(
              name: 'email',
              title: translations.defaultEmailTitle,
              hintText: translations.defaultEmailHint,
              validators: [
                (email) => (email == null || email.isEmpty)
                    ? translations.defaultEmailEmpty
                    : null,
                (email) =>
                    RegExp(r"""(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4][0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9][0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])""")
                            .hasMatch(email!)
                        ? null
                        : translations.defaultEmailValidatorMessage,
              ],
            )
          ],
        ),
        AuthStep(
          fields: [
            AuthTextField(
              name: 'password',
              title: translations.defaultPasswordTitle,
              hintText: translations.defaultPasswordHint,
              obscureText: true,
              validators: [
                (value) => (value == null || value.isEmpty)
                    ? translations.defaultPasswordValidatorMessage
                    : null,
              ],
            ),
          ],
        ),
      ];
}
